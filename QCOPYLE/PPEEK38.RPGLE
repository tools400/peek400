**free

/if defined(internal_prototype)
dcl-pr peek38 extpgm('PEEK38');
/else
dcl-pr peek38 extpgm(peek38_name);
/endif
  i_file     like(file_t) const;
  i_lib      like(lib_t) const;
  o_sqlorder like(sqlorder_t);
end-pr;
