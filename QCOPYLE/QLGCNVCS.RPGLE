      /if not defined(QLGCNVCS)
      /define QLGCNVCS
      *
      *  Convert Case (QLGCNVCS, QlgConvertCase) API
     d QlgConvertCase...
     d                 pr                  extproc('QlgConvertCase')
     d  i_reqCtrlBlk              32767A   const  options(*varsize)
     d  i_inData                  32767A   const  options(*varsize)
     d  o_outData                 32767A          options(*varsize)
     d  i_length                     10i 0 const
     d  io_ErrCode                32767A          options(*nopass: *varsize)
      *
     d QLGCNVCS_reqCtrlBlk_t...
     d                 ds                  qualified
     d  type                         10i 0
     d  CCSID                        10i 0
     d  case                         10i 0
     d  reserved                     10a
      *
     d CVTCASE_TYPE_CCSID...
     d                 c                   1
     d CVTCASE_TYPE_TABLE...
     d                 c                   2
     d CVTCASE_TYPE_USER_DEF...
     d                 c                   3
     d CVTCASE_TO_UPPER...
     d                 c                   0
     d CVTCASE_TO_LOWER...
     d                 c                   1
     d CVTCASE_CCSID_Job...
     d                 c                   0
      *
      /endif
