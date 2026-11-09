#!/QOpenSys/pkgs/bin/bash
# Erstellt die Produktbibliothek eines Releases von Peek/400 und sichert sie.
#
# Aufruf auf dem IBM i, aus einem beliebigen Verzeichnis:
#
#   tools/mkproduct.sh <version> [<entwicklungsbibliothek>]
#
#   <version>                 Version des Releases, z.B. 4.1.2.
#   <entwicklungsbibliothek>  Standard: PEEK<vvv>P, z.B. PEEK412P für 4.1.2.
#
# Umgebungsvariablen, alle optional:
#
#   PRODLIB  Produktbibliothek, Standard PEEK. Sie darf noch nicht existieren.
#   OWNER    Eigentümer der Produktobjekte, Standard: der angemeldete Benutzer.
#   SAVFLIB  Bibliothek der Sicherungsdateien, Standard: der angemeldete Benutzer.
#
# Das Skript baut die Produktbibliothek mit "makei build" ohne Debug-Sichten, entfernt, was nicht
# ins Produkt gehört, legt die Quelldateien für die Kunden an, setzt Daten, Texte, Bindung,
# Eigentümer und Berechtigungen und ruft PEEKINIT LANGUAGE(GER) auf. Dann sichert es die
# Produktbibliothek in PEEK<vvv> und die Entwicklungsbibliothek in PEEK<vvv>P; beide
# Sicherungsdateien holt ".github/release.ps1 download" ab.
#
# Voraussetzungen: TOBi (makei) und der Befehl CRTMSGDS in der Bibliotheksliste.

export PATH=/QOpenSys/pkgs/bin:$PATH
set -o pipefail

# Die CL-Befehle laufen mit dem Builtin "cl" der bash im Job des Skripts (QTEMP, Bibliotheksliste).
# Eine Subshell wie $(cl ...) liefe in einem eigenen Job, deshalb gehen die Meldungen in eine
# Datei und erscheinen nur bei einem Fehler.
die() { echo "*** $*" >&2; exit 1; }
run() { cl "$1" > "$out" 2>&1 || { cat "$out"; die "Fehlgeschlagen: $1"; }; }
quiet() { "$@" > "$out" 2>&1 || { cat "$out"; die "Fehlgeschlagen: $*"; }; }

top=$(cd "$(dirname "$0")/.." && pwd) || exit 1
cd "$top" || exit 1
[ -f iproj.json ] || die "$top ist kein Projektverzeichnis von Peek/400."

