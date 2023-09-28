
      /if defined(internal_prototype)
     D PEEK23          PR                  extpgm('PEEK23')
      /else
     D PEEK23          PR                  extpgm(PEEK23_NAME)
      /endif
     D  i_pgm                              const like(pgm_t)
     D  i_key                        10A   const
     D  i_posF24                           const like(int4_t)
     D  o_FKeys                                  like(fKeyDsp_t) dim(32)
     D  o_nbrOfKeys                              like(int4_t)
      *
