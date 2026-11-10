# Regeln von TOBi (makei) für Peek/400, Verzeichnis qmsg_eng. Siehe DEVELOPMENT.md, Abschnitt "Bauen".

PEEKENG.MSGF: peekengmg.clp
	@echo "=== Creating message file [PEEKENG] in $(OBJLIB) with CCSID $(TGTCCSID)"
	@$(TOP)/tools/crtmsgf.sh '$(<)' '$(OBJLIB)' $(TGTCCSID) > $(LOGPATH)/qmsg_eng_PEEKENG_MSGF.splf 2>&1 && $(call logSuccess,$(@)) || $(call logFail,$(@))

PEEKENG.PNLGRP: private TEXT := Peek/400 - File Editor, English
PEEKENG.PNLGRP: peekengpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREEENG.PNLGRP: private TEXT := Peek/400 - Display Database Relations, English
TREEENG.PNLGRP: treeengpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)
