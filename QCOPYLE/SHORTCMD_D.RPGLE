      *
      /COPY QCOPYLE,D_VARDEF                     ?
      *
     D ShortCmd_t      DS                  qualified template
     D  SC_Action                    10A                     INZ(*BLANKS)
     D  SC_Cmd                             LIKE(r§pgmCmdDt ) INZ(*BLANKS)
     D   SC_File                           LIKE(r§file     ) OVERLAY(SC_Cmd: 1)
     D   SC_Lib                            LIKE(r§lib      ) OVERLAY(SC_Cmd:11)
     D   SC_Mbr                            LIKE(r§mbr      ) OVERLAY(SC_Cmd:21)
      *
