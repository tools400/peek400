**FREE

/if defined(internal_prototype)
dcl-pr peek29 extpgm('PEEK29');
/else
dcl-pr peek29 extpgm(peek29_name);
/endif
  i_sysname       char(8) const;
  i_sysversion    char(6) const;
  i_syssrlnbr     char(8) const;
  i_sysdate       int(10) const;
  o_serialnbr     char(20);
end-pr;
