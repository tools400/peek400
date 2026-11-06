**free

/if defined(internal_prototype)
dcl-pr peek13 extpgm('PEEK13');
/else
dcl-pr peek13 extpgm(peek13_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_mbr      like(mbr_t) const;
  o_mbrd0200 likeds(mbrd0200_t);
end-pr;
