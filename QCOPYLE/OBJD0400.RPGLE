      *===============================================================*
      *                                                               *
      *  Additional information about OBJD0400:                       *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
      *  API format OBJD0400
      *  (data structure can be used within the calling program
      *  to splitt XValue into its units.)
     D OBJD0400_t      DS                  qualified template
     D  O4BytRet               1      4I 0
     D  O4BytAvail             5      8I 0
     D  O4ObjName              9     18A
     D  O4ObjLib              19     28A
     D  O4ObjType             29     38A
     D  O4RetLib              39     48A
     D  O4AuxStPol            49     52I 0
     D  O4Owner               53     62A
     D  O4Domain              63     64A
     D  O4CrtDtTme            65     77A
     D  O4ChgDtTme            78     90A
     D  O4ExtAttr             91    100A
     D  O4Text               101    150A
     D  O4SrcFile            151    160A
     D  O4SrcLib             161    170A
     D  O4SrcMbr             171    180A
      *   :
     D                       181    472A
      *   :
     D  O4ObjSize            473    476I 0
     D  O4ObjSizeM           477    480I 0
      *
