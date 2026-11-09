# Draft of the rules of TOBi for the members of PEEK411P/QRPGLESRC, created by the migration
# of IFS Projects. Check the object types and set the parameters of the installer or of the
# STRPREPRC headers, because the defaults of TOBi differ from the CL commands, e.g.:
#   %.MODULE: private DBGVIEW := *LIST
#   HELLO.PGM: private ACTGRP := *NEW

#INITDEV.PGM: private INCDIR := 'qrpglesrc'
#INITDEV.PGM: #initdev.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

EXIT01.PGM: exit01.rpgle qcopyle/ceertx.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit01.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr1000.rpgleinc

EXIT02.PGM: exit02.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit02.rpgleinc

EXIT03.PGM: exit03.rpgle qcopyle/copyright.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit03.rpgleinc

EXIT04.PGM: exit04.rpgle qcopyle/copyright.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit04.rpgleinc

EXIT05.PGM: exit05.rpgle qcopyle/copyright.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit05.rpgleinc

EXIT06.PGM: exit06.rpgle qcopyle/copyright.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit06.rpgleinc

PEEK.PGM: private INCDIR := 'qrpglesrc'
PEEK.PGM: peek.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKCLONE.PGM: private INCDIR := 'qrpglesrc'
PEEKCLONE.PGM: peekclone.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKCLONE1.PGM: private INCDIR := 'qrpglesrc'
PEEKCLONE1.PGM: peekclone1.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKCLONE2.PGM: private INCDIR := 'qrpglesrc'
PEEKCLONE2.PGM: peekclone2.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKDST.PGM: private INCDIR := 'qrpglesrc'
PEEKDST.PGM: peekdst.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKINIT.PGM: private INCDIR := 'qrpglesrc'
PEEKINIT.PGM: peekinit.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKINIT1.PGM: private INCDIR := 'qrpglesrc'
PEEKINIT1.PGM: peekinit1.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKINIT2.PGM: private INCDIR := 'qrpglesrc'
PEEKINIT2.PGM: peekinit2.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKINIT3.PGM: peekinit3.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/set0004.rpgleinc

PEEKUPDATE.PGM: private INCDIR := 'qrpglesrc'
PEEKUPDATE.PGM: peekupdate.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKUPD1.PGM: private INCDIR := 'qrpglesrc'
PEEKUPD1.PGM: peekupd1.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEKUPD2.PGM: private INCDIR := 'qrpglesrc'
PEEKUPD2.PGM: peekupd2.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK00.PGM: private INCDIR := 'qrpglesrc'
PEEK00.PGM: peek00.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK01.PGM: peek01.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/pexit06.rpgleinc qcopyle/ppeek01.rpgleinc qcopyle/ppeek02.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/usr0001.rpgleinc qcopyle/usr8104.rpgleinc

PEEK02.PGM: peek02.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek02.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslfld.rpgleinc qcopyle/qusptrus.rpgleinc

PEEK03.PGM: peek03.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek03.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0006.rpgleinc

PEEK04.PGM: peek04.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek04.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0006.rpgleinc

