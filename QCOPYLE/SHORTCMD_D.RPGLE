      *
      /COPY QCOPYLE,D_VARDEF                     ?
      *
     D ShortCmd_t      DS                  qualified template
     D  SC_Action                    10A                     INZ(*BLANKS)
     D  SC_Cmd                             LIKE(pgmCmdDt_t) INZ(*BLANKS)
     D   SC_File                           LIKE(file_t) OVERLAY(SC_Cmd: 1)
     D   SC_Lib                            LIKE(lib_t) OVERLAY(SC_Cmd:11)
     D   SC_Mbr                            LIKE(mbr_t) OVERLAY(SC_Cmd:21)
      *
