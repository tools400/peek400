# Regeln von TOBi (makei) für Peek/400, Verzeichnis qmsg_fra. Siehe README, Abschnitt "Bauen".

PEEKFRA.MSGF: peekframg.clp
	@echo "=== Creating message file [PEEKFRA] in $(OBJLIB) with CCSID $(TGTCCSID)"
	@$(TOP)/tools/crtmsgf.sh '$(<)' '$(OBJLIB)' $(TGTCCSID) > $(LOGPATH)/qmsg_fra_PEEKFRA_MSGF.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKFRA.PNLGRP: private TEXT := Peek/400 - File Editor, Francais
PEEKFRA.PNLGRP: peekfrapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREEFRA.PNLGRP: private TEXT := Peek/400 - Display Database Relations, Francais
TREEFRA.PNLGRP: treefrapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)
