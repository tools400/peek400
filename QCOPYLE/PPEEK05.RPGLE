**FREE

/if defined(internal_prototype)
dcl-pr peek05 extpgm('PEEK05');
/else
dcl-pr peek05 extpgm(peek05_name);
/endif
  io_qfile                                 likeds(qobj_t);
  i_member                           const like(mbr_t);
  i_access                           const like(accessmode_t);
  i_prodlib                          const like(lib_t);
  i_chglib                           const like(bool_t);
  i_chgfile                          const like(bool_t);
  i_chgmbr                           const like(bool_t);
  i_updmodkey                        const like(bool_t);
  i_chgsqlw                          const like(bool_t);
  i_chgsqlo                          const like(bool_t);
  i_qenvfile                         const likeds(qobj_t);
  i_envmbr                           const like(mbr_t);
  i_envsave                          const like(bool_t);
  i_envlayout                        const like(bool_t);
  i_sqlwhere                         const like(sqlwhere_t);
  i_sqlorder                         const like(sqlorder_t);
end-pr;
