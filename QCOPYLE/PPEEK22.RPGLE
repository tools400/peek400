**free

/if defined(internal_prototype)
dcl-pr peek22 extpgm('PEEK22');
/else
dcl-pr peek22 extpgm(peek22_name);
/endif
  i_mode    like(mode_t) const;
  i_section like(SECTION_t) const;
end-pr;
