**free

/if defined(internal_prototype)
dcl-pr peek15 extpgm('PEEK15');
/else
dcl-pr peek15 extpgm(peek15_name);
/endif
  i_qfile     likeds(qobj_t) const;
  io_scnnbrs  like(int2_t);
  i_alwlc     like(bool_t) const;
  io_stage    like(int4_t);
  i_numpasses like(int4_t) const;
end-pr;
