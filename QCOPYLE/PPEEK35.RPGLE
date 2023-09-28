
      /if defined(internal_prototype)
     D PEEK35          PR                  extpgm('PEEK35')
      /else
     D PEEK35          PR                  extpgm(PEEK35_NAME)
      /endif
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  i_buffer                   1024A   const
     D  o_fldName                                like(fieldNme_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
