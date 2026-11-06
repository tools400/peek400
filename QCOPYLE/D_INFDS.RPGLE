**free
/if NOT defined(D_INFDS)
/define D_INFDS

dcl-ds infds_t qualified template;
  IsOpen   char(1) pos(9);
  // Status                11     15S 0
  file     char(10) pos(83);
  library  char(10);
  RcdLen   int(5) pos(125);
  member   char(10) pos(129);
  nbrOfRcd int(10) pos(156);
  // ommon I/O Feedback Area:             Offest = 241
  rcdFmt   char(10) pos(261);
  // /O Feedback Area for Database Files: Offset = 367
  // NbrOfKey             387    388I 0
  // Res01                389    392A
  // KeyLen               393    394I 0
  mbrNbr   int(5) pos(395);
  RcdNbr   int(10);
end-ds;

/endif
