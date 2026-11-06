**free

/if defined(internal_prototype)
dcl-pr peek34 extpgm('PEEK34');
/else
dcl-pr peek34 extpgm(peek34_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_function  like(option_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
