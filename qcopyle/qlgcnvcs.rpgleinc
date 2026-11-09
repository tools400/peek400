**free
/if not defined(QLGCNVCS)
/define QLGCNVCS

//  Convert Case (QLGCNVCS, QlgConvertCase) API
dcl-pr QlgConvertCase extproc('QlgConvertCase');
  i_reqCtrlBlk char(32767) options(*varsize) const;
  i_inData     char(32767) options(*varsize) const;
  o_outData    char(32767) options(*varsize);
  i_length     int(10) const;
  io_errCode   char(32767) options(*nopass: *varsize);
end-pr;

dcl-ds QLGCNVCS_reqCtrlBlk_t qualified;
  type     int(10);
  ccsid    int(10);
  case     int(10);
  reserved char(10);
end-ds;

dcl-c cvtcase_type_ccsid 1;
dcl-c cvtcase_type_table 2;
dcl-c cvtcase_type_user_def 3;
dcl-c cvtcase_to_upper 0;
dcl-c cvtcase_to_lower 1;
dcl-c CVTCASE_CCSID_Job 0;

/endif
