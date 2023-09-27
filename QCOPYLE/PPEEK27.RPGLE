
      /if defined(internal_prototype)
     D PEEK27          PR                  extpgm('PEEK27')
      /else
     D PEEK27          PR                  extpgm(PEEK27_NAME)
      /endif
     D  i_pgm                              const like(r§pgm)
     D  o_choices                                like(r§choice) dim(32)
     D  o_numChoices                             like(r§int4)
     D  o_exclKeys                         const like(r§pgmCmd) dim(25)
     D                                           options(*nopass)
      *
