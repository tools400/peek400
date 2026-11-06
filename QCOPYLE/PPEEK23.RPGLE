**free

/if defined(internal_prototype)
dcl-pr peek23 extpgm('PEEK23');
/else
dcl-pr peek23 extpgm(peek23_name);
/endif
  i_pgm       like(pgm_t) const;
  i_key       like(key_t) const;
  i_posf24    like(int4_t) const;
  o_fkeys     like(fkeydsp_t) dim(32);
  o_nbrofkeys like(int4_t);
  i_exclKeys  like(pgmcmd_t) dim(25) options(*nopass) const;
end-pr;

