**free
/if defined(internal_prototype)
dcl-pr exit03 extpgm('EXIT03');
/else
dcl-pr exit03 extpgm(exit03_name);
/endif
  gi_file    char(10) const;
  gi_lib     char(10) const;
  gi_user    char(10) const;
  gi_field   char(10) const;
  gio_edtcde char(1);
end-pr;

