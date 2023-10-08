
      /if defined(internal_prototype)
     D PEEK22          PR                  extpgm('PEEK22')
      /else
     D PEEK22          PR                  extpgm(PEEK22_NAME)
      /endif
     D  i_mode                       10A   const
     D  i_section                    10A   const
      *
