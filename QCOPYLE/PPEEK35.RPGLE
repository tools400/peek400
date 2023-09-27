
      /if defined(internal_prototype)
     D PEEK35          PR                  extpgm('PEEK35')
      /else
     D PEEK35          PR                  extpgm(PEEK35_NAME)
      /endif
     D  i_rcdNbr                           const like(r§rcdNbr)
     D  i_buffer                   1024A   const
     D  o_fldName                                like(r§fieldNme)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
