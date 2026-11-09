# Draft of the rules of TOBi for the members of PEEK411P/QMSG_GER, created by the migration
# of IFS Projects. Check the object types and set the parameters of the installer or of the
# STRPREPRC headers, because the defaults of TOBi differ from the CL commands, e.g.:
#   %.MODULE: private DBGVIEW := *LIST
#   HELLO.PGM: private ACTGRP := *NEW

PEEKGERPG.PNLGRP: peekgerpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

TREEGERPG.PNLGRP: treegerpg.pnlgrp
	$(PNLGRPSRC_TO_PNLGRP_RECIPE)

# No rule created for:
#   peekgermg.clp
