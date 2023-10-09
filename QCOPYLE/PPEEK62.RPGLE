**FREE

/if defined(internal_prototype)
dcl-pr peek62 extpgm('PEEK62');
/else
dcl-pr peek62 extpgm(peek62_name);
/endif
  i_file                             const like(file_t);
  i_lib                              const like(lib_t);
end-pr;
