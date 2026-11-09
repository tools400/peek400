# Regeln von TOBi (makei) für Peek/400, Verzeichnis qcmdsrc. Siehe README, Abschnitt "Bauen".

# PEEK, TREE und PEEKDST setzen ihre Bibliothek als Produktbibliothek und finden ihr Programm
# über die Bibliotheksliste. PEEKCLONE und PEEKINIT laufen ohne Peek in der Bibliotheksliste:
# TOBi qualifiziert ihr Programm mit der Objektbibliothek, die Bedienerführung steht im Befehl.

PEEK.CMD: private CMD_PGM_LIB := *LIBL
PEEK.CMD: private CMD_PMTFILE := PEEKGER
PEEK.CMD: private CMD_ALLOW := *INTERACT *IPGM *IREXX *EXEC *IMOD
PEEK.CMD: private CMD_HLPPNLGRP := PEEKGER
PEEK.CMD: private CMD_HLPID := PEEK
PEEK.CMD: private TEXT := Peek/400 - File Editor
PEEK.CMD: peek.cmd PEEK.PGM PEEKGER.PNLGRP PEEKGER.MSGF
	$(eval CMD_PRDLIB := $(OBJLIB))
	$(CMD_TO_CMD_RECIPE)

TREE.CMD: private CMD_PGM_LIB := *LIBL
TREE.CMD: private CMD_PMTFILE := PEEKGER
TREE.CMD: private CMD_ALLOW := *INTERACT *IPGM *IREXX *EXEC *IMOD
TREE.CMD: private CMD_HLPPNLGRP := TREEGER
TREE.CMD: private CMD_HLPID := TREE
TREE.CMD: private TEXT := Peek/400 - Display Database Relations
TREE.CMD: tree.cmd TREE.PGM TREEGER.PNLGRP PEEKGER.MSGF
	$(eval CMD_PRDLIB := $(OBJLIB))
	$(CMD_TO_CMD_RECIPE)

PEEKCLONE.CMD: private CMD_PMTFILE := *NONE
PEEKCLONE.CMD: private CMD_HLPPNLGRP := *NONE
PEEKCLONE.CMD: private CMD_HLPID := *NONE
PEEKCLONE.CMD: private CMD_PRDLIB := *NONE
PEEKCLONE.CMD: peekclone.cmd PEEKCLONE.PGM

PEEKDST.CMD: private CMD_PGM_LIB := *LIBL
PEEKDST.CMD: private CMD_PMTFILE := PEEKGER
PEEKDST.CMD: private CMD_HLPPNLGRP := *NONE
PEEKDST.CMD: private CMD_HLPID := *NONE
PEEKDST.CMD: private TEXT := Peek/400 - Distribuieren PEEK/400 Library
PEEKDST.CMD: peekdst.cmd PEEKDST.PGM PEEKGER.MSGF
	$(eval CMD_PRDLIB := $(OBJLIB))
	$(CMD_TO_CMD_RECIPE)

PEEKINIT.CMD: private CMD_PMTFILE := *NONE
PEEKINIT.CMD: private CMD_HLPPNLGRP := *NONE
PEEKINIT.CMD: private CMD_HLPID := *NONE
PEEKINIT.CMD: private CMD_PRDLIB := *NONE
PEEKINIT.CMD: peekinit.cmd PEEKINIT.PGM
