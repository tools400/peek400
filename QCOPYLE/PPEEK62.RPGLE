
      /if defined(internal_prototype)
     D PEEK62          PR                  extpgm('PEEK62')
      /else
     D PEEK62          PR                  extpgm(PEEK62_NAME)
      /endif
     D  i_file                             const like(r§file)
     D  i_lib                              const like(r§lib)
      *
