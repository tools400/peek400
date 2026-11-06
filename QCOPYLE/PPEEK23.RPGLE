**free

/if defined(internal_prototype)
dcl-pr peek23 extpgm('PEEK23');
/else
dcl-pr peek23 extpgm(peek23_name);
/endif
  i_pgm       like(pgm_t) const;
  i_key       like(KEY_t) const;
  i_posF24    like(int4_t) const;
  o_FKeys     like(fKeyDsp_t) dim(32);
  o_nbrOfKeys like(int4_t);
  i_exclKeys  like(pgmCmd_t) dim(25) options(*nopass) const;
end-pr;

