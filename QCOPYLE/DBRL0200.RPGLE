      *===============================================================*
      *                                                               *
      *  Additional information about DBRL0200:                       *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
      *  list API format DBRL0200
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units.)
     D DBRL0200_t      DS                  qualified template
     D  B2FNmeUsed             1     10A
     D  B2LNmeUsed            11     20A
     D  B2MNmeUsed            21     30A
     D  B2DepFile             31     40A
     D  B2DepLib              41     50A
     D  B2DepMbr              51     60A
     D  B2DepType             61     61A
     D  B2Res_01              62     64A
     D  B2JoinRNbr            65     68I 0
     D  B2JoinFNbr            69     72I 0
     D  B2CnstNmeLib          73     82A
     D  B2CnstNmeLen          83     86I 0
     D  B2CnstNme             87    344A
      *
