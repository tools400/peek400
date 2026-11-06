**free

/if defined(internal_prototype)
dcl-pr peek57 extpgm('PEEK57');
/else
dcl-pr peek57 extpgm(peek57_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_envfile   like(file_t) const;
  i_envlib    like(lib_t) const;
  i_envmbr    like(mbr_t) const;
  i_envtext   like(text_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
