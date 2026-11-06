**free

//  Templates  (micptcom.h)
dcl-s NUM_Descr_T int(10) template;

//  Constants  (micptcom.h)
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

//  Copy Numeric Value
dcl-pr cpynv pointer extproc('cpynv');
  o_rcvr_descr like(NUM_Descr_T) value;
  o_receiver   pointer value;
  i_src_descr  like(NUM_Descr_T) value;
  i_source     pointer value;
end-pr;

