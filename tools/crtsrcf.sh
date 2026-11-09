#!/QOpenSys/pkgs/bin/bash
# Legt eine Quelldatei an und kopiert Stream-Dateien als Teildateien hinein.
#
# Aufruf: crtsrcf.sh <bibliothek> <datei> <satzlänge> <ccsid> <text> [<stream-datei> ...]
#
# Die Quelldatei wird jedes Mal neu angelegt: Das Ersetzen von Teildateien ändert ihr
# Änderungsdatum nicht, und make hielte sie sonst nie für aktuell. Die Teildatei heißt wie die
# Stream-Datei, ihr Typ ist die Endung ohne "inc" (x.rpgleinc -> RPGLE), ihr Text der
# %TEXT-Kommentar der Stream-Datei. Den Kommentarblock %METADATA ... %EMETADATA übernimmt die
# Teildatei nicht, ihr Text steht ja in der Teildateibeschreibung. Bei einem Fehler wird die
# Quelldatei gelöscht, damit der nächste Build sie wieder anlegt.
lib=$1 file=$2 rcdlen=$3 ccsid=$4 text=$5
shift 5
tmp=/tmp/crtsrcf_$$.txt
trap 'rm -f "$tmp"' EXIT
cl -q "DLTF FILE($lib/$file)"
cl "CRTSRCPF FILE($lib/$file) RCDLEN($rcdlen) CCSID($ccsid) TEXT('$text')" || exit 1
rc=0
for stmf in "$@"; do
  name=$(basename "$stmf")
  mbr=${name%%.*}; mbr=${mbr^^}
  type=${name#*.}; type=${type^^}; type=${type%INC}
  mtext=$(head -20 "$stmf" | grep -m1 '%TEXT' | sed -e 's/.*%TEXT *//' -e 's/\r$//' -e 's/ *\*\/ *$//' -e 's/ *\*$//' -e "s/'/''/g")
  sed -e '/%METADATA/,/%EMETADATA/d' "$stmf" > "$tmp" || { rc=1; continue; }
  cl "CPYFRMSTMF FROMSTMF('$tmp') TOMBR('/QSYS.LIB/$lib.LIB/$file.FILE/$mbr.MBR') MBROPT(*REPLACE) STMFCCSID(1208)" || { rc=1; continue; }
  cl "CHGPFM FILE($lib/$file) MBR($mbr) SRCTYPE($type) TEXT('$mtext')" || rc=1
done
if [ $rc -ne 0 ]; then
  cl -q "DLTF FILE($lib/$file)"
fi
exit $rc
