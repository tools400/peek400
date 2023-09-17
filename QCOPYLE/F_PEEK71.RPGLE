      /IF NOT DEFINED(F_PEEK71)                                                               RADDAT
      /DEFINE F_PEEK71                                                                        RADDAT
      *                                                                                       RADDAT
      *  Transcoder handle.                                                                   RADDAT
     D hTranscoder_t   S               *                           based(pDummy)              RADDAT
      *                                                                                       RADDAT
      *  Returns a Transcoder to convert from a                                               RADDAT
      *  given CCSID to the job CCSID.                                                        RADDAT
     D Transcoder_toJobCcsid...                                                               RADDAT
     D                 PR                         like(hTranscoder_t )                        RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_toJobCcsid+                             RADDAT
     D                                     ')                                                 RADDAT
     D  i_fromCcsid                  10U 0 const                                              RADDAT
      *                                                                                       RADDAT
      *  Returns a Transcoder to convert from a                                               RADDAT
      *  given CCSID to the CCSID of the file field.                                          RADDAT
     D Transcoder_toFieldCcsid...                                                             RADDAT
     D                 PR                         like(hTranscoder_t )                        RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_toFieldCcsid+                           RADDAT
     D                                     ')                                                 RADDAT
     D  i_toCcsid                    10U 0 const                                              RADDAT
      *                                                                                       RADDAT
      *  Initializes character translation.                                                   RADDAT
     D Transcoder_new...                                                                      RADDAT
     D                 PR                         like(hTranscoder_t )                        RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_new+                                    RADDAT
     D                                     ')                                                 RADDAT
     D  i_toCcsid                    10U 0 const                                              RADDAT
     D  i_fromCcsid                  10U 0 const                                              RADDAT
      *                                                                                       RADDAT
      *  Translate a given buffer using dynamic memory allocation.                            RADDAT
     D Transcoder_xlateRaw...                                                                 RADDAT
     D                 PR            10I 0 opdesc                                             RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_xlateRaw+                               RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
     D  i_pInBuf                       *   value                                              RADDAT
     D  i_size                       10I 0 const                                              RADDAT
     D  o_pOutBuf                      *                                                      RADDAT
      *                                                                                       RADDAT
      *  Translate a given buffer.                                                            RADDAT
     D Transcoder_xlateBuffer...                                                              RADDAT
     D                 PR            10I 0 opdesc                                             RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_xlateBuffer+                            RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
     D  i_pInBuf                       *   value                                              RADDAT
     D  i_size                       10I 0 const                                              RADDAT
     D  i_maxSize                    10I 0 const  options(*nopass: *omit)                     RADDAT
      *                                                                                       RADDAT
      *  Translate a given varying string.                                                    RADDAT
     D Transcoder_xlateString...                                                              RADDAT
     D                 PR         32767A   opdesc varying                                     RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_xlateString+                            RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
     D  i_string                  32767A   const  varying options(*varsize)                   RADDAT
      *                                                                                       RADDAT
      *  Returns the "from CCSID".                                                            RADDAT
     D Transcoder_getFromCcsid...                                                             RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_getFromCcsid+                           RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
      *                                                                                       RADDAT
      *  Returns the "to CCSID".                                                              RADDAT
     D Transcoder_getToCcsid...                                                             RARADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_getToCcsid+                             RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
      *                                                                                       RADDAT
      *  Terminates character translation.                                                    RADDAT
     D Transcoder_delete...                                                                   RADDAT
     D                 PR                                                                     RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_delete+                                 RADDAT
     D                                     ')                                                 RADDAT
     D  io_hTranscoder...                                                                     RADDAT
     D                                            like(hTranscoder_t )                        RADDAT
      *                                                                                       RADDAT
      *  Returns a Transcoder NULL-handle.                                                    RADDAT
     D Transcoder_null...                                                                     RADDAT
     D                 PR                         like(hTranscoder_t )                        RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_null+                                   RADDAT
     D                                     ')                                                 RADDAT
      *                                                                                       RADDAT
      *  Returns cTrue if a given Transcoder handle is NULL.                                  RADDAT
     D Transcoder_isNull...                                                                   RADDAT
     D                 PR              N                                                      RADDAT
     D                                     extproc('PEEK71_+                                  RADDAT
     D                                     Transcoder_isNull+                                 RADDAT
     D                                     ')                                                 RADDAT
     D  i_hTranscoder                      const  like(hTranscoder_t )                        RADDAT
      *                                                                                       RADDAT
      /ENDIF                                                                                  RADDAT