PEEK05.PGM: peek05.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/dopgmcmd.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0200.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/pexit01.rpgleinc qcopyle/pexit04.rpgleinc qcopyle/ppeek01.rpgleinc qcopyle/ppeek03.rpgleinc qcopyle/ppeek04.rpgleinc qcopyle/ppeek05.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek08.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek10.rpgleinc qcopyle/ppeek12.rpgleinc qcopyle/ppeek13.rpgleinc qcopyle/ppeek14.rpgleinc qcopyle/ppeek17.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek19.rpgleinc qcopyle/ppeek20.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek24.rpgleinc qcopyle/ppeek26.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek30.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek33.rpgleinc qcopyle/ppeek34.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek42.rpgleinc qcopyle/ppeek47.rpgleinc qcopyle/ppeek48.rpgleinc qcopyle/ppeek49.rpgleinc qcopyle/ppeek50.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek52.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek54.rpgleinc qcopyle/ppeek55.rpgleinc qcopyle/ppeek56.rpgleinc qcopyle/ppeek57.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek59.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/ppeek68.rpgleinc qcopyle/ppeek69.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/pupdpgm.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0005.rpgleinc qcopyle/set0006.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0008.rpgleinc qcopyle/set0009.rpgleinc qcopyle/set0010.rpgleinc qcopyle/set0011.rpgleinc qcopyle/set0013.rpgleinc qcopyle/set0014.rpgleinc qcopyle/set0015.rpgleinc qcopyle/set0016.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0007.rpgleinc qcopyle/usr0008.rpgleinc qcopyle/usr0009.rpgleinc qcopyle/usr0010.rpgleinc qcopyle/usr0013.rpgleinc qcopyle/usr0014.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8108.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8128.rpgleinc qcopyle/usr8144.rpgleinc qcopyle/usr8147.rpgleinc qcopyle/usr8148.rpgleinc qcopyle/usr8190.rpgleinc qcopyle/usr8196.rpgleinc qcopyle/usr8200.rpgleinc qcopyle/usr8201.rpgleinc qcopyle/usr8202.rpgleinc qcopyle/usr8203.rpgleinc qcopyle/usr8206.rpgleinc qcopyle/usr8207.rpgleinc qcopyle/usr8212.rpgleinc qcopyle/usr8217.rpgleinc qcopyle/usr8218.rpgleinc qcopyle/usr8223.rpgleinc qcopyle/usr8224.rpgleinc qcopyle/usr8235.rpgleinc qcopyle/usr9993.rpgleinc qcopyle/usr9996.rpgleinc qcopyle/usr9998.rpgleinc qcopyle/usr9999.rpgleinc

PEEK06.PGM: peek06.rpgle qcopyle/copyright.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qeccvtec.rpgleinc qcopyle/qeccvtew.rpgleinc qcopyle/qecedt.rpgleinc

PEEK07.PGM: peek07.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qwcrneta.rpgleinc

PEEK08.PGM: private INCDIR := 'qrpglesrc'
PEEK08.PGM: peek08.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK09.PGM: peek09.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qusrobjd.rpgleinc

PEEK10.PGM: peek10.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek10.rpgleinc qcopyle/ppeek11.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0002.rpgleinc qcopyle/usr8105.rpgleinc

PEEK11.PGM: peek11.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek11.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslrcd.rpgleinc qcopyle/qusptrus.rpgleinc qcopyle/rcdl0200.rpgleinc

PEEK12.PGM: peek12.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek12.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc

PEEK13.PGM: peek13.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0200.rpgleinc qcopyle/ppeek13.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qusrmbrd.rpgleinc

PEEK14.PGM: peek14.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek14.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek45.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek64.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8206.rpgleinc qcopyle/usr8220.rpgleinc qcopyle/usr8221.rpgleinc qcopyle/usr8222.rpgleinc

PEEK15.PGM: peek15.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek15.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8188.rpgleinc

PEEK16.PGM: peek16.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek16.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/sds.rpgleinc

PEEK17.PGM: peek17.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek17.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0008.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8108.rpgleinc qcopyle/usr8124.rpgleinc qcopyle/usr8126.rpgleinc qcopyle/usr8129.rpgleinc qcopyle/usr8134.rpgleinc qcopyle/usr8135.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8138.rpgleinc qcopyle/usr8140.rpgleinc qcopyle/usr8141.rpgleinc qcopyle/usr8142.rpgleinc qcopyle/usr8192.rpgleinc

PEEK18.PGM: peek18.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek36.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0003.rpgleinc qcopyle/usr8138.rpgleinc

PEEK19.PGM: peek19.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek19.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc

PEEK20.PGM: peek20.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek20.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0003.rpgleinc

PEEK21.PGM: peek21.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8143.rpgleinc

PEEK22.PGM: peek22.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek22.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc

PEEK23.PGM: peek23.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc

PEEK24.PGM: peek24.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek24.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc

PEEK25.PGM: peek25.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc

PEEK26.PGM: peek26.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek26.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8151.rpgleinc qcopyle/usr8152.rpgleinc qcopyle/usr8153.rpgleinc qcopyle/usr8154.rpgleinc qcopyle/usr8155.rpgleinc

PEEK27.PGM: peek27.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc

PEEK28.PGM: peek28.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek28.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qwcrsval.rpgleinc

