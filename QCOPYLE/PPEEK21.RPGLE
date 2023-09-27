                                                                                     *
      /if defined(internal_prototype)
     D PEEK21          PR                  extpgm('PEEK21')
      /else
     D PEEK21          PR                  extpgm(PEEK21_NAME)
      /endif
     D  i_scnAID                           const like(r§scnAid)
     D  i_pgm                              const like(r§pgm)
     D  o_pgmCmd                                 like(r§pgmCmd)
     D  o_cmdDta                                 like(r§pgmCmdDt)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
     D  i_exclKeys                         const like(r§pgmCmd) dim(25)
     D                                           options(*nopass)
      *
