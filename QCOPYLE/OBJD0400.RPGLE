?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about OBJD0400:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  API format OBJD0400                                                                  RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XValue into its units.)                                                    RADDAT
     D OBJD0400        DS                                                                     RADDAT
     D  O4BytRet               1      4I 0                                                    RADDAT
     D  O4BytAvail             5      8I 0                                                    RADDAT
     D  O4ObjName              9     18A                                                      RADDAT
     D  O4ObjLib              19     28A                                                      RADDAT
     D  O4ObjType             29     38A                                                      RADDAT
     D  O4RetLib              39     48A                                                      RADDAT
     D  O4AuxStPol            49     52I 0                                                    RADDAT
     D  O4Owner               53     62A                                                      RADDAT
     D  O4Domain              63     64A                                                      RADDAT
     D  O4CrtDtTme            65     77A                                                      RADDAT
     D  O4ChgDtTme            78     90A                                                      RADDAT
     D  O4ExtAttr             91    100A                                                      RADDAT
     D  O4Text               101    150A                                                      RADDAT
     D  O4SrcFile            151    160A                                                      RADDAT
     D  O4SrcLib             161    170A                                                      RADDAT
     D  O4SrcMbr             171    180A                                                      RADDAT
?     *   :                                                                                   RADDAT
     D                       181    472A                                                      RADDAT
?     *   :                                                                                   RADDAT
     D  O4ObjSize            473    476I 0                                                    RADDAT
     D  O4ObjSizeM           477    480I 0                                                    RADDAT
?     *                                                                                       RADDAT
