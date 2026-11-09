**free
/if NOT defined(D_MI)
/define D_MI

dcl-s num_descr_t int(10) template;

//  Copy Numeric Value (CPYNV)
dcl-pr cpynv pointer extproc('cpynv');
  i_rcvDesc like(num_descr_t) value;
  i_pRcvVar pointer value;
  i_srcDesc like(num_descr_t) value;
  i_pSrcVar pointer value;
end-pr;

//  These values must be specified on the Scalar Type for CPYNV,
//  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM
dcl-c T_Signed x'00';
dcl-c t_float x'01';
dcl-c T_Zoned x'02';
dcl-c t_packed x'03';
dcl-c t_char x'04';
dcl-c t_onlyns x'06';
dcl-c t_onlyn x'07';
dcl-c t_either x'08';
dcl-c t_open x'09';
dcl-c t_unsigned x'0A';

/endif
