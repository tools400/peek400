**FREE

//  Work fields for calculating the cursor position
dcl-ds cursorposition_t
       qualified template;
  row             int(10);
  column          int(10);
end-ds;

dcl-ds workstn_t qualified template;
  isOpen          char(1) pos(9);
  status          zoned(5) pos(11);
  numrows         int(5) pos(152);
  offset          int(5) pos(241);
  aid             char(1) pos(369);
  csrpos          int(5);
end-ds;

//====================================================*
//  AID-Byte                                          *
//====================================================*

dcl-c k_f1     x'31';
dcl-c k_f2     x'32';
dcl-c k_f3     x'33';
dcl-c k_f4     x'34';
dcl-c k_f5     x'35';
dcl-c k_f6     x'36';
dcl-c k_f7     x'37';
dcl-c k_f8     x'38';
dcl-c k_f9     x'39';
dcl-c k_f10    x'3A';
dcl-c k_f11    x'3B';
dcl-c k_f12    x'3C';
dcl-c k_f13    x'B1';
dcl-c k_f14    x'B2';
dcl-c k_f15    x'B3';
dcl-c k_f16    x'B4';
dcl-c k_f17    x'B5';
dcl-c k_f18    x'B6';
dcl-c k_f19    x'B7';
dcl-c k_f20    x'B8';
dcl-c k_f21    x'B9';
dcl-c k_f22    x'BA';
dcl-c k_f23    x'BB';
dcl-c k_f24    x'BC';

dcl-c k_clear  x'BD';
dcl-c k_delete x'BD';

dcl-c k_enter  x'F1';
// Nicht definiert:  F2
dcl-c k_help   x'F3';
dcl-c k_page_down x'F4';
dcl-c k_page_up x'F5';
dcl-c k_print_screen x'F6';
// Nicht definiert:  F7
dcl-c k_reset x'F8';

dcl-c k_light_pen x'3F';

