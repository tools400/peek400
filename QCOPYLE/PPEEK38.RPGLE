
      /if defined(internal_prototype)
     D PEEK38          PR                  extpgm('PEEK38')
      /else
     D PEEK38          PR                  extpgm(PEEK38_NAME)
      /endif
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
     D  o_sqlOrder                               like(sqlOrder_t)
      *
