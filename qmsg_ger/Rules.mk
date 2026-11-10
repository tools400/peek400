# Regeln von TOBi (makei) für Peek/400, Verzeichnis qmsg_ger. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

PEEKGER.MSGF: peekgermg.clp
	@echo "=== Creating message file [PEEKGER] in $(OBJLIB) with CCSID $(TGTCCSID)"
	@$(TOP)/tools/crtmsgf.sh '$(<)' '$(OBJLIB)' $(TGTCCSID) > $(LOGPATH)/qmsg_ger_PEEKGER_MSGF.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKGER.PNLGRP: private TEXT := Peek/400 - File Editor, Deutsch
PEEKGER.PNLGRP: peekgerpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREEGER.PNLGRP: private TEXT := Peek/400 - Display Database Relations, Deutsch
TREEGER.PNLGRP: treegerpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)
