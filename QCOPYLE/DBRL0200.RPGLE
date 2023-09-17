?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about DBRL0200:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  list API format DBRL0200                                                             RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XLIST into its units.)                                                     RADDAT
     D DBRL0200        DS                                                                     RADDAT
     D  B2FNmeUsed             1     10A                                                      RADDAT
     D  B2LNmeUsed            11     20A                                                      RADDAT
     D  B2MNmeUsed            21     30A                                                      RADDAT
     D  B2DepFile             31     40A                                                      RADDAT
     D  B2DepLib              41     50A                                                      RADDAT
     D  B2DepMbr              51     60A                                                      RADDAT
     D  B2DepType             61     61A                                                      RADDAT
     D  B2Res_01              62     64A                                                      RADDAT
     D  B2JoinRNbr            65     68I 0                                                    RADDAT
     D  B2JoinFNbr            69     72I 0                                                    RADDAT
     D  B2CnstNmeLib          73     82A
     D  B2CnstNmeLen          83     86I 0                                                    RADDAT
     D  B2CnstNme             87    344A                                                      RADDAT
      *                                                                                       RADDAT
