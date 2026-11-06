**free

/if defined(internal_prototype)
dcl-pr peek16 extpgm('PEEK16');
/else
dcl-pr peek16 extpgm(peek16_name);
/endif
  i_prodlib   like(lib_t) const;
  i_qfile     likeds(qobj_t) const;
  i_rcdfmt    like(rcdfmt_t) const;
  i_scnnbrs   like(int2_t) const;
  i_alwlc     like(bool_t) const;
  i_case      like(bool_t) const;
  i_rcdlock   like(bool_t) const;
  i_nulldft   like(bool_t) const;
  i_keepcrs   like(bool_t) const;
  io_stage    like(int4_t);
  i_numpasses like(int4_t) const;
end-pr;
