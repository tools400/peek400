# Draft of the rules of TOBi for the members of PEEK411P/QRUNIT, created by the migration
# of IFS Projects. Check the object types and set the parameters of the installer or of the
# STRPREPRC headers, because the defaults of TOBi differ from the CL commands, e.g.:
#   %.MODULE: private DBGVIEW := *LIST
#   HELLO.PGM: private ACTGRP := *NEW

CRTDB.PGM: private INCDIR := 'qrunit'
CRTDB.PGM: crtdb.clle
	$(PGM.CLLE_TO_PGM_RECIPE)

CUSTOMER.FILE: customer.pf

HCUSTOMER.FILE: hcustomer.pf

HITEM.FILE: hitem.pf

HORDER.FILE: horder.pf

HORDER1.FILE: horder1.lf

HSTQRY.FILE: hstqry.lf

ITEM.FILE: item.pf

MORDER.FILE: morder.lf

ORDER.FILE: order.pf

ORDERL1.FILE: orderl1.lf

ORDQRY.FILE: ordqry.lf

PEEKPGMT.PGM: peekpgmt.rpgle qcopyle/d_clib.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/mbrd0200.rpgleinc qcopyle/objd0100.rpgleinc qcopyle/objl0200.rpgleinc qcopyle/ppeek01.rpgleinc qcopyle/ppeek02.rpgleinc qcopyle/ppeek03.rpgleinc qcopyle/ppeek04.rpgleinc qcopyle/ppeek06.rpgleinc qcopyle/ppeek07.rpgleinc qcopyle/ppeek10.rpgleinc qcopyle/ppeek11.rpgleinc qcopyle/ppeek13.rpgleinc qcopyle/ppeek15.rpgleinc qcopyle/ppeek18.rpgleinc qcopyle/ppeek19.rpgleinc qcopyle/ppeek20.rpgleinc qcopyle/ppeek22.rpgleinc qcopyle/ppeek23.rpgleinc qcopyle/ppeek27.rpgleinc qcopyle/ppeek31.rpgleinc qcopyle/ppeek32.rpgleinc qcopyle/ppeek33.rpgleinc qcopyle/ppeek36.rpgleinc qcopyle/ppeek38.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek54.rpgleinc qcopyle/ppeek55.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek61.rpgleinc qcopyle/ppeek62.rpgleinc qcopyle/ppeek65.rpgleinc qcopyle/ppeek66.rpgleinc qcopyle/ppeek70.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qusrjobi.rpgleinc qcopyle/qusrobjd.rpgleinc qcopyle/rcdl0200.rpgleinc qcopyle/set0003.rpgleinc qcopyle/set0004.rpgleinc qcopyle/set0007.rpgleinc

PEEKSRVT.PGM: peeksrvt.rpgle qcopyle/d_clib.rpgleinc qcopyle/d_infds.rpgleinc qcopyle/d_vardef.rpgleinc qcopyle/fldl0100.rpgleinc qcopyle/h_spec.rpgleinc qcopyle/objd0100.rpgleinc qcopyle/ppeek51.rpgleinc qcopyle/ppeek53.rpgleinc qcopyle/ppeek58.rpgleinc qcopyle/ppeek63.rpgleinc qcopyle/ppeek71.rpgleinc qcopyle/qusrobjd.rpgleinc

# No rule created for:
#   alltypes.sql
#   data.sql
