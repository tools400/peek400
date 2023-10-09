**FREE
/if defined(internal_prototype)
dcl-pr exit02        extpgm('EXIT02');
/else
dcl-pr exit02        extpgm(exit02_name);
/endif
  gio_user        like(user_t);
  gio_file        like(file_t);
  gio_lib         like(lib_t);
  go_msgid        like(msgid_t);
  go_msgdta       like(msgdta_t);
end-pr;

