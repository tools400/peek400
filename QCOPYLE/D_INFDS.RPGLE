      /IF NOT DEFINED(D_INFDS)
      /DEFINE D_INFDS
      *
     D infds_t         DS                  qualified template
     D  Open                   9      9A
      * Status                11     15S 0
     D  File                  83     92A
     D  Library               93    102A
     D  RcdLen               125    126I 0
     D  Member               129    138A
      * ommon I/O Feedback Area:             Offest = 241
     D  RcdFmt               261    270A
      * /O Feedback Area for Database Files: Offset = 367
      * NbrOfKey             387    388I 0
      * Res01                389    392A
      * KeyLen               393    394I 0
     D  MbrNbr               395    396I 0
     D  RcdNbr               397    400I 0
      *
      /ENDIF
