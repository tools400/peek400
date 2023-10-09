**FREE

/if defined(internal_prototype)
dcl-pr peek38 extpgm('PEEK38');
/else
dcl-pr peek38 extpgm(peek38_name);
/endif
  i_file                             const like(file_t);
  i_lib                              const like(lib_t);
  o_sqlorder                               like(sqlorder_t);
end-pr;
