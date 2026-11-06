**free

/if defined(internal_prototype)
dcl-pr peek05 extpgm('PEEK05');
/else
dcl-pr peek05 extpgm(peek05_name);
/endif
  io_qfile    likeds(qobj_t);
  i_member    like(mbr_t) const;
  i_access    like(accessmode_t) const;
  i_prodlib   like(lib_t) const;
  i_chglib    like(bool_t) const;
  i_chgfile   like(bool_t) const;
  i_chgmbr    like(bool_t) const;
  i_updmodkey like(bool_t) const;
  i_chgsqlw   like(bool_t) const;
  i_chgsqlo   like(bool_t) const;
  i_qenvfile  likeds(qobj_t) const;
  i_envmbr    like(mbr_t) const;
  i_envsave   like(bool_t) const;
  i_envlayout like(bool_t) const;
  i_sqlwhere  like(sqlwhere_t) const;
  i_sqlorder  like(sqlorder_t) const;
end-pr;
