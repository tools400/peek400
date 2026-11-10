# Regeln von TOBi (makei) für Peek/400, Verzeichnis qsrvsrc. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

%.SRVPGM: private ACTGRP := PEEK
%.SRVPGM: private SRVPGM_ACTGRP := PEEK
%.SRVPGM: private TGTRLS := V7R3M0
# Nur QC2LE: das Bindeverzeichnis PEEK enthält das alte Serviceprogramm (doppelte Exporte).
%.SRVPGM: private BNDDIR := QC2LE
%.SRVPGM: private SRVPGM_ALWRINZ := *NO) ALWLIBUPD(*YES

PEEK.BNDDIR: peek.bnddir

PEEK51.SRVPGM: private TEXT := Peek/400 - SQL-Komponente                   SrvPgm
PEEK51.SRVPGM: peek51.bnd PEEK51.MODULE PEEK58.SRVPGM PEEK63.SRVPGM

PEEK53.SRVPGM: private TEXT := Peek/400 - Zugriff auf Benutzerdaten        SrvPgm
PEEK53.SRVPGM: peek53.bnd PEEK53.MODULE PEEK58.SRVPGM

PEEK58.SRVPGM: private TEXT := Peek/400 - Allgemeine Routinen              SrvPgm
PEEK58.SRVPGM: peek58.bnd PEEK58.MODULE

PEEK61.SRVPGM: private TEXT := Peek/400 - Progress Meter
PEEK61.SRVPGM: peek61.bnd PEEK61.MODULE

PEEK63.SRVPGM: private TEXT := Peek/400 - Dateizugriffsroutinen            SrvPgm
PEEK63.SRVPGM: peek63.bnd PEEK63.MODULE PEEK63C.MODULE PEEK58.SRVPGM

PEEK71.SRVPGM: private TEXT := Peek/400 - Character Translation Services   SrvPgm
PEEK71.SRVPGM: peek71.bnd PEEK71.MODULE PEEK58.SRVPGM
