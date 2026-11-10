# Regeln von TOBi (makei) für Peek/400, Verzeichnis peeksrc. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

# Vorlagen der Update-Programme, zur Laufzeit gelesen. PEEK15/16 brauchen die Dateien beim Übersetzen.
PEEKSRC.FILE: peeksrc/pgm.rpgle peeksrc/dspf.dspf
	@echo "=== Creating source file [PEEKSRC] in $(OBJLIB)"
	@$(TOP)/tools/crtsrcf.sh '$(OBJLIB)' PEEKSRC 112 273 'Peek/400 - Template für Programme' $(^) > $(LOGPATH)/peeksrc_PEEKSRC_FILE.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

QPEEKGEN.FILE:
	@echo "=== Creating source file [QPEEKGEN] in $(OBJLIB)"
	@$(TOP)/tools/crtsrcf.sh '$(OBJLIB)' QPEEKGEN 112 273 'Peek/400 - Generated Sources(dummy)' > $(LOGPATH)/peeksrc_QPEEKGEN_FILE.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))
