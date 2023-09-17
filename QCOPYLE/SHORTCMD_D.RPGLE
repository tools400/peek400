?     *                                                                                       RADDAT
CPY  /COPY QCOPYLE,D_VARDEF                     ?                                            RADDAT
?     *
     D ShortCmd        DS                                                                     RADDAT
     D  SC_Action                    10A                     INZ(*BLANKS)                     RADDAT
     D  SC_Cmd                             LIKE(r§pgmCmdDt ) INZ(*BLANKS)                     RADDAT
     D   SC_File                           LIKE(r§file     ) OVERLAY(SC_Cmd: 1)               RADDAT
     D   SC_Lib                            LIKE(r§lib      ) OVERLAY(SC_Cmd:11)               RADDAT
     D   SC_Mbr                            LIKE(r§mbr      ) OVERLAY(SC_Cmd:21)               RADDAT
?     *                                                                                       RADDAT
