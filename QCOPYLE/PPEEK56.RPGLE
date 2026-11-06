**free

/if defined(internal_prototype)
dcl-pr peek56 extpgm('PEEK56');
/else
dcl-pr peek56 extpgm(peek56_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_mode      like(mode_t) const;
  i_envfile   like(file_t) const;
  i_envlib    like(lib_t) const;
  i_envmbr    like(mbr_t) const;
  i_rcdfmtid  like(fmtid_t) const;
  o_qfile     likeds(qobj_t);
  o_mbr       like(mbr_t);
  o_text      like(text_t);
  o_option    like(option_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