PEEK29.PGM: peek29.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek29.rpgleinc qcopyle/sds.rpgleinc

PEEK30.PGM: peek30.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek28.rpgleinc qcopyle/ppeek29.rpgleinc qcopyle/ppeek30.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/qusptrus.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8158.rpgleinc qcopyle/usr9997.rpgleinc

PEEK31.PGM: peek31.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek31.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0004.rpgleinc

PEEK32.PGM: peek32.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0006.rpgleinc qcopyle/usr8163.rpgleinc

PEEK33.PGM: peek33.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek33.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0012.rpgleinc qcopyle/set0016.rpgleinc

PEEK34.PGM: peek34.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek25.rpgleinc qcopyle/ppeek34.rpgleinc qcopyle/ppeek35.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/wrk0001.rpgleinc

PEEK35.PGM: peek35.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek35.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8168.rpgleinc qcopyle/usr8169.rpgleinc qcopyle/usr8170.rpgleinc qcopyle/usr8243.rpgleinc qcopyle/wrk0001.rpgleinc

PEEK36.PGM: peek36.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek36.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/usr8171.rpgleinc

PEEK37.PGM: peek37.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc

PEEK38.PGM: peek38.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc

PEEK39.PGM: peek39.rpgle qcopyle/copyright.rpgleinc qcopyle/dbrl0200.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek39.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qdbldbr.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/qusptrus.rpgleinc

PEEK40.PGM: peek40.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/dbrl0200.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek39.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/sell0100.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0008.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8172.rpgleinc qcopyle/usr8194.rpgleinc qcopyle/usr8209.rpgleinc

PEEK41.PGM: peek41.rpgle qcopyle/bspf0100.rpgleinc qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qdbrtvfd.rpgleinc qcopyle/sell0100.rpgleinc

PEEK42.PGM: peek42.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek42.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek66.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8228.rpgleinc qcopyle/usr8229.rpgleinc qcopyle/usr8230.rpgleinc

PEEK44.PGM: private INCDIR := 'qrpglesrc'
PEEK44.PGM: peek44.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK45.PGM: peek45.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek45.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0006.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8136.rpgleinc

PEEK46.PGM: peek46.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslmbr.rpgleinc qcopyle/qusptrus.rpgleinc

PEEK47.PGM: peek47.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek47.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8180.rpgleinc qcopyle/usr8209.rpgleinc

PEEK48.PGM: peek48.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/keyl0100.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek37.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek40.rpgleinc qcopyle/ppeek48.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0008.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc

PEEK49.PGM: peek49.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek49.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc

PEEK50.PGM: peek50.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek50.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8205.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/wrk0002.rpgleinc

PEEK51.PGM: peek51.sqlrpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/rtvm0100.rpgleinc qcopyle/usr8210.rpgleinc

PEEK52.PGM: peek52.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek52.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0012.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8216.rpgleinc qcopyle/usr8219.rpgleinc

PEEK53.PGM: peek53.rpgle qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek22.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0001.rpgleinc qcopyle/set0002.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0004.rpgleinc qcopyle/set0005.rpgleinc qcopyle/set0006.rpgleinc qcopyle/set0007.rpgleinc qcopyle/set0008.rpgleinc qcopyle/set0009.rpgleinc qcopyle/set0010.rpgleinc qcopyle/set0011.rpgleinc qcopyle/set0012.rpgleinc qcopyle/set0013.rpgleinc qcopyle/set0014.rpgleinc qcopyle/set0015.rpgleinc qcopyle/set0016.rpgleinc

PEEK54.PGM: peek54.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/env0001.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek54.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr9992.rpgleinc

PEEK55.PGM: peek55.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/env0001.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek55.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0015.rpgleinc qcopyle/usr8234.rpgleinc

PEEK56.PGM: peek56.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek46.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek56.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/set0015.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8180.rpgleinc qcopyle/usr8181.rpgleinc qcopyle/usr8182.rpgleinc qcopyle/usr8184.rpgleinc qcopyle/usr8209.rpgleinc qcopyle/usr8233.rpgleinc

PEEK57.PGM: peek57.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek57.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc

