# Regeln von TOBi (makei) für Peek/400, Verzeichnis qmsg_ita. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

PEEKITA.MSGF: peekitamg.clp
	@echo "=== Creating message file [PEEKITA] in $(OBJLIB) with CCSID $(TGTCCSID)"
	@$(TOP)/tools/crtmsgf.sh '$(<)' '$(OBJLIB)' $(TGTCCSID) > $(LOGPATH)/qmsg_ita_PEEKITA_MSGF.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKITA.PNLGRP: private TEXT := Peek/400 - File Editor, Italiano
PEEKITA.PNLGRP: peekitapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREEITA.PNLGRP: private TEXT := Peek/400 - Display Database Relations, Italiano
TREEITA.PNLGRP: treeitapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)
