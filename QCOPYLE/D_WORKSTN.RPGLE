      *
      *  Work fields for calculating the cursor position
     D cursorPosition_t...
     D                 ds                  qualified template
     D  row                    1      4I 0
     D  column                 5      8I 0
      *
     D workstn_t       ds                  qualified template
     D  open                   9      9A
     D  status                11     15S 0
     D  numRows              152    153I 0
     D  offset               241    242I 0
     D  aid                  369    369A
     D  csrPos               370    371I 0
      *
      *====================================================*
      *  AID-Byte                                          *
      *====================================================*
      *
     D K_F1            C                   X'31'
     D K_F2            C                   X'32'
     D K_F3            C                   X'33'
     D K_F4            C                   X'34'
     D K_F5            C                   X'35'
     D K_F6            C                   X'36'
     D K_F7            C                   X'37'
     D K_F8            C                   X'38'
     D K_F9            C                   X'39'
     D K_F10           C                   X'3A'
     D K_F11           C                   X'3B'
     D K_F12           C                   X'3C'
     D K_F13           C                   X'B1'
     D K_F14           C                   X'B2'
     D K_F15           C                   X'B3'
     D K_F16           C                   X'B4'
     D K_F17           C                   X'B5'
     D K_F18           C                   X'B6'
     D K_F19           C                   X'B7'
     D K_F20           C                   X'B8'
     D K_F21           C                   X'B9'
     D K_F22           C                   X'BA'
     D K_F23           C                   X'BB'
     D K_F24           C                   X'BC'
      *
     D K_CLEAR         C                   X'BD'
     D K_DELETE        C                   X'BD'
      *
     D K_ENTER         C                   X'F1'
      *          Nicht definiert             F2
     D K_HELP          C                   X'F3'
     D K_PAGE_DOWN     C                   X'F4'
     D K_PAGE_UP       C                   X'F5'
     D K_PRINT_SCREEN  C                   X'F6'
      *          Nicht definiert             F7
     D K_RESET         C                   X'F8'
      *
     D K_LIGHT_PEN     C                   X'3F'
      *