PEEK58.PGM: peek58.rpgle qcopyle/bspf0100.rpgleinc qcopyle/copyright.rpgleinc qcopyle/cpf9801.rpgleinc qcopyle/cpf9815.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fild0100.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0100.rpgleinc qcopyle/mbrd0300.rpgleinc qcopyle/objd0100.rpgleinc qcopyle/ppeek41.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/qcapcmd.rpgleinc qcopyle/qdbrtvfd.rpgleinc qcopyle/qlgcnvcs.rpgleinc qcopyle/qmhmovpm.rpgleinc qcopyle/qmhrmvpm.rpgleinc qcopyle/qmhrtvm.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qsyrusri.rpgleinc qcopyle/qusrjobi.rpgleinc qcopyle/qusrmbrd.rpgleinc qcopyle/qusrobjd.rpgleinc qcopyle/rtvm0100.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8182.rpgleinc qcopyle/usri0200.rpgleinc

PEEK59.PGM: peek59.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek59.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8190.rpgleinc

PEEK60.PGM: peek60.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek60.rpgleinc

PEEK61.PGM: peek61.rpgle qcopyle/d_vardef.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qusrjobi.rpgleinc

PEEK62.PGM: peek62.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek62.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr9989.rpgleinc qcopyle/usr9995.rpgleinc

PEEK63.PGM: peek63.rpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_clib2.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0012.rpgleinc qcopyle/usr9994.rpgleinc

PEEK64.PGM: peek64.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_coloratr.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek64.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8123.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8240.rpgleinc qcopyle/usr8241.rpgleinc

PEEK65.PGM: peek65.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objd0400.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek09.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr0005.rpgleinc

PEEK66.PGM: peek66.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_mi.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek66.rpgleinc qcopyle/sds.rpgleinc qcopyle/usr8227.rpgleinc

PEEK67.PGM: private INCDIR := 'qrpglesrc'
PEEK67.PGM: peek67.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK68.PGM: peek68.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek68.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8136.rpgleinc qcopyle/usr8209.rpgleinc

PEEK69.PGM: peek69.rpgle qcopyle/ceecndhdlr.rpgleinc qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/d_workstn.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objl0200.rpgleinc qcopyle/ppeek21.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek69.rpgleinc qcopyle/ppeek70.rpgleinc qcopyle/scrnfkeys.rpgleinc qcopyle/sds.rpgleinc qcopyle/shortcmd_d.rpgleinc qcopyle/usr0010.rpgleinc qcopyle/usr8100.rpgleinc qcopyle/usr8110.rpgleinc qcopyle/usr8194.rpgleinc qcopyle/usr8209.rpgleinc

PEEK70.PGM: peek70.rpgle qcopyle/copyright.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/genheader.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objl0200.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek70.rpgleinc qcopyle/quscrtus.rpgleinc qcopyle/quslobj.rpgleinc qcopyle/qusptrus.rpgleinc

PEEK71.PGM: peek71.rpgle qcopyle/copyright.rpgleinc qcopyle/d_clib.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qmhsndpm.rpgleinc qcopyle/qusrjobi.rpgleinc

PEEK80.PGM: private INCDIR := 'qrpglesrc'
PEEK80.PGM: peek80.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK94.PGM: private INCDIR := 'qrpglesrc'
PEEK94.PGM: peek94.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK95.PGM: private INCDIR := 'qrpglesrc'
PEEK95.PGM: peek95.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK96.PGM: private INCDIR := 'qrpglesrc'
PEEK96.PGM: peek96.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK96A.PGM: private INCDIR := 'qrpglesrc'
PEEK96A.PGM: peek96a.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK96B.PGM: private INCDIR := 'qrpglesrc'
PEEK96B.PGM: peek96b.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK97.PGM: private INCDIR := 'qrpglesrc'
PEEK97.PGM: peek97.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

PEEK99.PGM: private INCDIR := 'qrpglesrc'
PEEK99.PGM: peek99.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

TEST003FM.FILE: test003fm.dspf

TREE.PGM: private INCDIR := 'qrpglesrc'
TREE.PGM: tree.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

# No rule created for:
#   #download.bat
#   #readme.txt
#   #update.txt
#   #whats_new.txt
#   peek63c.c