version=$1
[[ $version =~ ^[0-9]\.[0-9]\.[0-9]$ ]] || die "Aufruf: tools/mkproduct.sh <version> [<entwicklungsbibliothek>], z.B. tools/mkproduct.sh 4.1.2"
vvv=${version//./}
user=$(id -un); user=${user^^}
devlib=${2:-PEEK${vvv}P}; devlib=${devlib^^}
prodlib=${PRODLIB:-PEEK}; prodlib=${prodlib^^}
owner=${OWNER:-$user}; owner=${owner^^}
savflib=${SAVFLIB:-$user}; savflib=${savflib^^}
prodsavf=PEEK$vvv
devsavf=PEEK${vvv}P
tgtrls=$(sed -n "s/.*(11 10)) VALUE('\([^']*\)').*/\1/p" qddssrc/peekpgm.dtaara)
[ -n "$tgtrls" ] || die "Kein Zielrelease in qddssrc/peekpgm.dtaara (Stelle 11)."
text="Peek/400 - PEEK, Version $version - ($tgtrls)"
tmp=/tmp/mkproduct_$$.txt
out=/tmp/mkproduct_$$.out
log=/tmp/mkproduct_$prodlib.log
trap 'rm -f "$tmp" "$out"' EXIT

# Job-CCSID wie beim Build (iproj.json): PEEKINIT erstellt die Befehle PEEK und TREE neu.
run "CHGJOB CCSID(273) INQMSGRPY(*DFT)"

# --------------------------------------------------------------------------------------------
echo "=== Prüfen: $text, Produkt $prodlib, Entwicklung $devlib, Sicherungsdateien in $savflib"
cl -q "CHKOBJ OBJ(QSYS/$prodlib) OBJTYPE(*LIB)" && die "Bibliothek $prodlib existiert schon."
cl -q "CHKOBJ OBJ(QSYS/$devlib) OBJTYPE(*LIB)" || die "Entwicklungsbibliothek $devlib fehlt."
cl -q "CHKOBJ OBJ(QSYS/$savflib) OBJTYPE(*LIB)" || die "Bibliothek $savflib für die Sicherungsdateien fehlt."
for f in $prodsavf $devsavf; do
  cl -q "CHKOBJ OBJ($savflib/$f) OBJTYPE(*FILE)" && die "Sicherungsdatei $savflib/$f existiert schon. Löschen, wenn sie ersetzt werden soll."
done
cl -q "CHKOBJ OBJ(CRTMSGDS) OBJTYPE(*CMD)" || die "Befehl CRTMSGDS nicht in der Bibliotheksliste."
command -v makei > /dev/null || die "makei (TOBi) nicht gefunden."

# QCOPYLE im Produkt: die Copybooks, die die Vorlage PEEKSRC/PGM und die Beispiele EXIT01-06
# einbinden. Sie dürfen selbst nichts einbinden, denn ihre /copy-Anweisungen zeigen ins IFS.
copybooks=()
for c in $(sed -n -E 's/^ {0,7}\/(include|copy) +([A-Za-z_]+\/)?QCOPYLE,([A-Za-z0-9_]+).*/\3/Ip' \
             peeksrc/pgm.rpgle qrpglesrc/exit0[1-6].rpgle | tr 'A-Z' 'a-z' | sort -u); do
  f=qcopyle/$c.rpgleinc
  [ -f "$f" ] || die "Copybook $f fehlt."
  grep -q -i -E '^ {0,7}/(include|copy) ' "$f" && die "$f bindet selbst Copybooks ein."
  copybooks+=("$f")
done

# --------------------------------------------------------------------------------------------
echo "=== Bauen: makei build in $prodlib ohne Debug-Sichten, Protokoll in $log"
run "CRTLIB LIB($prodlib) TYPE(*TEST) TEXT('$text') CRTAUT(*ALL)"
start=$SECONDS
PEEKLIB=$prodlib DBGVIEW='*NONE' makei build > "$log" 2>&1
grep -E 'Objects:|Build (Successful|Failed)' "$log"
grep -q -E 'Objects: +0 failed' "$log" && grep -q 'Build Successful' "$log" \
  || die "Build fehlgeschlagen, siehe $log und $top/.logs/output.log. Vor dem nächsten Versuch: DLTLIB $prodlib"
echo "    $((SECONDS - start)) Sekunden"

# --------------------------------------------------------------------------------------------
echo "=== Entfernen, was nicht ins Produkt gehört"
for f in /QSYS.LIB/$prodlib.LIB/*.MODULE; do
  run "DLTMOD MODULE($prodlib/$(basename "$f" .MODULE))"
done
for p in EXIT02 EXIT03 EXIT04 EXIT05 EXIT06; do        # Beispiele, nur als Quelle in QEXAMPLE
  run "DLTPGM PGM($prodlib/$p)"
done
run "DLTF FILE($prodlib/EXIT04LOG)"                    # Beispiel, nur als Quelle in QEXAMPLE
run "DLTF FILE($prodlib/QPEEKGEN)"                     # Peek erzeugt in QTEMP/QPEEKGEN
run "DLTCMD CMD($prodlib/PEEKDST)"                     # Werkzeug der Entwicklung
cl -q "DLTF FILE($prodlib/EVFEVENT)" > /dev/null 2>&1   # Fehlerliste des Builds

# --------------------------------------------------------------------------------------------
echo "=== Quelldateien für die Kunden"
quiet tools/crtsrcf.sh "$prodlib" QCOPYLE 112 273 'Peek/400 - ILE Copy-Books' "${copybooks[@]}"
quiet tools/crtsrcf.sh "$prodlib" QEXAMPLE 112 273 'Peek/400 - Beispiel- und Exit-Programme' \
  qrpglesrc/exit0[1-6].rpgle qddssrc/exit01pf.pf qddssrc/exit04log.sql
run "CRTMSGDS RANGE(USR1000 USR1999) MSGF($prodlib/PEEKGER) FILE($prodlib/QEXAMPLE) MBR(*GEN) REPLACE(*YES) TYPE(*ILERPG) DEFINE(*NO)"
for l in ENG:English FRA:French GER:German ITA:Italian SPA:Spanish; do
  lang=${l%%:*} name=${l#*:} dir=qmsg_${l%%:*}; dir=${dir,,}
  ccsid=$(sed -n 's/.*"tgtCcsid": *"\{0,1\}\([0-9]*\).*/\1/p' $dir/.ibmi.json)
  [ -n "$ccsid" ] || die "Keine CCSID in $dir/.ibmi.json."
  quiet tools/crtsrcf.sh "$prodlib" QMSG_$lang 112 "$ccsid" "Peek/400 - $name ($ccsid)" \
    $dir/peek${lang,,}mg.clp $dir/peek${lang,,}pg.pnlgrp $dir/tree${lang,,}pg.pnlgrp
done
quiet tools/crtsrcf.sh "$prodlib" QCMDSRC 92 273 'Peek/400 - Befehle' qcmdsrc/peek.cmd qcmdsrc/tree.cmd

# --------------------------------------------------------------------------------------------
echo "=== Generierungsangaben und Texte"
# PEEKPGM steuert die Übersetzung der Update-Programme beim Kunden: ohne Debug-Sicht und
# ohne OPTION(*SRCSTMT : *NODEBUGIO).
run "CHGDTAARA DTAARA($prodlib/PEEKPGM (1 10)) VALUE('*NONE')"
run "CHGDTAARA DTAARA($prodlib/PEEKPGM (101 50)) VALUE('DEBUG(*NO ) DECEDIT(''0,'') DATEDIT(*DMY.)')"
run "CHGDTAARA DTAARA($prodlib/PEEKPGM (201 50)) VALUE('EXTBININT(*YES)')"
run "CHGDTAARA DTAARA($prodlib/PEEKPGM (301 100)) VALUE('COPYRIGHT(''(c) 1997-$(date +%Y) by Thomas Raddatz'')')"
# Version ab Stelle 25 im Text: PEEK67 legt die Kopien dieser Dateien in QTEMP neu an, wenn
# sich die Version unterscheidet.
for f in PEEKFLD PEEKFMT PEEKWRK; do
  t=$(sed -n 's/.*%TEXT \(.*[^ ]\) *\*\r\{0,1\}$/\1/p' qddssrc/${f,,}.pf | head -1)
  run "CHGOBJD OBJ($prodlib/$f) OBJTYPE(*FILE) TEXT('$(printf '%-24.24s%s' "$t" "$version")')"
done

# --------------------------------------------------------------------------------------------
echo "=== Serviceprogramme mit $prodlib/ statt *LIBL/ binden"
for f in /QSYS.LIB/$prodlib.LIB/*.SRVPGM; do
  run "UPDSRVPGM SRVPGM($prodlib/$(basename "$f" .SRVPGM)) MODULE(*NONE) BNDSRVPGM($prodlib/PEEK*) SRVPGMLIB($prodlib)"
done
for f in /QSYS.LIB/$prodlib.LIB/*.PGM; do
  run "UPDPGM PGM($prodlib/$(basename "$f" .PGM)) MODULE(*NONE) BNDSRVPGM($prodlib/PEEK*) SRVPGMLIB($prodlib)"
done

# --------------------------------------------------------------------------------------------
echo "=== PEEKINIT LANGUAGE(GER)"
run "ADDLIBLE LIB($prodlib) POSITION(*FIRST)"
run "$prodlib/PEEKINIT LANGUAGE(GER)"                 # erstellt die Befehle PEEK und TREE neu
cl -q "RCLACTGRP ACTGRP(PEEK)" > /dev/null 2>&1
run "RMVLIBLE LIB($prodlib)"

# --------------------------------------------------------------------------------------------
echo "=== Eigentümer $owner und Berechtigungen"
# *PUBLIC *CHANGE, die Dateien mit Daten *PUBLIC *ALL; Programme ohne übernommene Berechtigung.
setaut() {
  local lib=$1 obj=$2 type=$3 aut=$4
  run "CHGOBJOWN OBJ($lib/$obj) OBJTYPE($type) NEWOWN($owner) CUROWNAUT(*REVOKE)"
  run "RVKOBJAUT OBJ($lib/$obj) OBJTYPE($type) USER(*ALL) AUT(*ALL)"
  run "GRTOBJAUT OBJ($lib/$obj) OBJTYPE($type) USER(*PUBLIC) AUT($aut)"
}
setaut QSYS "$prodlib" '*LIB' '*CHANGE'
for f in /QSYS.LIB/$prodlib.LIB/*; do
  name=$(basename "$f"); obj=${name%.*}; type="*${name##*.}"
  aut='*CHANGE'
  case "$obj:$type" in
    PEEKENV:\*FILE|PEEKFLD:\*FILE|PEEKFLDL[012]:\*FILE|PEEKFMT:\*FILE|PEEKUSR:\*FILE|PEEKWRK:\*FILE) aut='*ALL';;
  esac
  setaut "$prodlib" "$obj" "$type" "$aut"
  case $type in
    \*PGM) run "CHGPGM PGM($prodlib/$obj) USEADPAUT(*NO)";;
    \*SRVPGM) run "CHGSRVPGM SRVPGM($prodlib/$obj) USEADPAUT(*NO)";;
  esac
done

# --------------------------------------------------------------------------------------------
echo "=== Erzeugte Update-Programme aus $devlib löschen"
# Peek erzeugt sie bei Auswahl 2 und markiert sie ab Stelle 44 des Texts mit *UPDPGM.
cl -q "DLTF FILE(QTEMP/MKPUPD)" > /dev/null 2>&1
run "RUNSQL SQL('create table qtemp.mkpupd as (select objname, objtype from table(qsys2.object_statistics(''$devlib'', ''*PGM *FILE'')) x where substr(objtext, 44, 7) = ''*UPDPGM'') with data') COMMIT(*NONE) NAMING(*SQL)"
run "CPYTOIMPF FROMFILE(QTEMP/MKPUPD) TOSTMF('$tmp') MBROPT(*REPLACE) STMFCCSID(1208) RCDDLM(*LF) STRDLM(*NONE)"
while IFS=, read -r obj type; do
  obj=${obj// /} type=${type// /}
  case $type in
    \*PGM) run "DLTPGM PGM($devlib/$obj)";;
    \*FILE) run "DLTF FILE($devlib/$obj)";;
  esac
done < "$tmp"

# --------------------------------------------------------------------------------------------
echo "=== Sichern: $prodlib -> $savflib/$prodsavf, $devlib -> $savflib/$devsavf"
run "CRTSAVF FILE($savflib/$prodsavf) TEXT('$text')"
run "SAVLIB LIB($prodlib) DEV(*SAVF) SAVF($savflib/$prodsavf) TGTRLS($tgtrls) DTACPR(*YES)"
# Objekte mit einem neueren Zielrelease, z.B. mit RUCRTRPG übersetzte Tests, lassen sich nicht
# sichern (CPF3741): vorher aus der Entwicklungsbibliothek löschen.
run "CRTSAVF FILE($savflib/$devsavf) TEXT('$text')"
run "SAVLIB LIB($devlib) DEV(*SAVF) SAVF($savflib/$devsavf) TGTRLS($tgtrls) DTACPR(*HIGH)"

echo "=== Fertig. Weiter auf dem PC: .github/release.ps1 download -Version $version"
