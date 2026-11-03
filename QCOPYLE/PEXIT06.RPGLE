**free
/if defined(internal_prototype)
dcl-pr exit06 extpgm('EXIT06');
/else
dcl-pr exit06 extpgm(exit06_name);
/endif
  gi_file  char(10) const;
  gi_lib   char(10) const;
  gi_user  char(10) const;
  gi_field char(10) const;
  gio_col1 char(20);
  gio_col2 char(20);
  gio_col3 char(20);
  gio_text char(50);
end-pr;
