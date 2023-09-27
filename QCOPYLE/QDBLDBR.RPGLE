      /if not defined(QDBLDBR)
      /define QDBLDBR
      *
      *  List Database Relations (QDBLDBR) API
     D QDBLDBR...
     D                 PR                  extpgm('QDBLDBR')
     D  i_qUsrSpc                    20A   const
     D  i_format                      8A   const
     D  i_qFile                      20A   const
     D  i_mbr                        10A   const
     D  i_rcdFmt                     10A   const
     D  io_errCode                65535A          options(*varsize )
      *
      /endif
