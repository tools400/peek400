      *
      *  Work fields for calculating the cursor position
     D cursorPosition  ds                  qualified
     D  row                    1      4I 0
     D  column                 5      8I 0
      *
     D §Workstn        DS
     D  §Open                  9      9A
     D  §ScnStatus            11     15S 0
     D  §ScnNumRows          152    153I 0
     D  §ScnOffset           241    242I 0
     D  §ScnAID              369    369A
     D  §ScnCsrPos           370    371I 0
      *
      *====================================================*
      *  AID-Byte                                          *
      *====================================================*
      *
     D §F1             C                   CONST(X'31')
     D §F2             C                   CONST(X'32')
     D §F3             C                   CONST(X'33')
     D §F4             C                   CONST(X'34')
     D §F5             C                   CONST(X'35')
     D §F6             C                   CONST(X'36')
     D §F7             C                   CONST(X'37')
     D §F8             C                   CONST(X'38')
     D §F9             C                   CONST(X'39')
     D §F10            C                   CONST(X'3A')
     D §F11            C                   CONST(X'3B')
     D §F12            C                   CONST(X'3C')
     D §F13            C                   CONST(X'B1')
     D §F14            C                   CONST(X'B2')
     D §F15            C                   CONST(X'B3')
     D §F16            C                   CONST(X'B4')
     D §F17            C                   CONST(X'B5')
     D §F18            C                   CONST(X'B6')
     D §F19            C                   CONST(X'B7')
     D §F20            C                   CONST(X'B8')
     D §F21            C                   CONST(X'B9')
     D §F22            C                   CONST(X'BA')
     D §F23            C                   CONST(X'BB')
     D §F24            C                   CONST(X'BC')
      *
     D §Clear          C                   CONST(X'BD')
     D §Delete         C                   CONST(X'BD')
      *
     D §Enter          C                   CONST(X'F1')
      *          Nicht definiert                   F2
     D §Help           C                   CONST(X'F3')
     D §PageDown       C                   CONST(X'F4')
     D §PageUp         C                   CONST(X'F5')
     D §PrintScn       C                   CONST(X'F6')
      *          Nicht definiert                   F7
     D §Reset          C                   CONST(X'F8')
      *
     D §LightPen       C                   CONST(X'3F')
      *
