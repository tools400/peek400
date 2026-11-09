# Regeln von TOBi (makei) für Peek/400, Verzeichnis qmsg_spa. Siehe README, Abschnitt "Bauen".

PEEKSPA.MSGF: peekspamg.clp
	@echo "=== Creating message file [PEEKSPA] in $(OBJLIB) with CCSID $(TGTCCSID)"
	@$(TOP)/tools/crtmsgf.sh '$(<)' '$(OBJLIB)' $(TGTCCSID) > $(LOGPATH)/qmsg_spa_PEEKSPA_MSGF.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKSPA.PNLGRP: private TEXT := Peek/400 - File Editor, Espanol
PEEKSPA.PNLGRP: peekspapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREESPA.PNLGRP: private TEXT := Peek/400 - Display Database Relations, Espanol
TREESPA.PNLGRP: treespapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)
