**free

/if defined(internal_prototype)
dcl-pr peek52 extpgm('PEEK52');
/else
dcl-pr peek52 extpgm(peek52_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  o_alwlc     like(bool_t);
  o_case      like(bool_t);
  o_cdlock    like(bool_t);
  o_nulldft   like(bool_t);
  o_keepcrs   like(bool_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
  i_isunload  like(msgid_t) const;
end-pr;
