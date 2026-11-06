**free

/if defined(internal_prototype)
dcl-pr peek17 extpgm('PEEK17');
/else
dcl-pr peek17 extpgm(peek17_name);
/endif
  i_dsp80     like(bool_t) const;
  i_copyright like(copyrght_t) const;
  i_qfile     like(qobj_t) const;
  i_member    like(mbr_t) const;
  o_field     like(fieldNme_t);
  o_operation like(operation_t);
  o_argument  like(argument_t);
  o_sign      like(sign_t);
  o_srchnbrs  like(srchNbrs_t);
  o_srchtype  like(type_t);
  o_srchcase  like(bool_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
