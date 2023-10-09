**FREE

/if defined(internal_prototype)
dcl-pr peek22 extpgm('PEEK22');
/else
dcl-pr peek22 extpgm(peek22_name);
/endif
  i_mode                             const like(mode_t);
  i_section                          const like(section_t);
end-pr;
