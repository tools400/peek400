      /if defined(genHeader_t)
      /eof
      /endif
      /define genHeader_t
      *
     D genHeader_t     DS                  qualified template
     D  sizeHeader            65     68I 0
     D  release_Level         69     72A
     D  format                72     80A
     D  api_used              81     90A
     D  crtDateTime           91    103A
     D  infStatus            104    104A
     D  sizeUsed             105    108I 0
     D  OffsetInp            109    112I 0
     D  sizeInz              113    116I 0
     D  OffsetHdr            117    120I 0
     D  sizeHdr              121    124I 0
     D  OffsetLst            125    128I 0
     D  sizeLst              129    132I 0
     D  NumLstEnt            133    136I 0
     D  EntrySize            137    140I 0
      *
