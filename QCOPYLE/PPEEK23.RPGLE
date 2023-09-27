
      /if defined(internal_prototype)
     D PEEK23          PR                  extpgm('PEEK23')
      /else
     D PEEK23          PR                  extpgm(PEEK23_NAME)
      /endif
     D  i_pgm                              const like(r§pgm)
     D  i_key                        10A   const
     D  i_posF24                           const like(r§int4)
     D  o_FKeys                                  like(r§fKeyDsp) dim(32)
     D  o_nbrOfKeys                              like(r§int4)
      *
