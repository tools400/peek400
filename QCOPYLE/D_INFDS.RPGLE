      /IF NOT DEFINED(D_INFDS)                                                                RADDAT
      /DEFINE D_INFDS                                                                         RADDAT
?     *                                                                                       RADDAT
     D r§infds         DS                  qualified               based(pDummy)              RADDAT
     D  Open                   9      9A                                                      RADDAT
?   P * Status                11     15S 0                                                    RADDAT
     D  File                  83     92A                                                      RADDAT
     D  Library               93    102A                                                      RADDAT
     D  RcdLen               125    126I 0                                                    RADDAT
     D  Member               129    138A                                                      RADDAT
?     * ommon I/O Feedback Area:             Offest = 241                                     RADDAT
     D  RcdFmt               261    270A                                                      RADDAT
?     * /O Feedback Area for Database Files: Offset = 367                                     RADDAT
?   P * NbrOfKey             387    388I 0                                                    RADDAT
?   P * Res01                389    392A                                                      RADDAT
?   P * KeyLen               393    394I 0                                                    RADDAT
     D  MbrNbr               395    396I 0
     D  RcdNbr               397    400I 0                                                    RADDAT
?     *
      /ENDIF                                                                                  RADDAT
