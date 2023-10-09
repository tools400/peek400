**FREE

//============================================================*
//      Modul: Peek053
//============================================================*

dcl-s section_t       char(10) template;
dcl-s key_t           char(10) template;
dcl-s set0000_t       char(256) template;

//-------------------------------------------------------------------*
dcl-pr p_crtusrsg;
  i_prodlib       const  like(lib_t);
  i_user          const  like(user_t);
  o_msgid                like(msgid_t);
  o_msgdta               like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getusrsg like(set0000_t);
  i_key           const  like(key_t);
  o_msgid                char(7) options(*nopass);
  o_msgdta               char(512) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_updusrsg;
  i_key           const  like(key_t);
  i_data          const  like(set0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_chainusr like(bool_t);
  i_section       const  like(section_t);
  i_key           const  like(key_t);
  o_data                 like(set0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_updatusr like(bool_t);
  i_section       const  like(section_t);
  i_key           const  like(key_t);
  i_data          const  like(set0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_deletusr like(bool_t);
  i_section       const  like(section_t);
  i_key           const  like(key_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_writeusr like(bool_t);
  i_section       const  like(section_t);
  i_key           const  like(key_t);
  i_data                 like(set0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setllusr;
  i_section       const  like(section_t);
  i_key           const  like(key_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setgtusr;
  i_section       const  like(section_t);
  i_key           const  like(key_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_readeusr like(bool_t);
  i_section       const  like(section_t);
  o_key                  like(key_t) options(*nopass);
  o_data                 like(set0000_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setlldft;
  i_section       const  like(section_t);
  i_key           const  like(key_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_readedft like(bool_t);
  i_section       const  like(section_t);
  o_key           like(key_t) options(*nopass);
  o_data          like(set0000_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setusr;
  i_user          const  like(user_t);
  i_file          const  like(file_t);
  i_lib           const  like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getusr like(user_t);
  o_file          like(file_t);
  o_lib           like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_chksgfile;
  i_file          const  like(file_t);
  i_lib           const  like(lib_t);
end-pr;

//-------------------------------------------------------------------*

