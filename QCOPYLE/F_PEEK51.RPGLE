      *
      *============================================================*
      *      Modul: Peek051                                        *
      *============================================================*
      *
     D SQL_prepareStatement...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_prepareStatement')
     D  i_check                            value  like(bool_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_mbr                              value  like(mbr_t)
     D  i_format                           value  like(rcdFmt_t)
     D  i_sqlSelect                 512A   value
     D  i_sqlOrder                  512A   value
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
      *
     D SQL_open...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_open')
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_nextRow...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_nextRow')
     D  o_buffer                                  like(rcdBuf_t)
     D  o_nullMap                                 like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_previousRow...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_previousRow')
     D  o_buffer                                  like(rcdBuf_t)
     D  o_nullMap                                 like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_gotoTop...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_gotoTop')
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_gotoBottom...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_gotoBottom')
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_close...
     D                 PR                         like(bool_t)
     D                                     extproc('SQL_close')
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D SQL_quote...
     D                 PR           512A
     D                                     extproc('SQL_quote')
     D  i_string                    512A   const
      *
      *-------------------------------------------------------------------*
     D SQL_count...
     D                 PR            10I 0
     D                                     extproc('SQL_count')
      *-------------------------------------------------------------------*
      *
