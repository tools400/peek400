**free

//============================================================*
//      Modul: Peek053
//============================================================*

dcl-s SECTION_t char(10) template;
dcl-s KEY_t char(10) template;
dcl-s SET0000_t char(256) template;

//-------------------------------------------------------------------*
dcl-pr p_crtUsrSg;
  i_prodLib like(lib_t) const;
  i_user    like(user_t) const;
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getUsrSg like(SET0000_t);
  i_key    like(KEY_t) const;
  o_msgID  char(7) options(*nopass);
  o_msgDta char(512) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_updUsrSg;
  i_key  like(KEY_t) const;
  i_data like(SET0000_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_chainUsr like(bool_t);
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) const;
  o_data    like(SET0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_updatUsr like(bool_t);
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) const;
  i_data    like(SET0000_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_deletUsr like(bool_t);
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_writeUsr like(bool_t);
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) const;
  i_data    like(SET0000_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setllUsr;
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setgtUsr;
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_readeUsr like(bool_t);
  i_section like(SECTION_t) const;
  o_key     like(KEY_t) options(*nopass);
  o_data    like(SET0000_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setllDft;
  i_section like(SECTION_t) const;
  i_key     like(KEY_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_readeDft like(bool_t);
  i_section like(SECTION_t) const;
  o_key     like(KEY_t) options(*nopass);
  o_data    like(SET0000_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setUsr;
  i_user like(user_t) const;
  i_file like(file_t) const;
  i_lib  like(lib_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getUsr like(user_t);
  o_file like(file_t);
  o_lib  like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_chkSgFile;
  i_file like(file_t) const;
  i_lib  like(lib_t) const;
end-pr;

//-------------------------------------------------------------------*

