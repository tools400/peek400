      /IF NOT DEFINED(D_INFDS)
      /DEFINE D_INFDS
      *
     D infds_t         DS                  qualified template
     D  open                   9      9A
      * Status                11     15S 0
     D  file                  83     92A
     D  library               93    102A
     D  rcdLen               125    126I 0
     D  member               129    138A
     D  nbrOfRcd             156    159I 0
      * ommon I/O Feedback Area:             Offest = 241
     D  rcdFmt               261    270A
      * /O Feedback Area for Database Files: Offset = 367
      * NbrOfKey             387    388I 0
      * Res01                389    392A
      * KeyLen               393    394I 0
     D  mbrNbr               395    396I 0
     D  rcdNbr               397    400I 0
      *
      /ENDIF
