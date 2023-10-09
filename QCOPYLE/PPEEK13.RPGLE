**FREE

/if defined(internal_prototype)
dcl-pr peek13 extpgm('PEEK13');
/else
dcl-pr peek13 extpgm(peek13_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_mbr                              const like(mbr_t);
  o_mbrd0200                               likeds(mbrd0200_t);
end-pr;
