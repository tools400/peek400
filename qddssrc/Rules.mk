# Regeln von TOBi (makei) für Peek/400, Verzeichnis qddssrc. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

%.FILE: private RSTDSP := *YES

EXIT01PF.FILE: exit01pf.pf

PEEK05FM.FILE: peek05fm.dspf

PEEK12FM.FILE: peek12fm.dspf

PEEK14FM.FILE: peek14fm.dspf

PEEK17FM.FILE: peek17fm.dspf

PEEK24FM.FILE: peek24fm.dspf

PEEK25FM.FILE: peek25fm.dspf

PEEK26FM.FILE: peek26fm.dspf

PEEK30FM.FILE: peek30fm.dspf

PEEK34FM.FILE: peek34fm.dspf

PEEK37FM.FILE: peek37fm.dspf

PEEK40FM.FILE: peek40fm.dspf

PEEK45FM.FILE: peek45fm.dspf

PEEK47FM.FILE: peek47fm.dspf

PEEK48FM.FILE: peek48fm.dspf

PEEK49FM.FILE: peek49fm.dspf

PEEK50FM.FILE: peek50fm.dspf

PEEK52FM.FILE: peek52fm.dspf

PEEK56FM.FILE: peek56fm.dspf

PEEK57FM.FILE: peek57fm.dspf

PEEK59FM.FILE: peek59fm.dspf

PEEK64FM.FILE: peek64fm.dspf

PEEK65P.FILE: peek65p.prtf

PEEK68FM.FILE: peek68fm.dspf

PEEK69FM.FILE: peek69fm.dspf

PEEKENV.FILE: private REUSEDLT := *YES) MAXMBRS(*NOMAX
PEEKENV.FILE: private MBR := *NONE
PEEKENV.FILE: peekenv.pf

PEEKFLD.FILE: private REUSEDLT := *YES
PEEKFLD.FILE: peekfld.pf

PEEKFLDL0.FILE: peekfldl0.lf PEEKFLD.FILE

PEEKFLDL1.FILE: peekfldl1.lf PEEKFLD.FILE

PEEKFLDL2.FILE: peekfldl2.lf PEEKFLD.FILE

PEEKFMT.FILE: private REUSEDLT := *YES
PEEKFMT.FILE: peekfmt.pf

PEEKUSR.FILE: private REUSEDLT := *YES
PEEKUSR.FILE: private TEXT := Peek/400 - Template für Benutzervoreinstellungen
PEEKUSR.FILE: peekusr.pf peekusrdta.sql
	$(PF_TO_FILE_RECIPE)
	@echo "=== Loading the default settings into [PEEKUSR] in $(OBJLIB)"
	@($(TOP)/tools/runcl.sh "RUNSQLSTM SRCSTMF('$(TOP)/qddssrc/peekusrdta.sql') COMMIT(*NONE) NAMING(*SQL) DATFMT(*ISO) TIMFMT(*ISO) DFTRDBCOL($(OBJLIB))" || ($(TOP)/tools/runcl.sh "DLTF FILE($(OBJLIB)/PEEKUSR)"; false)) > $(LOGPATH)/qddssrc_PEEKUSR_DATA.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKWRK.FILE: private REUSEDLT := *YES
PEEKWRK.FILE: peekwrk.pf

EXIT04LOG.FILE: private TEXT := Peek/400 - Output file of EXIT04 example
EXIT04LOG.FILE: exit04log.sql
	@echo "=== Creating table [EXIT04LOG] in $(OBJLIB)"
	@$(TOP)/tools/runcl.sh "!DLTF FILE($(OBJLIB)/EXIT04LOG)" "RUNSQLSTM SRCSTMF('$(TOP)/qddssrc/exit04log.sql') COMMIT(*NONE) NAMING(*SQL) DATFMT(*ISO) TIMFMT(*ISO) DFTRDBCOL($(OBJLIB))" > $(LOGPATH)/qddssrc_EXIT04LOG_FILE.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKPGM.DTAARA: peekpgm.dtaara
