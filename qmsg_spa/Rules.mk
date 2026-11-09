# Draft of the rules of TOBi for the members of PEEK411P/QMSG_SPA, created by the migration
# of IFS Projects. Check the object types and set the parameters of the installer or of the
# STRPREPRC headers, because the defaults of TOBi differ from the CL commands, e.g.:
#   %.MODULE: private DBGVIEW := *LIST
#   HELLO.PGM: private ACTGRP := *NEW

PEEKSPAPG.PNLGRP: peekspapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREESPAPG.PNLGRP: treespapg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

# No rule created for:
#   peekspamg.clp
