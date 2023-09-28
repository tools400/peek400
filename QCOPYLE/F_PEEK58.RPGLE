      *
      *============================================================*
      *      Modul: Peek058                                        *
      *============================================================*
      *
      *  Konstants: f_wordWrap()
     D cWORDWRAP_PARAGRAPH_NONE...
     D                 C                   const(1)
     D cWORDWRAP_PARAGRAPH_MSGD...
     D                 C                   const(2)
     D cWORDWRAP_PARAGRAPH_TEXT...
     D                 C                   const(4)
     D cWORDWRAP_PARAGRAPH_TRIMR...
     D                 C                   const(8)
      *
      *-------------------------------------------------------------------*
     D f_dsplyLn       PR                         like(r§int4      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_buffLn        PR                         like(r§int4      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLen                          const  like(r§bool      )
     D                                            options(*nopass)
      *
      *
      *-------------------------------------------------------------------*
     D f_curFldLn      PR                         like(r§int4      )
     D  i_buffer                           const  like(r§rcdBuf    )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *
      *-------------------------------------------------------------------*
     D f_rtvFld        PR                         opdesc like(r§int4    )
     D  o_buffer                                  like(r§rcdBuf    )
     D                                            options(*varsize)
     D  i_buffer                           const  like(r§rcdBuf    )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLenByte                      const  like(r§bool      )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D p_fldToBuf      PR
     D  io_buffer                                 like(r§rcdbuf    )
     D  i_fieldData                               like(r§rcdbuf    )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLenByte                      const  like(r§bool      )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_isVarLen      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_binToDec      PR                  opdesc like(r§int4    )
     D  i_string                  32767A   const options(*varsize)
     D  i_startPos                         const  like(r§int4    )
     D  i_length                           const  like(r§int4    )
      *
      *-------------------------------------------------------------------*
     D f_len           PR                  opdesc like(r§int4    )
     D  i_string                  32767A   const options(*varsize)
      *
      *-------------------------------------------------------------------*
      *
     D f_scan          PR                  opdesc like(r§int4    )
     D  SrchArg                     100A   CONST  OPTIONS(*VARSIZE)
     D  String                      100A   CONST
      *
      *-------------------------------------------------------------------*
     D f_vldName       PR                         like(r§bool    )
     D  i_name                       10A   const
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_vldFloat      PR                         like(r§bool    )
     D  i_buffer                     64A   const  varying
      *
      *-------------------------------------------------------------------*
     D f_execute       PR                  opdesc like(r§bool    )
     D  i_cmd                     32702A   const
     D                                     options(*VARSIZE)
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_basedPF       PR                         like(r§bool   )
     D  i_file                             value  like(r§file   )
     D  i_lib                              value  like(r§lib    )
     D  i_mbr                              value  like(r§mbr    )
     D  i_rcdFmt                           value  like(r§rcdFmt )
     D  i_rcdMbrNbr                        value  like(r§mbrNbr )
     D  o_pFile                                   like(r§file   )
     D  o_pLib                                    like(r§lib    )
     D  o_pMbr                                    like(r§mbr    )
     D  o_pRcdFmt                                 like(r§rcdFmt )
      *
     D f_basedMbr      PR                         like(r§bool    )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_mbrNbr                           value  like(r§int4    )
     D  i_rcdFmt                           value  like(r§rcdFmt  )
     D  o_pFile                                   like(r§file    )
     D  o_pLib                                    like(r§lib     )
     D  o_pMbr                                    like(r§mbr     )
     D  o_rcdFmt                                  like(r§rcdFmt  )
      *
     D f_numBased      PR                         like(r§int4    )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D  i_mbr                              const  like(r§mbr     )
      *
      *-------------------------------------------------------------------*
     D p_setPrdLb      PR
     D  i_lib                              const  like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D f_getPrdLb      PR                         like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D f_cmdLine       PR                         like(r§bool    )
      *
      *
      *-------------------------------------------------------------------*
     D p_expStr        PR                  opdesc
     D  o_string                  32767A          options(*varsize)
     D  i_string                  32767A   const  options(*varsize)
     D  i_stepVal                    10I 0 const  options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_headline      PR                  like(r§colHeading)
     D  i_headTyp                          const  like(r§type)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_isNumFld      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_isFloatFld    PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_isCharFld     PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_hasCcsid      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_appMsgF       PR                         like(r§file    )
      *
      *-------------------------------------------------------------------*
     D f_appMsgFL      PR                         like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D p_rmvPgmMg      PR
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_sndPgmMg      PR
     D  i_msgID                                   like(r§msgID   )
     D  i_msgDta                                  like(r§msgDta  )
     D  i_pgmNme                           const  like(r§pgm     )
     D  i_msgType                          const  like(r§msgType )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_canUseRefFld  PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_canUseCntFld  PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_mustCvtCcsid  PR                         like(r§bool      )
      *
      *-------------------------------------------------------------------*
     D f_isToLong      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_isToLongMax   PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_maxDspLn      PR                         like(r§int4    )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_cntFldLn      PR                         like(r§int4    )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_nbrDspRw      PR                         like(r§int4      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D p_decToBin      PR                  opdesc
     D  io_string                 32767A          options(*varsize)
     D  i_startPos                         const  like(r§int4    )
     D  i_length                           const  like(r§int4    )
     D  i_value                            const  like(r§int4    )
      *
      *-------------------------------------------------------------------*
     D f_isNotAlw      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_isKeyFld      PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D p_sndStsMg      PR
     D  i_msgID                            const  like(r§msgID   )
     D  i_msgDta                           const  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_pgmCallN      PR                         like(r§pgmCallN)
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D f_rtvMsgD       PR          2048A
     D  i_msgID                            value  like(r§msgID   )
     D  i_msgDta                           value  like(r§msgDta  )
     D  i_rplcSubV                         const  like(r§bool    )
     D                                            options(*nopass)
     D  i_rtnFmtCC                         const  like(r§bool    )
     D                                            options(*nopass)
     D  i_msgF                             value  like(r§file    )
     D                                            options(*nopass)
     D  i_msgFL                            value  like(r§lib     )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_msgText       PR           512A
     D  i_msgID                            value  like(r§msgID   )
     D  i_msgDta                           value  like(r§msgDta  )
     D  i_msgF                             value  like(r§file    )
     D                                            options(*nopass)
     D  i_msgFL                            value  like(r§lib     )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D p_movPgmMg      PR
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_wrongKey      PR
     D  i_scnAID                           const  like(r§scnAID  )
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_keyToMsg      PR
     D  i_scnAID                           const  like(r§scnAID  )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_spltTxt       PR                  opdesc like(r§int4    )
     D  i_text                    32767A   const  options(*varsize)
     D  i_strPos                           const  like(r§int4    )
     D  i_len                              const  like(r§int4    )
     D  o_text                    32767A          options(*varsize)
      *
      *-------------------------------------------------------------------*
     D p_center        PR                  opdesc
     D  i_text                    32767A          options(*varsize)
      *
      *===================================================================*
     D  p_hexToChr     PR                  extproc('cvthc')
     D   Char                     32767A   options(*varsize)
     D   Hex                      32767A   options(*varsize)
     D   lenHex                      10I 0 value
      *
      *-------------------------------------------------------------------*
     D  p_chrToHex     PR                  extproc('cvtch')
     D   Hex                      32767A   options(*varsize)
     D   Char                     32767A   options(*varsize)
     D   lenChar                     10I 0 value
      *
      *-------------------------------------------------------------------*
     D f_addPtr        PR              *
     D  i_pointer                      *   value
     D  i_offset                      5I 0 value
      *
      *-------------------------------------------------------------------*
     D f_isKeyExc      PR                        like(r§bool    )
     D  i_data                             value like(R§SET0000 )
     D  i_exclKeys                         value like(r§pgmCmd  ) DIM(25)
      *
      *-------------------------------------------------------------------*
     D f_NUM_Descr...
     D                 PR            10I 0
     D  i_type                        3I 0 value
     D  i_length                      3I 0 value
     D  i_fraction                    3I 0 value
      *
      *-------------------------------------------------------------------*
     D f_NUM_Descr2...
     D                 PR            10I 0
     D  i_type                        1A   value
     D  i_length                      3I 0 value
     D  i_fraction                    3I 0 value
      *
      *-------------------------------------------------------------------*
     D p_clrErrno...
     D                 PR
      *
      *-------------------------------------------------------------------*
     D f_errno...
     D                 PR            10I 0
      *
      *-------------------------------------------------------------------*
     D f_strerror...
     D                 PR                         like(r§msgDta )
     D  i_errno                      10I 0 const
      *
      *-------------------------------------------------------------------*
     D f_bitor...
     D                 PR            10U 0
     D  i_arg1                       10U 0 value
     D  i_arg2                       10U 0 value
     D  i_arg3                       10U 0 value  options(*nopass)
     D  i_arg4                       10U 0 value  options(*nopass)
     D  i_arg5                       10U 0 value  options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_rpgToIntLength...
     D                 PR            10I 0
     D  i_length                     10I 0 value
      *
      *-------------------------------------------------------------------*
     D f_exist...
     D                 PR              N
     D  i_obj                        10A   const
     D  i_lib                        10A   const  options(*omit)
     D  i_type                       10A   const
     D  i_mbr                        10A   const  options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_wordWrap...
     D                 PR          4096A          varying
     D  i_string                   4096A   const  varying
     D  i_width                      10U 0 const
     D  io_startPos                  10U 0
     D  i_options                    10U 0 const  options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_endsWith...
     D                 PR              N
     D  i_suffix                   4096A   const   varying
     D  i_string                   4096A   const   varying
      *
      *-------------------------------------------------------------------*
      *  Converts a given string to upper case.
     D f_ucase...
     D                 PR          4096A           varying
     D  i_string                   4096A   const   varying
      *
      *-------------------------------------------------------------------*
      *  Sends a message to the command line.
     D f_sndMsgToCmdLine...
     D                 PR
     D  i_msgID                       7A   const
     D  i_msgDta                    512A   const
      *
      *-------------------------------------------------------------------*
      *  Returns the field type as a string.
     D f_fieldTypeAsString...
     D                 PR           128A          varying
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
      *  Returns the next headline.
     D f_nextHeaderType...
     D                 PR            10A
     D  i_headerType                 10A   value
      *
      *-------------------------------------------------------------------*
      *  Returns the record format ID of a given file.
     D f_getRecordFormatInf...
     D                 PR                  likeds(r§rcdFmtInf)
     D  i_file                             value  like(r§file)
     D  i_library                          value  like(r§lib)
     D  i_rcdFmt                           value  like(r§fmtID)
      *
      *-------------------------------------------------------------------*
      *  Returns an empty string with a given length.
     D f_space...
     D                 PR          4096A   varying
     D  i_length                     10I 0 value
      *
      *-----------------------------------------------------------------*
      * Prototype for CEEDOD (Retrieve operational descriptor)
      *-----------------------------------------------------------------*
     D CEEDOD          PR
     D  ParmNum                      10I 0 CONST
     D  DescType                     10I 0
     D  DataType                     10I 0
     D  DescInfo1                    10I 0
     D  DescInfo2                    10I 0
     D  InLen                        10I 0
     D  fc                           12A   OPTIONS(*OMIT)
      *-------------------------------------------------------------------*
     D p_kill          PR
     D  i_text                      128A   value  varying
      *
