**FREE
/IF NOT DEFINED(D_MI)
/DEFINE D_MI
//
dcl-s num_descr_t     int(10) template;
//
//  Copy Numeric Value (CPYNV)
dcl-pr cpynv
       pointer extproc('cpynv');
  i_rcvdesc       value  like(num_descr_t );
  i_prcvvar       pointer value;
  i_srcdesc       value  like(num_descr_t );
  i_psrcvar       pointer value;
end-pr;
//
//  These values must be specified on the Scalar Type for CPYNV,
//  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM
dcl-c t_signed const(x'00');
dcl-c t_float const(x'01');
dcl-c t_zoned const(x'02');
dcl-c t_packed const(x'03');
dcl-c t_char const(x'04');
dcl-c t_onlyns const(x'06');
dcl-c t_onlyn const(x'07');
dcl-c t_either const(x'08');
dcl-c t_open const(x'09');
dcl-c t_unsigned const(x'0A');
//
/ENDIF
