      *===============================================================*
      *                                                               *
      *  Additional information about MBRD0200:                       *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
      *  API format MBRD0200
      *  (data structure can be used within the calling program
      *  to splitt XValue into its units.)
     D MBRD0300_t      DS                  qualified template
     D  M3BytRet                     10I 0
     D  M3BytAvl                     10I 0
     D  M3File                       10A
     D  M3Library                    10A
     D  M3Member                     10A
     D  M3Attr                       10A
     D  M3SrcTyp                     10A
     D  M3ObjCrtDt                   13A
     D  M3SrcChgDt                   13A
     D  M3Text                       50A
     D  M3SrcFile                     1A
     D  M3Remote                      1A
     D  M3FileTyp                     1A
     D  M3ODPShare                    1A
     D  M3Res_01                      2A
     D  M3NbrRcdOn                   10I 0
     D  M3NbrRcdDl                   10I 0
     D  M3DtaSpcSz                   10U 0
     D  M3AccSpcSz                   10U 0
     D  M3NumBasedOnMbr...
     D                               10I 0
     D  M3ChgDateTime                13A
     D  M3SavDateTime                13A
     D  M3RstDateTime                13A
     D  M3ExpDate                     7A
     D  M3Reserved_1                  4A
     D  M3MediaPref                   5I 0
     D  M3NumDaysUsed                10I 0
     D  M3DateLstUsed                 7A
     D  M3UseResDate                  7A
     D  M3Reserved_2                  2A
     D  M3DtaSizeMult                10I 0
     D  M3AccSizeMult                10I 0
     D  M3MbrTxtCcsid                10I 0
     D  M3OfsAddInf                  10I 0
     D  M3LenAddInf                  10I 0
     D  M3NumRcds                    10U 0
     D  M3NumDltRcds                 10U 0
     D  M3Reserved_3                  6A
     D  M3JoinMbr                     1A
     D  M3AccPathMaint...
     D                                1A
     D  M3SqlFileType                10A
     D  M3Reserved_4                  1A
     D  M3AlwRead                     1A
     D  M3AlwWrite                    1A
     D  M3AlwUpdate                   1A
     D  M3AlwDelete                   1A
     D  M3Reserved_5                  1A
     D  M3RcdsForceWrite...
     D                               10I 0
     D  M3MaxPercentDltRcdsAlw...
     D                               10I 0
     D  M3InitNumRcds                10I 0
     D  M3IncNumRcds                 10I 0
     D  M3MaxNumInc                  10I 0
     D  M3CurrNumInc                 10U 0
     D  M3RcdCapacity                10U 0
     D  M3RcdSlcPgm                  10A
     D  M3RcdSlcLib                  10A
     D  M3NumCstIdx                   5I 0
     D  M3OfsCstIdxInf...
     D                               10I 0
     D  M3Reserved_6                 46A
      *   Array of CHAR(112)	Record format and based-on file list
      *   Array of CHAR(320)	Constraint indexes information
      *
      *  Record Format and Based-On File List Entry
     D MBRD0300_basedOnE_t...
     D                 DS                  qualified template
     D  basedOnFile                  10A
     D  basedOnLib                   10A
     D  basedOnMbr                   10A
     D  fmtname                      10A
     D  lfrcdfmtnbr                  10I 0
     D  nbrrcds                      10I 0
     D  nbrdltrcds                   10I 0
     D  accpathsize                  10I 0
     D  accpathsizem                 10I 0
     D  accpathshared                 1A
     D  accpathvalid                  1A
     D  accpathheld                   1A
     D  accpathownrfile...
     D                               10A
     D  accpathownrlib...
     D                               10A
     D  accpathownrmbr...
     D                               10A
     D  accpathjrn                    1A
     D  reserved_1                    2A
     D  nbrrcdsu                     10I 0
     D  nbrdltrcdsu                  10I 0
     D  reserved_2                    8A
      *
