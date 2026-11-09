**free

/if defined(internal_prototype)
dcl-pr peek56 extpgm('PEEK56');
/else
dcl-pr peek56 extpgm(peek56_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_mode      like(mode_t) const;
  i_envFile   like(file_t) const;
  i_envLib    like(lib_t) const;
  i_envMbr    like(mbr_t) const;
  i_rcdFmtID  like(fmtId_t) const;
  o_qFile     likeds(qObj_t);
  o_mbr       like(mbr_t);
  o_text      like(text_t);
  o_option    like(option_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;
