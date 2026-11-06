**free

/if defined(internal_prototype)
dcl-pr peek68 extpgm('PEEK68');
/else
dcl-pr peek68 extpgm(peek68_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_pgm       like(pgm_t) const;
  i_copyright like(copyrght_t) const;
  o_sflopt    like(sfpau_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
