**FREE

/if defined(internal_prototype)
dcl-pr peek60 extpgm('PEEK60');
/else
dcl-pr peek60 extpgm(peek60_name);
/endif
  i_alwlc                            const like(bool_t);
  o_numpasses                              like(int4_t);
end-pr;
