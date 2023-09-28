
      /if defined(internal_prototype)
     D PEEK27          PR                  extpgm('PEEK27')
      /else
     D PEEK27          PR                  extpgm(PEEK27_NAME)
      /endif
     D  i_pgm                              const like(pgm_t)
     D  o_choices                                like(choice_t) dim(32)
     D  o_numChoices                             like(int4_t)
     D  o_exclKeys                         const like(pgmCmd_t) dim(25)
     D                                           options(*nopass)
      *
