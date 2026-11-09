# Regeln von TOBi (makei) für Peek/400, Verzeichnis qrpglesrc. Siehe README, Abschnitt "Bauen".

%.MODULE: private TGTRLS := V7R3M0
%.PGM: private TGTRLS := V7R3M0
%.PGM: private ACTGRP := PEEK
%.PGM: private DETAIL := *BASIC
%.PGM: private BNDDIR := QC2LE PEEK
# ALWLIBUPD(*YES) für UPDPGM ... SRVPGMLIB in PEEKCLONE2; TOBi kennt den Parameter nicht.
%.PGM: private ALWRINZ := *NO) ALWLIBUPD(*YES

EXIT01.MODULE: exit01.rpgle QCOPYLE.FILE EXIT01PF.FILE
EXIT01.PGM: private TEXT := Peek/400 - EXIT-Programm: Berechtigungsprüfung
EXIT01.PGM: EXIT01.MODULE PEEK.BNDDIR

EXIT02.MODULE: exit02.rpgle QCOPYLE.FILE
EXIT02.PGM: private TEXT := Peek/400 - EXIT-Programm: Ermitteln Settings Datei
EXIT02.PGM: EXIT02.MODULE PEEK.BNDDIR

EXIT03.MODULE: exit03.rpgle QCOPYLE.FILE
EXIT03.PGM: private TEXT := Peek/400 - EXIT-Programm: Ermitteln EDIT CODE
EXIT03.PGM: EXIT03.MODULE PEEK.BNDDIR

EXIT04.MODULE: exit04.rpgle QCOPYLE.FILE EXIT04LOG.FILE
EXIT04.PGM: private TEXT := Peek/400 - EXIT-Programm: Protokollierung
EXIT04.PGM: EXIT04.MODULE PEEK.BNDDIR

EXIT05.MODULE: exit05.rpgle QCOPYLE.FILE
EXIT05.PGM: private TEXT := Peek/400 - EXIT-Programm: Benutzerauswahl
EXIT05.PGM: EXIT05.MODULE PEEK.BNDDIR

EXIT06.MODULE: exit06.rpgle QCOPYLE.FILE
EXIT06.PGM: private TEXT := Peek/400 - EXIT-Programm: Spaltenüberschriften
EXIT06.PGM: EXIT06.MODULE PEEK.BNDDIR

PEEK.MODULE: peek.clle
PEEK.PGM: private ACTGRP := *CALLER
PEEK.PGM: private TEXT := Peek/400 - Befehlsausführungsprogramm ACTGRP: *CAL
PEEK.PGM: PEEK.MODULE PEEK.BNDDIR

PEEK00.MODULE: peek00.clle
PEEK00.PGM: private TEXT := Peek/400 - Start-CL                   ACTGRP: PEEK
PEEK00.PGM: PEEK00.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK01.MODULE: peek01.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit06.rpgleinc qcopyle/ppeek01.rpgleinc qcopyle/ppeek02.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/usr0001.rpgleinc qcopyle/usr8104.rpgleinc PEEKFLD.FILE
PEEK01.PGM: private TEXT := Peek/400 - Übertragen Satzaufbau in DB2/400-Format
PEEK01.PGM: PEEK01.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK02.MODULE: peek02.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek02.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslfld.rpgleinc qcopyle/qusptrus.rpgleinc
PEEK02.PGM: private TEXT := Peek/400 - Ermitteln Satzaufbau
PEEK02.PGM: PEEK02.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK03.MODULE: peek03.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek03.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0006.rpgleinc PEEKFLD.FILE
PEEK03.PGM: private TEXT := Peek/400 - Übertragen Schlüsself.in DB2/400-Format
PEEK03.PGM: PEEK03.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK04.MODULE: peek04.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek04.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0006.rpgleinc
PEEK04.PGM: private TEXT := Peek/400 - Ermitteln Schlüsselfelder
PEEK04.PGM: PEEK04.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK05.MODULE: peek05.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/dopgmcmd.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0200.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/pexit01.rpgleinc qcopyle/pexit04.rpgleinc qcopyle/ppeek01.rpgleinc qcopyle/ppeek03.rpgleinc qcopyle/ppeek04.rpgleinc qcopyle/ppeek05.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek08.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek10.rpgleinc qcopyle/ppeek12.rpgleinc qcopyle/ppeek13.rpgleinc qcopyle/ppeek14.rpgleinc qcopyle/ppeek17.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek19.rpgleinc qcopyle/ppeek20.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek24.rpgleinc qcopyle/ppeek26.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek30.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek33.rpgleinc qcopyle/ppeek34.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek42.rpgleinc qcopyle/ppeek47.rpgleinc qcopyle/ppeek48.rpgleinc qcopyle/ppeek49.rpgleinc qcopyle/ppeek50.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek52.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek54.rpgleinc qcopyle/ppeek55.rpgleinc qcopyle/ppeek56.rpgleinc qcopyle/ppeek57.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek59.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/ppeek68.rpgleinc qcopyle/ppeek69.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/pupdpgm.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0005.rpgleinc qcopyle/set0006.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0008.rpgleinc qcopyle/set0009.rpgleinc qcopyle/set0010.rpgleinc qcopyle/set0011.rpgleinc qcopyle/set0013.rpgleinc qcopyle/set0014.rpgleinc qcopyle/set0015.rpgleinc qcopyle/set0016.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0007.rpgleinc qcopyle/usr0008.rpgleinc qcopyle/usr0009.rpgleinc qcopyle/usr0010.rpgleinc qcopyle/usr0013.rpgleinc qcopyle/usr0014.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8108.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8128.rpgleinc qcopyle/usr8144.rpgleinc qcopyle/usr8147.rpgleinc qcopyle/usr8148.rpgleinc qcopyle/usr8190.rpgleinc qcopyle/usr8196.rpgleinc qcopyle/usr8200.rpgleinc qcopyle/usr8201.rpgleinc qcopyle/usr8202.rpgleinc qcopyle/usr8203.rpgleinc qcopyle/usr8206.rpgleinc qcopyle/usr8207.rpgleinc qcopyle/usr8212.rpgleinc qcopyle/usr8217.rpgleinc qcopyle/usr8218.rpgleinc qcopyle/usr8223.rpgleinc qcopyle/usr8224.rpgleinc qcopyle/usr8235.rpgleinc qcopyle/usr9993.rpgleinc qcopyle/usr9996.rpgleinc qcopyle/usr9998.rpgleinc qcopyle/usr9999.rpgleinc PEEK05FM.FILE PEEKFLD.FILE PEEKFLDL1.FILE
PEEK05.PGM: private TEXT := Peek/400 - Hauptprogramm
PEEK05.PGM: PEEK05.MODULE PEEK51.SRVPGM PEEK53.SRVPGM PEEK58.SRVPGM PEEK63.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK06.MODULE: peek06.rpgle qcopyle/copyright.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qeccvtec.rpgleinc qcopyle/qeccvtew.rpgleinc qcopyle/qecedt.rpgleinc
PEEK06.PGM: private TEXT := Peek/400 - Konvertieren intern ==> extern m. Edit
PEEK06.PGM: PEEK06.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK07.MODULE: peek07.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qwcrneta.rpgleinc
PEEK07.PGM: private TEXT := Peek/400 - Ermitteln Netzwerkattribute
PEEK07.PGM: PEEK07.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK08.MODULE: peek08.clle
PEEK08.PGM: private TEXT := Peek/400 - Generieren RPG-LE Programm
PEEK08.PGM: PEEK08.MODULE PEEK61.SRVPGM PEEK.BNDDIR

PEEK09.MODULE: peek09.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qusrobjd.rpgleinc
PEEK09.PGM: private TEXT := Peek/400 - Ermitteln Objektattribute
PEEK09.PGM: PEEK09.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK10.MODULE: peek10.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek10.rpgleinc qcopyle/ppeek11.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0002.rpgleinc qcopyle/usr8105.rpgleinc PEEKFMT.FILE
PEEK10.PGM: private TEXT := Peek/400 - Übertragen Satzformat in DB2/400-Format
PEEK10.PGM: PEEK10.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK11.MODULE: peek11.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek11.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslrcd.rpgleinc qcopyle/qusptrus.rpgleinc qcopyle/rcdl0200.rpgleinc
PEEK11.PGM: private TEXT := Peek/400 - Ermitteln Satzformate
PEEK11.PGM: PEEK11.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK12.MODULE: peek12.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek12.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc PEEK12FM.FILE PEEKFMT.FILE
PEEK12.PGM: private TEXT := Peek/400 - Auswahl Satzformat
PEEK12.PGM: PEEK12.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK13.MODULE: peek13.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0200.rpgleinc qcopyle/ppeek13.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qusrmbrd.rpgleinc
PEEK13.PGM: private TEXT := Peek/400 - Ermitteln Teildateibeschreibung
PEEK13.PGM: PEEK13.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK14.MODULE: peek14.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek14.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek45.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek64.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8206.rpgleinc qcopyle/usr8220.rpgleinc qcopyle/usr8221.rpgleinc qcopyle/usr8222.rpgleinc PEEK14FM.FILE PEEKFLD.FILE PEEKFLDL0.FILE
PEEK14.PGM: private TEXT := Peek/400 - Anzeigen Datensatz
PEEK14.PGM: PEEK14.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK63.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK15.MODULE: peek15.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek15.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8188.rpgleinc PEEKFLD.FILE PEEKSRC.FILE QPEEKGEN.FILE
PEEK15.PGM: private TEXT := Peek/400 - Generieren RPG-LE Displayfile
PEEK15.PGM: PEEK15.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK61.SRVPGM PEEK.BNDDIR

PEEK16.MODULE: peek16.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek16.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/sds.rpgleinc PEEKFLD.FILE PEEKSRC.FILE QPEEKGEN.FILE
PEEK16.PGM: private TEXT := Peek/400 - Generieren RPG-LE Programm
PEEK16.PGM: PEEK16.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK61.SRVPGM PEEK.BNDDIR

PEEK17.MODULE: peek17.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek17.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0008.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8108.rpgleinc qcopyle/usr8124.rpgleinc qcopyle/usr8126.rpgleinc qcopyle/usr8129.rpgleinc qcopyle/usr8134.rpgleinc qcopyle/usr8135.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8138.rpgleinc qcopyle/usr8140.rpgleinc qcopyle/usr8141.rpgleinc qcopyle/usr8142.rpgleinc qcopyle/usr8192.rpgleinc PEEK17FM.FILE PEEKFLD.FILE
PEEK17.PGM: private TEXT := Peek/400 - Erfassen der Suchkriterien
PEEK17.PGM: PEEK17.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK18.MODULE: peek18.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek36.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0003.rpgleinc qcopyle/usr8138.rpgleinc PEEKFLD.FILE
PEEK18.PGM: private TEXT := Peek/400 - Konvertieren intern <==> extern
PEEK18.PGM: PEEK18.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK19.MODULE: peek19.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek19.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc PEEKFLDL2.FILE
PEEK19.PGM: private TEXT := Peek/400 - Erstellen externen Aufsetzschlüssel
PEEK19.PGM: PEEK19.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK20.MODULE: peek20.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek20.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0003.rpgleinc PEEKFLDL0.FILE PEEKFLDL2.FILE
PEEK20.PGM: private TEXT := Peek/400 - Erstellen internen Aufsetzschlüssel
PEEK20.PGM: PEEK20.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK21.MODULE: peek21.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8143.rpgleinc
PEEK21.PGM: private TEXT := Peek/400 - Mappen TASTE/BEFEHL
PEEK21.PGM: PEEK21.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK22.MODULE: peek22.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek22.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc PEEKUSR.FILE
PEEK22.PGM: private TEXT := Peek/400 - Generieren der Defaulttastenbelegung
PEEK22.PGM: PEEK22.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK23.MODULE: peek23.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc
PEEK23.PGM: private TEXT := Peek/400 - Einlesen der Funktionstastenbelegung
PEEK23.PGM: PEEK23.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK24.MODULE: peek24.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek24.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc PEEK24FM.FILE
PEEK24.PGM: private TEXT := Peek/400 - Änderung der Farbeinstellung
PEEK24.PGM: PEEK24.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK25.MODULE: peek25.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc PEEK25FM.FILE
PEEK25.PGM: private TEXT := Peek/400 - Auswahl einer Farbe
PEEK25.PGM: PEEK25.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK26.MODULE: peek26.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek26.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8151.rpgleinc qcopyle/usr8152.rpgleinc qcopyle/usr8153.rpgleinc qcopyle/usr8154.rpgleinc qcopyle/usr8155.rpgleinc PEEK26FM.FILE
PEEK26.PGM: private TEXT := Peek/400 - Kopieren Datensatz in externe Datei
PEEK26.PGM: PEEK26.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK27.MODULE: peek27.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc
PEEK27.PGM: private TEXT := Peek/400 - Einlesen der Subfile-Auswahlen
PEEK27.PGM: PEEK27.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK28.MODULE: peek28.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek28.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qwcrsval.rpgleinc
PEEK28.PGM: private TEXT := Peek/400 - Ermitteln Systemwerte
PEEK28.PGM: PEEK28.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK29.MODULE: peek29.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek29.rpgleinc qcopyle/sds.rpgleinc
PEEK29.PGM: private TEXT := Peek/400 - Berechnen interner Werte
PEEK29.PGM: PEEK29.MODULE PEEK.BNDDIR

PEEK30.MODULE: peek30.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek28.rpgleinc qcopyle/ppeek29.rpgleinc qcopyle/ppeek30.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/qusptrus.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8158.rpgleinc qcopyle/usr9997.rpgleinc PEEK30FM.FILE
PEEK30.PGM: private TEXT := Peek/400 - Prüfen der Lizenzdaten
PEEK30.PGM: PEEK30.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK31.MODULE: peek31.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek31.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0004.rpgleinc
PEEK31.PGM: private TEXT := Peek/400 - Ermitteln der Benutzersprache
PEEK31.PGM: PEEK31.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK32.MODULE: peek32.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0006.rpgleinc qcopyle/usr8163.rpgleinc
PEEK32.PGM: private TEXT := Peek/400 - Konvertieren nicht darstellb. Zeichen
PEEK32.PGM: PEEK32.MODULE PEEK53.SRVPGM PEEK.BNDDIR

PEEK33.MODULE: peek33.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek33.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0012.rpgleinc qcopyle/set0016.rpgleinc
PEEK33.PGM: private TEXT := Peek/400 - Aktualisierung beim Versionswechsel
PEEK33.PGM: PEEK33.MODULE PEEK53.SRVPGM PEEK.BNDDIR

PEEK34.MODULE: peek34.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek34.rpgleinc qcopyle/ppeek35.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/wrk0001.rpgleinc PEEK34FM.FILE PEEKFLD.FILE PEEKFLDL1.FILE PEEKWRK.FILE
PEEK34.PGM: private TEXT := Peek/400 - Layout
PEEK34.PGM: PEEK34.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK35.MODULE: peek35.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek35.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8168.rpgleinc qcopyle/usr8169.rpgleinc qcopyle/usr8170.rpgleinc qcopyle/usr8243.rpgleinc qcopyle/wrk0001.rpgleinc
PEEK35.PGM: private TEXT := Peek/400 - Prüfen Datensatz PEEKFLD
PEEK35.PGM: PEEK35.MODULE PEEK.BNDDIR

PEEK36.MODULE: peek36.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek36.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/usr8171.rpgleinc
PEEK36.PGM: private TEXT := Peek/400 - Prüfen Datum-, Zeit, Zeitstempelfelder
PEEK36.PGM: PEEK36.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK37.MODULE: peek37.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc PEEK37FM.FILE PEEKFLD.FILE
PEEK37.PGM: private TEXT := Peek/400 - Feldauswahl
PEEK37.PGM: PEEK37.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK38.MODULE: peek38.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc
PEEK38.PGM: private TEXT := Peek/400 - Erstellen SQL ORDER BY
PEEK38.PGM: PEEK38.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK39.MODULE: peek39.rpgle qcopyle/copyright.rpgleinc qcopyle/dbrl0200.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek39.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qdbldbr.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/qusptrus.rpgleinc
PEEK39.PGM: private TEXT := Peek/400 - Ermitteln Datenbankrelationen
PEEK39.PGM: PEEK39.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK40.MODULE: peek40.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/dbrl0200.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek39.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/sell0100.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0008.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8172.rpgleinc qcopyle/usr8194.rpgleinc qcopyle/usr8209.rpgleinc PEEK40FM.FILE
PEEK40.PGM: private TEXT := Peek/400 - Anzeige Datenbankrelationen
PEEK40.PGM: PEEK40.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK41.MODULE: peek41.rpgle qcopyle/bspf0100.rpgleinc qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qdbrtvfd.rpgleinc qcopyle/sell0100.rpgleinc
PEEK41.PGM: private TEXT := Peek/400 - Ermitteln Dateiinformationen
PEEK41.PGM: PEEK41.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK42.MODULE: peek42.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek42.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek66.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8228.rpgleinc qcopyle/usr8229.rpgleinc qcopyle/usr8230.rpgleinc PEEKFLD.FILE
PEEK42.PGM: private TEXT := Peek/400 - Aufbereiten Kurzauswahl
PEEK42.PGM: PEEK42.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK63.SRVPGM PEEK.BNDDIR

PEEK44.MODULE: peek44.clle
PEEK44.PGM: private TEXT := Peek/400 - Anzeigen Datenbankrelat.
PEEK44.PGM: PEEK44.MODULE PEEK.BNDDIR

PEEK45.MODULE: peek45.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek45.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0006.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8136.rpgleinc PEEK45FM.FILE PEEKFLD.FILE
PEEK45.PGM: private TEXT := Peek/400 - Hex-Feldeditierung
PEEK45.PGM: PEEK45.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK46.MODULE: peek46.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslmbr.rpgleinc qcopyle/qusptrus.rpgleinc
PEEK46.PGM: private TEXT := Peek/400 - Ermitteln Teildateiliste
PEEK46.PGM: PEEK46.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK47.MODULE: peek47.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek47.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8180.rpgleinc qcopyle/usr8209.rpgleinc PEEK47FM.FILE
PEEK47.PGM: private TEXT := Peek/400 - Auswahl Teildatei
PEEK47.PGM: PEEK47.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK48.MODULE: peek48.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek48.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0008.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc PEEK48FM.FILE
PEEK48.PGM: private TEXT := Peek/400 - SQL-Select/Order by
PEEK48.PGM: PEEK48.MODULE PEEK51.SRVPGM PEEK53.SRVPGM PEEK58.SRVPGM PEEK63.SRVPGM PEEK.BNDDIR

PEEK49.MODULE: peek49.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek49.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc PEEK49FM.FILE
PEEK49.PGM: private TEXT := Peek/400 - 'About'
PEEK49.PGM: PEEK49.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK50.MODULE: peek50.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek50.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8205.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/wrk0002.rpgleinc PEEK50FM.FILE PEEKFLD.FILE PEEKFLDL1.FILE PEEKWRK.FILE
PEEK50.PGM: private TEXT := Peek/400 - Erweiterte PIN-Funktion
PEEK50.PGM: PEEK50.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK52.MODULE: peek52.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek52.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0012.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8216.rpgleinc qcopyle/usr8219.rpgleinc PEEK52FM.FILE
PEEK52.PGM: private TEXT := Peek/400 - Abfrage 'Programm erstellen'
PEEK52.PGM: PEEK52.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK54.MODULE: peek54.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/env0001.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek54.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr9992.rpgleinc PEEKENV.FILE PEEKFLD.FILE
PEEK54.PGM: private TEXT := Peek/400 - Sichern Arbeitsumgebung
PEEK54.PGM: PEEK54.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK55.MODULE: peek55.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/env0001.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek55.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0015.rpgleinc qcopyle/usr8234.rpgleinc PEEKENV.FILE PEEKFLD.FILE
PEEK55.PGM: private TEXT := Peek/400 - Laden Arbeitsumgebung
PEEK55.PGM: PEEK55.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK56.MODULE: peek56.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek56.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0015.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8180.rpgleinc qcopyle/usr8181.rpgleinc qcopyle/usr8182.rpgleinc qcopyle/usr8184.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/usr8233.rpgleinc PEEK56FM.FILE PEEKENV.FILE
PEEK56.PGM: private TEXT := Peek/400 - Auswählen 'Arbeitsumgebung'
PEEK56.PGM: PEEK56.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK57.MODULE: peek57.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek57.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc PEEK57FM.FILE
PEEK57.PGM: private TEXT := Peek/400 - Löschen   'Arbeitsumgebung'
PEEK57.PGM: PEEK57.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK59.MODULE: peek59.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek59.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8190.rpgleinc PEEK59FM.FILE
PEEK59.PGM: private TEXT := Peek/400 - Generische Abfrage-Window
PEEK59.PGM: PEEK59.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK60.MODULE: peek60.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek60.rpgleinc
PEEK60.PGM: private TEXT := Peek/400 - Ermitteln Aufwand für Pgm-Generieren
PEEK60.PGM: PEEK60.MODULE PEEK.BNDDIR

PEEK62.MODULE: peek62.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek62.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr9989.rpgleinc qcopyle/usr9995.rpgleinc PEEKUSR.FILE
PEEK62.PGM: private TEXT := Peek/400 - Ändern Satzformat PEEKUSR
PEEK62.PGM: PEEK62.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK64.MODULE: peek64.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek64.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8123.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8240.rpgleinc qcopyle/usr8241.rpgleinc PEEK64FM.FILE PEEKFLD.FILE
PEEK64.PGM: private TEXT := Peek/400 - Feldeditor
PEEK64.PGM: PEEK64.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK71.SRVPGM PEEK.BNDDIR

PEEK65.MODULE: peek65.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0005.rpgleinc PEEK65P.FILE PEEKFLDL0.FILE
PEEK65.PGM: private TEXT := Peek/400 - Drucken Datensatz
PEEK65.PGM: PEEK65.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK63.SRVPGM PEEK.BNDDIR

PEEK66.MODULE: peek66.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek66.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8227.rpgleinc
PEEK66.PGM: private TEXT := Peek/400 - Konvertieren Datenformat für Kurzbefehl
PEEK66.PGM: PEEK66.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK67.MODULE: peek67.clle
PEEK67.PGM: private TEXT := Peek/400 - Prüfen Objekte in QTEMP
PEEK67.PGM: PEEK67.MODULE PEEK.BNDDIR

PEEK68.MODULE: peek68.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek68.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc PEEK68FM.FILE
PEEK68.PGM: private TEXT := Peek/400 - Matchcode Subfile-Auswahl
PEEK68.PGM: PEEK68.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK69.MODULE: peek69.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek69.rpgleinc qcopyle/ppeek70.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0010.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8194.rpgleinc qcopyle/usr8209.rpgleinc PEEK69FM.FILE
PEEK69.PGM: private TEXT := Peek/400 - Auswahl Datei
PEEK69.PGM: PEEK69.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK70.MODULE: peek70.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objl0200.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek70.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslobj.rpgleinc qcopyle/qusptrus.rpgleinc
PEEK70.PGM: private TEXT := Peek/400 - Ermitteln Dateiliste
PEEK70.PGM: PEEK70.MODULE PEEK53.SRVPGM PEEK58.SRVPGM PEEK.BNDDIR

PEEK80.MODULE: peek80.clle
PEEK80.PGM: private TEXT := Peek/400 - Anpassen CCSID
PEEK80.PGM: PEEK80.MODULE PEEK.BNDDIR

PEEKCLONE.MODULE: peekclone.clle
PEEKCLONE1.MODULE: peekclone1.clle
PEEKCLONE2.MODULE: peekclone2.clle
PEEKCLONE.PGM: private ACTGRP := *CALLER
PEEKCLONE.PGM: private TEXT := Peek/400 - Duplizieren PEEK/400 Bibliothek
PEEKCLONE.PGM: PEEKCLONE.MODULE PEEKCLONE1.MODULE PEEKCLONE2.MODULE PEEK.BNDDIR

PEEKDST.MODULE: peekdst.clle
PEEKDST.PGM: private TEXT := Peek/400 - Distribuieren PEEK/400 Library
PEEKDST.PGM: PEEKDST.MODULE PEEK.BNDDIR

PEEKINIT.MODULE: peekinit.clle
PEEKINIT.PGM: private ACTGRP := *CALLER
PEEKINIT.PGM: private TEXT := Peek/400 - Initialisieren Peek/400
PEEKINIT.PGM: PEEKINIT.MODULE PEEK.BNDDIR

PEEKINIT1.MODULE: peekinit1.clle
PEEKINIT1.PGM: private ACTGRP := *CALLER
PEEKINIT1.PGM: private TEXT := Peek/400 - Initialisieren Peek/400 - Sprache
PEEKINIT1.PGM: PEEKINIT1.MODULE PEEK.BNDDIR

PEEKINIT2.MODULE: peekinit2.clle
PEEKINIT2.PGM: private ACTGRP := *CALLER
PEEKINIT2.PGM: private TEXT := Peek/400 - Initialisieren Peek/400 - CCSID
PEEKINIT2.PGM: PEEKINIT2.MODULE PEEK.BNDDIR

PEEKINIT3.MODULE: peekinit3.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/set0004.rpgleinc PEEKUSR.FILE
PEEKINIT3.PGM: private ACTGRP := *CALLER
PEEKINIT3.PGM: private TEXT := Peek/400 - Initialisieren Peek/400 - PEEKUSR
PEEKINIT3.PGM: PEEKINIT3.MODULE PEEK53.SRVPGM PEEK.BNDDIR

PEEKUPDATE.MODULE: peekupdate.clle
PEEKUPD1.MODULE: peekupd1.clle
PEEKUPD2.MODULE: peekupd2.clle
PEEKUPDATE.PGM: private ACTGRP := *CALLER
PEEKUPDATE.PGM: private TEXT := Peek/400 - Aktualisieren neue PEEK/400 Bibliothek
PEEKUPDATE.PGM: PEEKUPDATE.MODULE PEEKUPD1.MODULE PEEKUPD2.MODULE PEEK.BNDDIR

TREE.MODULE: tree.clle
TREE.PGM: private ACTGRP := *CALLER
TREE.PGM: private TEXT := Peek/400 - Befehlsausführungsprogramm ACTGRP: *CAL
TREE.PGM: TREE.MODULE PEEK.BNDDIR

# Die Debug-Sicht bekommt der RPG-Compiler über COMPILEOPT. CRTSQLRPGI DBGVIEW(*NONE) gäbe
# ihm keine mit, und er nähme seinen Standard *STMT. TOBi setzt COMPILEOPT aus TGTCCSID,
# OPTIMIZE und INCDIR zusammen; DBGVIEW kommt mit OPTIMIZE hinein.
PEEK51.MODULE: private COMMIT := *NONE) ALWBLK(*NONE) LANGID(*JOBRUN
PEEK51.MODULE: private LPAREN := (
PEEK51.MODULE: private RPAREN := )
PEEK51.MODULE: private TEXT := Peek/400 - SQL-Komponente                   SrvPgm
PEEK51.MODULE: peek51.sqlrpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/rtvm0100.rpgleinc qcopyle/usr8210.rpgleinc
	$(eval SQLRPGIMOD_OPTIMIZE := *NONE$(RPAREN) DBGVIEW$(LPAREN)$(RPGMOD_DBGVIEW))
	$(eval SQLRPGIMOD_DBGVIEW := *NONE)
	$(SQLRPGLE_TO_MODULE_RECIPE)

PEEK53.MODULE: peek53.rpgle qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek22.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0004.rpgleinc qcopyle/set0005.rpgleinc qcopyle/set0006.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0008.rpgleinc qcopyle/set0009.rpgleinc qcopyle/set0010.rpgleinc qcopyle/set0011.rpgleinc qcopyle/set0012.rpgleinc qcopyle/set0013.rpgleinc qcopyle/set0014.rpgleinc qcopyle/set0015.rpgleinc qcopyle/set0016.rpgleinc PEEKUSR.FILE

PEEK58.MODULE: peek58.rpgle qcopyle/bspf0100.rpgleinc qcopyle/copyright.rpgleinc qcopyle/cpf9801.rpgleinc qcopyle/cpf9815.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0100.rpgleinc qcopyle/mbrd0300.rpgleinc qcopyle/objd0100.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qcapcmd.rpgleinc qcopyle/qdbrtvfd.rpgleinc qcopyle/qlgcnvcs.rpgleinc qcopyle/qmhmovpm.rpgleinc qcopyle/qmhrmvpm.rpgleinc qcopyle/qmhrtvm.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qsyrusri.rpgleinc qcopyle/qusrjobi.rpgleinc qcopyle/qusrmbrd.rpgleinc qcopyle/qusrobjd.rpgleinc qcopyle/rtvm0100.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8182.rpgleinc qcopyle/usri0200.rpgleinc

PEEK61.MODULE: peek61.rpgle qcopyle/d_vardef.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qusrjobi.rpgleinc

PEEK63.MODULE: peek63.rpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_clib2.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0012.rpgleinc qcopyle/usr9994.rpgleinc
PEEK63C.MODULE: private SYSIFCOPT := *NOIFSIO
PEEK63C.MODULE: private TERASPACE := *NO
PEEK63C.MODULE: private CMOD_TERASPACE := *NO
PEEK63C.MODULE: private STGMDL := *SNGLVL
PEEK63C.MODULE: private CMOD_STGMDL := *SNGLVL
PEEK63C.MODULE: private OPTION := *EVENTF
PEEK63C.MODULE: private CMOD_OPTION := *EVENTF
PEEK63C.MODULE: peek63c.c

PEEK71.MODULE: peek71.rpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qusrjobi.rpgleinc
