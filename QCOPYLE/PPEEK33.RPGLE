
      /if defined(internal_prototype)
     D PEEK33          PR                  extpgm('PEEK33')
      /else
     D PEEK33          PR                  extpgm(PEEK33_NAME)
      /endif
     D  i_version                     9A   const
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
