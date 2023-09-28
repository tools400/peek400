
      /if defined(internal_prototype)
     D PEEK62          PR                  extpgm('PEEK62')
      /else
     D PEEK62          PR                  extpgm(PEEK62_NAME)
      /endif
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
      *
