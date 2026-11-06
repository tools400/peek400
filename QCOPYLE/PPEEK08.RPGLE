**free

/if defined(internal_prototype)
dcl-pr peek08 extpgm('PEEK08');
/else
dcl-pr peek08 extpgm(peek08_name);
/endif
  i_qfile   like(qobj_t) const;
  i_pgm     like(pgm_t) const;
  i_rcdfmt  like(rcdfmt_t) const;
  i_fmtid   like(fmtid_t) const;
  i_alwlc   like(bool_t) const;
  i_case    like(bool_t) const;
  i_rcdlock like(bool_t) const;
  i_nulldft like(bool_t) const;
  i_keepcrs like(bool_t) const;
  i_prodlib like(lib_t) const;
  o_iserror like(bool_t);
end-pr;
