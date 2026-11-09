**free

/if defined(internal_prototype)
dcl-pr peek08 extpgm('PEEK08');
/else
dcl-pr peek08 extpgm(peek08_name);
/endif
  i_qFile   like(qObj_t) const;
  i_pgm     like(pgm_t) const;
  i_rcdFmt  like(rcdFmt_t) const;
  i_fmtId   like(fmtId_t) const;
  i_alwLC   like(bool_t) const;
  i_case    like(bool_t) const;
  i_rcdLock like(bool_t) const;
  i_nullDft like(bool_t) const;
  i_keepCrs like(bool_t) const;
  i_prodLib like(lib_t) const;
  o_isError like(bool_t);
end-pr;
