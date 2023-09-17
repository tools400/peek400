      *
      *============================================================*
      *      Modul: Peek053                                        *
      *============================================================*
      *
     D R§SECTION       S             10A   based(ptrDummy)
     D R§KEY           S             10A   based(ptrDummy)
     D R§SET0000       S            256A   based(ptrDummy)                                    RADDAT
      *
      *-------------------------------------------------------------------*
     D p_crtUsrSg      PR
     D  i_prodLib                          const  like(r§lib     )
     D  i_user                             const  like(r§user    )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_getUsrSg      PR                         like(R§SET0000 )
     D  i_key                              const  like(R§KEY     )
     D  o_msgID                       7A   options(*NOPASS)
     D  o_msgDta                    512A   options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_updUsrSg      PR
     D  i_key                              const  like(R§KEY     )
     D  i_data                             const  like(R§SET0000 )
      *
      *-------------------------------------------------------------------*
     D f_chainUsr      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  o_data                                    like(R§SET0000 )
      *
      *-------------------------------------------------------------------*
     D f_updatUsr      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  i_data                             const  like(R§SET0000 )
      *
      *-------------------------------------------------------------------*
     D f_deletUsr      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
      *
      *-------------------------------------------------------------------*
     D f_writeUsr      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  i_data                                    like(R§SET0000 )
      *
      *-------------------------------------------------------------------*
     D p_setllUsr      PR
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setgtUsr      PR
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D f_readeUsr      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  o_key                                     like(R§KEY     )
     D                                            options(*NOPASS)
     D  o_data                                    like(R§SET0000 )
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setllDft      PR
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                     options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D f_readeDft      PR                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  o_key                                     like(R§KEY     )
     D                                            options(*NOPASS)
     D  o_data                                    like(R§SET0000 )
     D                                            options(*NOPASS)
      *
      *-------------------------------------------------------------------*
     D p_setUsr        PR                                                                     RADDAT
     D  i_user                             const  like(R§USER    )                            RADDAT
     D  i_file                             const  like(R§FILE    )                            RADDAT
     D  i_lib                              const  like(R§LIB     )                            RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*
     D f_getUsr        PR                         like(R§USER    )                            RADDAT
     D  o_file                                    like(R§FILE    )                            RADDAT
     D  o_lib                                     like(R§LIB     )                            RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D p_chkSgFile     PR                                                                     RADDAT
     D  i_file                             const  like(R§FILE    )                            RADDAT
     D  i_lib                              const  like(R§LIB     )                            RADDAT
      *
      *-------------------------------------------------------------------*
      *
