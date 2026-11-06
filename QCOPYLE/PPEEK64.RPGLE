**free

/if defined(internal_prototype)
dcl-pr peek64 extpgm('PEEK64');
/else
dcl-pr peek64 extpgm(peek64_name);
/endif
  i_dsp80      like(dsp80_t) const;
  i_headType   like(headTyp_t) const;
  i_copyright  like(copyright_t) const;
  i_fldName    like(fieldNme_t) const;
  io_fldInhalt likeds(fldInhalt_t);
  io_length    like(int4_t);
  i_protect    like(bool_t) const;
  i_isUcs2     like(int4_t) const;
  o_msgID      like(msgId_t);
  o_msgDta     like(msgDta_t);
end-pr;
