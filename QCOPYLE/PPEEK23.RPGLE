**FREE

/if defined(internal_prototype)
dcl-pr peek23 extpgm('PEEK23');
/else
dcl-pr peek23 extpgm(peek23_name);
/endif
  i_pgm                              const like(pgm_t);
  i_key                              const like(key_t);
  i_posf24                           const like(int4_t);
  o_fkeys                                  like(fkeydsp_t) dim(32);
  o_nbrofkeys                              like(int4_t);
  i_exclKeys      const like(fkeydsp_t) dim(8) options(*nopass);
end-pr;

