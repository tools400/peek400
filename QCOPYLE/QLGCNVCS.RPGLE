**FREE
/if not defined(QLGCNVCS)
/define QLGCNVCS
//
//  Convert Case (QLGCNVCS, QlgConvertCase) API
dcl-pr qlgconvertcase
       extproc('QlgConvertCase');
  i_reqctrlblk    char(32767) const  options(*varsize);
  i_indata        char(32767) const  options(*varsize);
  o_outdata       char(32767) options(*varsize);
  i_length        int(10) const;
  io_errcode      char(32767) options(*nopass: *varsize);
end-pr;
//
dcl-ds qlgcnvcs_reqctrlblk_t
       qualified;
  type            int(10);
  ccsid           int(10);
  case            int(10);
  reserved        char(10);
end-ds;
//
dcl-c cvtcase_type_ccsid
      1;
dcl-c cvtcase_type_table
      2;
dcl-c cvtcase_type_user_def
      3;
dcl-c cvtcase_to_upper
      0;
dcl-c cvtcase_to_lower
      1;
dcl-c cvtcase_ccsid_job
      0;
//
/endif
