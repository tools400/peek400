
      /if defined(internal_prototype)
     D PEEK38          PR                  extpgm('PEEK38')
      /else
     D PEEK38          PR                  extpgm(PEEK38_NAME)
      /endif
     D  i_file                             const like(r§file)
     D  i_lib                              const like(r§lib)
     D  o_sqlOrder                               like(r§sqlOrder)
      *
