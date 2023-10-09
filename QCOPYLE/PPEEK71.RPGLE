      /IF NOT DEFINED(PPEEK71)
      /DEFINE PPEEK71
      *
      *  Transcoder handle.
     D hTranscoder_t   S               *   template
      *
      *  Returns a Transcoder to convert from a
      *  given CCSID to the job CCSID.
     D Transcoder_toJobCcsid...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('PEEK71_+
     D                                     Transcoder_toJobCcsid+
     D                                     ')
     D  i_fromCcsid                  10U 0 const
      *
      *  Returns a Transcoder to convert from a
      *  given CCSID to the CCSID of the file field.
     D Transcoder_toFieldCcsid...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('PEEK71_+
     D                                     Transcoder_toFieldCcsid+
     D                                     ')
     D  i_toCcsid                    10U 0 const
      *
      *  Initializes character translation.
     D Transcoder_new...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('PEEK71_+
     D                                     Transcoder_new+
     D                                     ')
     D  i_toCcsid                    10U 0 const
     D  i_fromCcsid                  10U 0 const
      *
      *  Translate a given buffer using dynamic memory allocation.
     D Transcoder_xlateRaw...
     D                 PR            10I 0 opdesc
     D                                     extproc('PEEK71_+
     D                                     Transcoder_xlateRaw+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_size                       10I 0 const
     D  o_pOutBuf                      *
      *
      *  Translate a given buffer.
     D Transcoder_xlateBuffer...
     D                 PR            10I 0 opdesc
     D                                     extproc('PEEK71_+
     D                                     Transcoder_xlateBuffer+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_pInBuf                       *   value
     D  i_size                       10I 0 const
     D  i_maxSize                    10I 0 const  options(*nopass: *omit)
      *
      *  Translate a given varying string.
     D Transcoder_xlateString...
     D                 PR         32767A   opdesc varying
     D                                     extproc('PEEK71_+
     D                                     Transcoder_xlateString+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
     D  i_string                  32767A   const  varying options(*varsize)
      *
      *  Returns the "from CCSID".
     D Transcoder_getFromCcsid...
     D                 PR            10I 0
     D                                     extproc('PEEK71_+
     D                                     Transcoder_getFromCcsid+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
      *
      *  Returns the "to CCSID".
     D Transcoder_getToCcsid...
     D                 PR            10I 0
     D                                     extproc('PEEK71_+
     D                                     Transcoder_getToCcsid+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
      *
      *  Terminates character translation.
     D Transcoder_delete...
     D                 PR
     D                                     extproc('PEEK71_+
     D                                     Transcoder_delete+
     D                                     ')
     D  io_hTranscoder...
     D                                            like(hTranscoder_t )
      *
      *  Returns a Transcoder NULL-handle.
     D Transcoder_null...
     D                 PR                         like(hTranscoder_t )
     D                                     extproc('PEEK71_+
     D                                     Transcoder_null+
     D                                     ')
      *
      *  Returns cTrue if a given Transcoder handle is NULL.
     D Transcoder_isNull...
     D                 PR              N
     D                                     extproc('PEEK71_+
     D                                     Transcoder_isNull+
     D                                     ')
     D  i_hTranscoder                      const  like(hTranscoder_t )
      *
      /ENDIF
