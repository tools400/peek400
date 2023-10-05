      *
      *============================================================*
      *      Modul: Peek053                                        *
      *============================================================*
      *
     D SECTION_t       S             10A   template
     D KEY_t           S             10A   template
     D SET0000_t       S            256A   template
      *
      *-------------------------------------------------------------------*
     D p_crtUsrSg      PR
     D  i_prodLib                          const  like(lib_t)
     D  i_user                             const  like(user_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D f_getUsrSg      PR                         like(SET0000_t)
     D  i_key                              const  like(KEY_t)
     D  o_msgID                       7A   options(*NOPASS)
     D  o_msgDta                    512A   options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_updUsrSg      PR
     D  i_key                              const  like(KEY_t)
     D  i_data                             const  like(SET0000_t)
      *
      *-------------------------------------------------------------------*
     D f_chainUsr      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  o_data                                    like(SET0000_t)
      *
      *-------------------------------------------------------------------*
     D f_updatUsr      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  i_data                             const  like(SET0000_t)
      *
      *-------------------------------------------------------------------*
     D f_deletUsr      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
      *
      *-------------------------------------------------------------------*
     D f_writeUsr      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  i_data                                    like(SET0000_t)
      *
      *-------------------------------------------------------------------*
     D p_setllUsr      PR
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setgtUsr      PR
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D f_readeUsr      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  o_key                                     like(KEY_t)
     D                                            options(*NOPASS)
     D  o_data                                    like(SET0000_t)
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setllDft      PR
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D                                     options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D f_readeDft      PR                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  o_key                                     like(KEY_t)
     D                                            options(*NOPASS)
     D  o_data                                    like(SET0000_t)
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setUsr        PR
     D  i_user                             const  like(USER_t)
     D  i_file                             const  like(FILE_t)
     D  i_lib                              const  like(LIB_t)
      *
      *-------------------------------------------------------------------*
     D f_getUsr        PR                         like(USER_t)
     D  o_file                                    like(FILE_t)
     D  o_lib                                     like(LIB_t)
      *
      *-------------------------------------------------------------------*
     D p_chkSgFile     PR
     D  i_file                             const  like(FILE_t)
     D  i_lib                              const  like(LIB_t)
      *
      *-------------------------------------------------------------------*
      *
