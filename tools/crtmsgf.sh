#!/QOpenSys/pkgs/bin/bash
# Erstellt eine Nachrichtendatei von Peek/400 mit ihrem CL-Programm.
#
# Aufruf: crtmsgf.sh <stream-datei> <bibliothek> <ccsid>
#
# Das CL-Programm (z.B. qmsg_ger/peekgermg.clp) erstellt die Nachrichtendatei und fügt die
# Nachrichten hinzu. Es wird in einem einzigen Job mit der CCSID der Sprache übersetzt und
# aufgerufen, damit die Texte in dieser CCSID gespeichert werden. Die Befehle laufen deshalb
# mit dem Builtin "cl" der bash im eigenen Job (TOBi startet PRECMD in einem eigenen Job).
stmf=$1 lib=$2 ccsid=$3
pgm=$(basename "$stmf"); pgm=${pgm%%.*}; pgm=${pgm^^}
cl "CHGJOB CCSID($ccsid) INQMSGRPY(*DFT)" || exit 1
cl -q "DLTF FILE(QTEMP/QMSGSRC)"
cl "CRTSRCPF FILE(QTEMP/QMSGSRC) RCDLEN(112) CCSID($ccsid)" || exit 1
cl "CPYFRMSTMF FROMSTMF('$stmf') TOMBR('/QSYS.LIB/QTEMP.LIB/QMSGSRC.FILE/$pgm.MBR') MBROPT(*REPLACE) STMFCCSID(1208)" || exit 1
cl "CRTCLPGM PGM(QTEMP/$pgm) SRCFILE(QTEMP/QMSGSRC) SRCMBR($pgm) REPLACE(*YES)" || exit 1
cl "CALL PGM(QTEMP/$pgm) PARM('$lib')" || exit 1
