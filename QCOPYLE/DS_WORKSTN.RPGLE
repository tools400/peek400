?     *                                                                                       RADDAT
?     *====================================================*                                  RADDAT
?     *  Cursorposition                                    *                                  RADDAT
?     *====================================================*                                  RADDAT
?     *                                                                                       RADDAT
     D                 DS
     D  §ScnCsrRow             1      4I 0                                                    RADDAT
     D  §ScnCsrCol             5      8I 0                                                    RADDAT
?     *                                                                                       RADDAT
     D §Workstn        DS                                                                     RADDAT
     D  §Open                  9      9A
     D  §ScnStatus            11     15S 0                                                    RADDAT
     D  §ScnNumRows          152    153I 0
     D  §ScnOffset           241    242I 0                                                    RADDAT
     D  §ScnAID              369    369A                                                      RADDAT
     D  §ScnCsrPos           370    371I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     *====================================================*                                  RADDAT
?     *  AID-Byte                                          *                                  RADDAT
?     *====================================================*                                  RADDAT
?     *                                                                                       RADDAT
     D §F1             C                   CONST(X'31')                                       RADDAT
     D §F2             C                   CONST(X'32')                                       RADDAT
     D §F3             C                   CONST(X'33')                                       RADDAT
     D §F4             C                   CONST(X'34')                                       RADDAT
     D §F5             C                   CONST(X'35')                                       RADDAT
     D §F6             C                   CONST(X'36')                                       RADDAT
     D §F7             C                   CONST(X'37')                                       RADDAT
     D §F8             C                   CONST(X'38')                                       RADDAT
     D §F9             C                   CONST(X'39')                                       RADDAT
     D §F10            C                   CONST(X'3A')                                       RADDAT
     D §F11            C                   CONST(X'3B')                                       RADDAT
     D §F12            C                   CONST(X'3C')                                       RADDAT
     D §F13            C                   CONST(X'B1')                                       RADDAT
     D §F14            C                   CONST(X'B2')                                       RADDAT
     D §F15            C                   CONST(X'B3')                                       RADDAT
     D §F16            C                   CONST(X'B4')                                       RADDAT
     D §F17            C                   CONST(X'B5')                                       RADDAT
     D §F18            C                   CONST(X'B6')                                       RADDAT
     D §F19            C                   CONST(X'B7')                                       RADDAT
     D §F20            C                   CONST(X'B8')                                       RADDAT
     D §F21            C                   CONST(X'B9')                                       RADDAT
     D §F22            C                   CONST(X'BA')                                       RADDAT
     D §F23            C                   CONST(X'BB')                                       RADDAT
     D §F24            C                   CONST(X'BC')                                       RADDAT
?     *
     D §Clear          C                   CONST(X'BD')                                       RADDAT
     D §Delete         C                   CONST(X'BD')                                       RADDAT
?     *                                                                                       RADDAT
     D §Enter          C                   CONST(X'F1')                                       RADDAT
?     *          Nicht definiert                   F2                                         RADDAT
     D §Help           C                   CONST(X'F3')                                       RADDAT
     D §PageDown       C                   CONST(X'F4')                                       RADDAT
     D §PageUp         C                   CONST(X'F5')                                       RADDAT
     D §PrintScn       C                   CONST(X'F6')                                       RADDAT
?     *          Nicht definiert                   F7                                         RADDAT
     D §Reset          C                   CONST(X'F8')                                       RADDAT
?     *                                                                                       RADDAT
     D §LightPen       C                   CONST(X'3F')                                       RADDAT
?     *                                                                                       RADDAT
