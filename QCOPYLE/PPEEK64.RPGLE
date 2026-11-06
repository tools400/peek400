**free

/if defined(internal_prototype)
dcl-pr peek64 extpgm('PEEK64');
/else
dcl-pr peek64 extpgm(peek64_name);
/endif
  i_dsp80      like(dsp80_t) const;
  i_headType   like(headtyp_t) const;
  i_copyright  like(copyrght_t) const;
  i_fldName    like(fieldnme_t) const;
  io_fldInhalt likeds(fldinhalt_t);
  io_length    like(int4_t);
  i_protect    like(bool_t) const;
  i_isUcs2     like(int4_t) const;
  o_msgId      like(msgid_t);
  o_msgDta     like(msgdta_t);
end-pr;
