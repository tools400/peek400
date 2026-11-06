**free

/if defined(internal_prototype)
dcl-pr peek35 extpgm('PEEK35');
/else
dcl-pr peek35 extpgm(peek35_name);
/endif
  i_rcdnbr  like(rcdnbr_t) const;
  i_buffer  like(buffer_t) const;
  o_fldname like(fieldnme_t);
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pr;
