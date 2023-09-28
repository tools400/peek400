      *
      /if defined(internal_prototype)
     D PEEK41          PR                  extpgm('PEEK41')
      /else
     D PEEK41          PR                  extpgm(PEEK41_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_function                         const like(function_t)
     D  o_nbrOfEnt                               like(int4_t)
     D  o_data                      512A
      *
