                                                                                     *
      /if defined(internal_prototype)
     D PEEK21          PR                  extpgm('PEEK21')
      /else
     D PEEK21          PR                  extpgm(PEEK21_NAME)
      /endif
     D  i_scnAID                           const like(scnAid_t)
     D  i_pgm                              const like(pgm_t)
     D  o_pgmCmd                                 like(pgmCmd_t)
     D  o_cmdDta                                 like(pgmCmdDt_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
     D  i_exclKeys                         const like(pgmCmd_t) dim(25)
     D                                           options(*nopass)
      *
