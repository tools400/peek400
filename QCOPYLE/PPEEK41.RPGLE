      *
      /if defined(internal_prototype)
     D PEEK41          PR                  extpgm('PEEK41')
      /else
     D PEEK41          PR                  extpgm(PEEK41_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_function                         const like(r§function)
     D  o_nbrOfEnt                               like(r§int4)
     D  o_data                      512A
      *
