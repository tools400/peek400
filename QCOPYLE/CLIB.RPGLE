 DEF  /IF NOT DEFINED(CLIB)                                                                   RADDAT
 DEF  /DEFINE CLIB                                                                            RADDAT
?     *                                                                                       RADDAT
?     *  Basic C data types                                                                   RADDAT
      /IF NOT DEFINED(C_DATA_TYPES)                                                           RADDAT
      /DEFINE C_DATA_TYPES                                                                    RADDAT
?     * C Data Types                                                                          RADDAT
     D char_t          S              1A   based(pDummy)                                      RADDAT
     D short_t         S              5I 0 based(pDummy)                                      RADDAT
     D ushort_t        S              5U 0 based(pDummy)                                      RADDAT
     D int_t           S             10I 0 based(pDummy)                                      RADDAT
     D uint_t          S             10U 0 based(pDummy)                                      RADDAT
     D long_t          S             10I 0 based(pDummy)                                      RADDAT
     D ulong_t         S             10U 0 based(pDummy)                                      RADDAT
     D float_t         S              4F   based(pDummy)                                      RADDAT
     D double_t        S              8F   based(pDummy)                                      RADDAT
      /ENDIF                                                                                  RADDAT
?     *                                                                                       RADDAT
?     *  stdin, stdout and stderr                                                             RADDAT
     D stdin           S               *   import('_C_IFS_stdin')                             RADDAT
     D stdout          S               *   import('_C_IFS_stdout')                            RADDAT
     D stderr          S               *   import('_C_IFS_stderr')                            RADDAT
?     *                                                                                       RADDAT
?     *  system -- Execute a Command                                                          RADDAT
?     *     Return value       Meaning                                                        RADDAT
?     *     ----------------   --------------------------------------                         RADDAT
?     *     0                  the command is successful                                      RADDAT
?     *     -1                 for a NULL pointer                                             RADDAT
?     *     1                  the command fails                                              RADDAT
     D system          PR            10I 0 extproc('system')                                  RADDAT
     D  i_clCommand                    *   value options(*string)                             RADDAT
?     *                                                                                       RADDAT
     D EXCP_MSGID      S              7A   import('_EXCP_MSGID')                              RADDAT
?     *                                                                                       RADDAT
?     *  time -- Determine Current Time                                                       RADDAT
?     *     The time() function returns the current calendar time.                            RADDAT
?     *     The return value is also stored in the location that                              RADDAT
?     *     is given by timeptr.                                                              RADDAT
     D time...                                                                                RADDAT
     D                 PR            10i 0 extproc('time')                                    RADDAT
     D  timeptr                        *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  strftime -- Convert to Formatted Time                                                RADDAT
?     *     strftime() returns the number of bytes placed into the                            RADDAT
?     *     array pointed to by 'dest'.                                                       RADDAT
     D strftime...                                                                            RADDAT
     D                 PR            10i 0 extproc('strftime')                                RADDAT
     D  dest                           *   value                                              RADDAT
     D  maxsize                      10i 0 value                                              RADDAT
     D  format                         *   value options(*string)                             RADDAT
     D  timeptr                            const  likeds(tm_t)                                RADDAT
?     *                                                                                       RADDAT
     D tm_t            DS                  qualified  based(pDummy)                           RADDAT
     D  tm_sec                       10I 0                                                    RADDAT
     D  tm_min                       10I 0                                                    RADDAT
     D  tm_hour                      10I 0                                                    RADDAT
     D  tm_mday                      10I 0                                                    RADDAT
     D  tm_mon                       10I 0                                                    RADDAT
     D  tm_year                      10I 0                                                    RADDAT
     D  tm_wday                      10I 0                                                    RADDAT
     D  tm_yday                      10I 0                                                    RADDAT
     D  tm_isdst                     10I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     *  localtime() -- Correct Local Time, returns tm_t*                                     RADDAT
?     *     The localtime() function converts a time value, in                                RADDAT
?     *     seconds, to a structure of type tm.                                               RADDAT
     D localtime...                                                                           RADDAT
     D                 PR              *   extproc('localtime')                               RADDAT
     D  time                         10I 0 const                                              RADDAT
?     *                                                                                       RADDAT
?     *  localtime_r() -- Correct Local Time                                                  RADDAT
?     *     It is the same as localtime() except that it passes                               RADDAT
?     *     in the place to store the returned structure result.                              RADDAT
     D localtime_r...                                                                         RADDAT
     D                 PR              *   extproc('localtime_r')                             RADDAT
     D  time                         10I 0 const                                              RADDAT
     D  tm                                 const  likeds(tm_t)                                RADDAT
?     *                                                                                       RADDAT
?     *  strtok -- Tokenize String                                                            RADDAT
?     *     The first time the strtok() function is called, it returns                        RADDAT
?     *     a pointer to the first token in i_string. In later calls                          RADDAT
?     *     it returns a pointer to the next token. A null pointer is                         RADDAT
?     *     returned when there are no more tokens.                                           RADDAT
     D strtok          PR              *          extproc('strtok')                           RADDAT
     D  i_string                       *   value  options(*string)                            RADDAT
     D  i_delimiters                   *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  atoi -- Convert Character String to Integer                                          RADDAT
?     *     The atoi() function returns an int value of the                                   RADDAT
?     *     interpreted input string.                                                         RADDAT
     D atoi            PR            10I 0        extproc('atoi')                             RADDAT
     D  i_string                       *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  memcpy -- Copy Bytes                                                                 RADDAT
?     *     The behavior is undefined if copying takes place                                  RADDAT
?     *     between objects that overlap.                                                     RADDAT
?     *     The memcpy() function returns a pointer to dest.                                  RADDAT
     D memcpy          PR              *          extproc('memcpy')                           RADDAT
     D  i_pDest                        *   value                                              RADDAT
     D  i_pSrc                         *   value                                              RADDAT
     D  i_count                      10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  memset -- Set Bytes to Value                                                         RADDAT
?     *     The memset() function returns a pointer to dest.                                  RADDAT
     D memset          PR              *          extproc('memset')                           RADDAT
     D  i_pDest                        *   value                                              RADDAT
     D  i_char                       10I 0 value                                              RADDAT
     D  i_count                      10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  memmove -- Copy Bytes                                                                RADDAT
?     *     memmove allows copying between objects that may overlap                           RADDAT
?     *     as if src is first copied into a temporary array.                                 RADDAT
?     *     The memmove() function returns a pointer to dest.                                 RADDAT
     D memmove         PR              *          extproc('memmove')                          RADDAT
     D  pMemDest                       *   value                                              RADDAT
     D  pMemSrc                        *   value                                              RADDAT
     D  memSize                            value like(size_t)                                 RADDAT
?     *                                                                                       RADDAT
?     *  memcmp -- Compare Buffers                                                            RADDAT
?     *     Return value       Meaning                                                        RADDAT
?     *     ----------------   --------------------------------------                         RADDAT
?     *     Less than 0        buf1 less than buf2                                            RADDAT
?     *     0                  buf1 identical to buf2                                         RADDAT
?     *     Greater than 0     buf1 greater than buf2                                         RADDAT
     D memcmp          PR            10I 0        extproc('memcmp')                           RADDAT
     D  pBuf1                          *   value                                              RADDAT
     D  pBuf2                          *   value                                              RADDAT
     D  count                              value like(size_t)                                 RADDAT
?     *                                                                                       RADDAT
?     *  memicmp -- Compare Bytes (ignore case)                                               RADDAT
?     *     Return value       Meaning                                                        RADDAT
?     *     ----------------   --------------------------------------                         RADDAT
?     *     Less than 0        buf1 less than buf2                                            RADDAT
?     *     0                  buf1 identical to buf2                                         RADDAT
?     *     Greater than 0     buf1 greater than buf2                                         RADDAT
     D memicmp         PR            10I 0        extproc('__memicmp')                        RADDAT
     D  pBuf1                          *   value                                              RADDAT
     D  pBuf2                          *   value                                              RADDAT
     D  count                        10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  strcmp() -- Compare Strings                                                          RADDAT
?     *     Return value       Meaning                                                        RADDAT
?     *     ----------------   --------------------------------------                         RADDAT
?     *     Less than 0        string 1 less than string 2                                    RADDAT
?     *     0                  string 1 equivalent to string 2                                RADDAT
?     *     Greater than 0     string 1 greater than string 2                                 RADDAT
     D strcmp...                                                                              RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                            extproc('strcmp')                           RADDAT
     D  string1                        *   value  options(*string)                            RADDAT
     D  string2                        *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  strcasecmp() -- Compare Strings without Case Sensitivity                             RADDAT
?     *     Return value       Meaning                                                        RADDAT
?     *     ----------------   --------------------------------------                         RADDAT
?     *     Less than 0        string 1 less than string 2                                    RADDAT
?     *     0                  string 1 equivalent to string 2                                RADDAT
?     *     Greater than 0     string 1 greater than string 2                                 RADDAT
     D strcasecmp...                                                                          RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                            extproc('strcasecmp')                       RADDAT
     D  string1                        *   value  options(*string)                            RADDAT
     D  string2                        *   value  options(*string)                            RADDAT
      /IF NOT DEFINED(TESTPTR)                                                                RADDAT
      /DEFINE TESTPTR                                                                         RADDAT
?     *                                                                                       RADDAT
?     *  Test Pointer (TESTPTR)                                                               RADDAT
     D testptr         PR            10I 0 extproc('_TESTPTR')                                RADDAT
     D  i_ptr                          *   value                                              RADDAT
     D  i_test_type                  10I 0 value                                              RADDAT
?     *                                                                                       RADDAT
     D cTESTPTR_TYPE_PROCPTR...                                                               RADDAT
     D                 C                   0                                                  RADDAT
     D cTESTPTR_NO_OPTIMIZED_PARAMETER_PASSING...                                             RADDAT
     D                 C                   0                                                  RADDAT
     D cTESTPTR_OPTIMIZED_PARAMETER_PASSING...                                                RADDAT
     D                 C                   1                                                  RADDAT
?     *                                                                                       RADDAT
     D cTESTPTR_TYPE_MEMPTR...                                                                RADDAT
     D                 C                   1                                                  RADDAT
     D cTESTPTR_NON_TERASPACE...                                                              RADDAT
     D                 C                   0                                                  RADDAT
     D cTESTPTR_TERASPACE...                                                                  RADDAT
     D                 C                   1                                                  RADDAT
?     *                                                                                       RADDAT
     D cTESTPTR_ERROR_NOT_EXIST...                                                            RADDAT
     D                 C                   x'2401'                                            RADDAT
     D cTESTPTR_ERROR_INVALID...                                                              RADDAT
     D                 C                   x'2402'                                            RADDAT
     D cTESTPTR_ERROR_OBJECT_DESTROYED...                                                     RADDAT
     D                 C                   x'2202'                                            RADDAT
      /ENDIF                                                                                  RADDAT
?     *                                                                                       RADDAT
?     *  malloc() - Reserve Storage Block                                                     RADDAT
     D TS_malloc...                                                                           RADDAT
     D                 PR              *   extproc('_C_TS_malloc')                            RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  realloc() - Change Reserved Storage Block Size                                       RADDAT
     D TS_realloc...                                                                          RADDAT
     D                 PR              *   extproc('_C_TS_realloc')                           RADDAT
     D  i_pMem                         *   value                                              RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  free() - Release Storage Blocks                                                      RADDAT
     D TS_free...                                                                             RADDAT
     D                 PR                  extproc('_C_TS_free')                              RADDAT
     D  i_pMem                         *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  _C_TS_malloc_info() - Determine amount of teraspace memory used                      RADDAT
     D TS_malloc_info...                                                                      RADDAT
     D                 PR            10I 0 extproc('_C_TS_malloc_info')                       RADDAT
     D  o_c_mallinfo                       const  likeds(C_mallinfo_t)                        RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  _C_TS_malloc_debug() - Determine amount of teraspace memory                          RADDAT
?     *                         used (with optional dumps and verification)                   RADDAT
     D TS_malloc_debug...                                                                     RADDAT
     D                 PR            10I 0 extproc('_C_TS_malloc_debug')                      RADDAT
     D  i_dump_level                 10U 0 value                                              RADDAT
     D  i_vrfy_level                 10U 0 value                                              RADDAT
     D  o_c_mallinfo                       const  likeds(C_mallinfo_t)                        RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     * The following are possible values for the dump_level parameter                        RADDAT
     D C_NO_DUMPS      C                   0                                                  RADDAT
?     *  Dumps the _C_mallinfo_t structure:                                                   RADDAT
     D C_DUMP_TOTALS   C                   1                                                  RADDAT
?     *  Does a hex dump of all allocated chunks of teraspace storage,                        RADDAT
?     *  this is the entire 512K chunk of storage:                                            RADDAT
     D C_DUMP_CHUNKS   C                   2                                                  RADDAT
?     *  Dumps each of the allocated nodes.                                                   RADDAT
?     *  There is a node for each malloc performed with the header                            RADDAT
?     *  associated with that malloc:                                                         RADDAT
     D C_DUMP_NODES    C                   3                                                  RADDAT
?     *  Dumps the cartesian tree used to keep track of the freed nodes:                      RADDAT
     D C_DUMP_TREE     C                   4                                                  RADDAT
     D C_DUMP_ALL      C                   9999                                               RADDAT
?     *                                                                                       RADDAT
?     *  The following are possible values for the verify_level parameter                     RADDAT
     D C_NO_CHECKS     C                   0                                                  RADDAT
     D C_CHECK_TOTALS  C                   1                                                  RADDAT
     D C_CHECK_CHUNKS  C                   2                                                  RADDAT
     D C_CHECK_NODES   C                   3                                                  RADDAT
     D C_CHECK_TREE    C                   4                                                  RADDAT
     D C_CHECK_ALL     C                   9998                                               RADDAT
?     *  Will call abort() if verification fails                                              RADDAT
     D C_CHECK_ALL_AND_ABORT...                                                               RADDAT
     D                 C                   9999                                               RADDAT
?     *                                                                                       RADDAT
?     * The following structure is used to return information                                 RADDAT
?     * from the _C_TS_malloc_info routine.  The fields are:                                  RADDAT
?     *   total_bytes        - bytes allocated from system                                    RADDAT
?     *                        (high water mark)                                              RADDAT
?     *   allocated_bytes    - number of allocated bytes                                      RADDAT
?     *   unallocated_bytes  - number of unallocated bytes                                    RADDAT
?     *   allocated_blocks   - number of allocated blocks                                     RADDAT
?     *   unallocated_blocks - number of unallocated blocks                                   RADDAT
?     *   requested_bytes    - bytes actually requested from malloc                           RADDAT
?     *   pad_bytes          - bytes used to pad allocation length                            RADDAT
?     *                        to a multiple of 16                                            RADDAT
?     *   overhead_bytes     - bytes used for malloc overhead                                 RADDAT
     D C_mallinfo_t...                                                                        RADDAT
     D                 DS                  qualified               based(pDummy)              RADDAT
     D  total_bytes...                                                                        RADDAT
     D                               20I 0                                                    RADDAT
     D  allocated_bytes...                                                                    RADDAT
     D                               20I 0                                                    RADDAT
     D  unallocated_bytes...                                                                  RADDAT
     D                               20I 0                                                    RADDAT
     D  allocated_blocks...                                                                   RADDAT
     D                               20I 0                                                    RADDAT
     D  unallocated_blocks...                                                                 RADDAT
     D                               20I 0                                                    RADDAT
     D  requested_bytes...                                                                    RADDAT
     D                               20I 0                                                    RADDAT
     D  pad_bytes...                                                                          RADDAT
     D                               20I 0                                                    RADDAT
     D  overhead_bytes...                                                                     RADDAT
     D                               20I 0                                                    RADDAT
?     *                                                                                       RADDAT
?     *  malloc -- Reserve Storage Block                                                      RADDAT
     D malloc          PR              *          extproc('malloc')                           RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  realloc -- Change Reserved Storage Block Size                                        RADDAT
     D realloc         PR              *          extproc('realloc')                          RADDAT
     D  i_pMem                         *   value                                              RADDAT
     D  i_size                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  free -- Release Storage Blocks                                                       RADDAT
     D free            PR                         extproc('free')
     D  i_pMem                         *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  srand -- Set Seed for rand Function   e.g.:   srand(getSeed(*null))                  RADDAT
     D srand           PR                         extproc('srand')                            RADDAT
     D  i_seed                       10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  rand -- Generate Random Number                x = rand()                             RADDAT
     D rand            PR            10I 0        extproc('rand')                             RADDAT
?     *                                                                                       RADDAT
     D RAND_MAX        C                   const(32767)                                       RADDAT
?     *                                                                                       RADDAT
?     *  getSeed -- Get Seed for srand function                                               RADDAT
     D getSeed         PR            10I 0        extproc('time')                             RADDAT
     D  i_timePtr                      *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  strlen -- Determine String Length                                                    RADDAT
     D strlen...                                                                              RADDAT
     D                 PR            10U 0 extproc('strlen')                                  RADDAT
     D  i_string                       *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  tmpnam -- Produce Temporary File Name                                                RADDAT
     D tmpnam          PR              *          extproc('tmpnam')                           RADDAT
     D  pTmpNme                        *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  _C_IFS_tmpnam -- Produce Temporary File Name for the IFS file system                 RADDAT
     D ifs_tmpnam      PR              *          extproc('_C_IFS_tmpnam')                    RADDAT
     D  fileName                       *   value                                              RADDAT
?     *                                                                                       RADDAT
     D L_tmpnam        C                   const(39)                            ! <stdio.h>   RADDAT
?     *                                                                                       RADDAT
     D TMP_MAX         C                   const(32767)                         ! <stdio.h>   RADDAT
?     *                                                                                       RADDAT
?     *  qsort -- Sort Array                                                                  RADDAT
     D qsort           PR              *                       extproc('qsort')               RADDAT
     D  memPtr                         *   value                                              RADDAT
     D  numElem                            value  like(size_t)                                RADDAT
     D  width                              value  like(size_t)                                RADDAT
     D  pSortFunc                      *   value  procptr                                     RADDAT
?     *                                                                                       RADDAT
?     *  bsearch -- Search Arrays                                                             RADDAT
     D bsearch         PR              *          extproc('bsearch')                          RADDAT
     D  keyPtr                         *   value                                              RADDAT
     D  memPtr                         *   value                                              RADDAT
     D  numElem                            value  like(size_t)                                RADDAT
     D  width                              value  like(size_t)                                RADDAT
     D  pSearchFnc                     *   value  procptr                                     RADDAT
?     *                                                                                       RADDAT
?     *  iconv_open()--Code Conversion Allocation API                                         RADDAT
     D iconv_open...                                                                          RADDAT
     D                 PR                  extproc('iconv_open')                              RADDAT
     D                                     like(iconv_t   )                                   RADDAT
     D  i_toCode                       *   value                                              RADDAT
     D  i_fromCode                     *   value                                              RADDAT
?     *                                                                                       RADDAT
     D iconv_t         DS                  qualified   based(pDummy)   align                  RADDAT
     D  return_value                 10I 0                                                    RADDAT
     D  cd                           10I 0 dim(12)                                            RADDAT
?     *                                                                                       RADDAT
     D iconv_fromcode_t...                                                                    RADDAT
     D                 DS                  qualified   based(pDummy)                          RADDAT
     D  ibmccsid                      8A                                                      RADDAT
     D  ccsid                         5A                                                      RADDAT
     D  convAlt                       3A                                                      RADDAT
     D  substAlt                      1A                                                      RADDAT
     D  shiftStateAlt                 1A                                                      RADDAT
     D  inpLengthOpt                  1A                                                      RADDAT
     D  errOption                     1A                                                      RADDAT
     D  reserved                     12A                                                      RADDAT
?     *                                                                                       RADDAT
     D iconv_tocode_t...                                                                      RADDAT
     D                 DS                  qualified   based(pDummy)                          RADDAT
     D  ibmccsid                      8A                                                      RADDAT
     D  ccsid                         5A                                                      RADDAT
     D  reserved                     19A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  QtqIconvOpen()--Code Conversion Allocation API                                       RADDAT
     D QtqIconv_open...                                                                       RADDAT
     D                 PR                  extproc('QtqIconvOpen')                            RADDAT
     D                                     likeds(iconv_t )                                   RADDAT
     D  i_toCode                           const  likeds(QtqCode_t)                           RADDAT
     D  i_fromCode                         const  likeds(QtqCode_t)                           RADDAT
?     *                                                                                       RADDAT
     D QtqCode_t...                                                                           RADDAT
     D                 DS                  qualified   based(pDummy)                          RADDAT
     D  ccsid                        10I 0                                                    RADDAT
     D  conversionA                  10I 0                                                    RADDAT
     D  substitutionA                10I 0                                                    RADDAT
     D  shiftStateA                  10I 0                                                    RADDAT
     D  inpLenOpt                    10I 0                                                    RADDAT
     D  errOptMxdDta                 10I 0                                                    RADDAT
     D  reserved                     12A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  iconv()--Code Conversion API                                                         RADDAT
     D iconv...                                                                               RADDAT
     D                 PR            10U 0        extproc('iconv')                            RADDAT
     D  i_cd                               value likeds(iconv_t  )                            RADDAT
     D  i_pInBuf                       *                                                      RADDAT
     D  i_inBytLeft                  10U 0                                                    RADDAT
     D  i_pOutBuf                      *                                                      RADDAT
     D  i_outBytLeft                 10U 0                                                    RADDAT
?     *                                                                                       RADDAT
     D cICONV_ERROR    C                   const(4294967295)                                  RADDAT
?     *                                                                                       RADDAT
?     *  iconv_close()--Code Conversion Deallocation API                                      RADDAT
     D iconv_close...                                                                         RADDAT
     D                 PR            10I 0        extproc('iconv_close')                      RADDAT
     D  i_cd                               value likeds(iconv_t  )                            RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = stat()--Get File Information                include <sys/stat.h>              RADDAT
     D stat...                                                                                RADDAT
     D                 PR            10I 0        extproc('stat')               = int         RADDAT
     D  i_pPath                        *   value options(*string)               = *path       RADDAT
     D  i_pStat                        *   value                                = *buf        RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = fstat()--Get File Information by Descriptor include <sys/stat.h>              RADDAT
     D fstat...                                                                               RADDAT
     D                 PR            10I 0        extproc('fstat')              = int         RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
     D  i_stat                             const likeds(st_stat_t)              = *buf        RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = lstat()--Get File or Link Information       include <sys/stat.h>              RADDAT
     D lstat...                                                                               RADDAT
     D                 PR            10I 0        extproc('lstat')              = int         RADDAT
     D  i_pPath                        *   value options(*string)               = *path       RADDAT
     D  i_pStat                        *   value                                = *buf        RADDAT
?     *                                                                                       RADDAT
     D st_stat_t       DS                  qualified   based(pDummy)   align                  RADDAT
     D  mode                         10U 0                                      mode_t =uint  RADDAT
     D  ino                          10U 0                                      ino_t  =uint  RADDAT
     D  nlink                         5U 0                                      nlink_t=ushortRADDAT
     D  reserved2                     2A                                                      RADDAT
     D  uid                          10U 0                                      uid_t  =uint  RADDAT
     D  gid                          10U 0                                      gid_t  =uint  RADDAT
     D  size                         10I 0                                      off_t  =int   RADDAT
     D  atime                        10I 0                                      time_t =long  RADDAT
     D  mtime                        10I 0                                      time_t =long  RADDAT
     D  ctime                        10I 0                                      time_t =long  RADDAT
     D  dev                          10U 0                                      dev_t  =uint  RADDAT
     D  blksize                      10U 0                                      size_t =uint  RADDAT
     D  allocsize                    10U 0                                      ulong         RADDAT
     D  objtype                      11A                                        qp0l_objtype_tRADDAT
     D  reserved3                     1A                                                      RADDAT
     D  codepage                      5U 0                                      ushort        RADDAT
     D  ccsid                         5U 0                                      ushort        RADDAT
     D  rdev                         10U 0                                      dev_t  =uint  RADDAT
     D  nlink32                      10U 0                                      nlink32_t=ulngRADDAT
     D  rdev64                       20U 0                                      dev64_t=ullng RADDAT
     D  dev64                        20U 0                                      dev64_t=ullng RADDAT
     D  reserved1                    36A                                                      RADDAT
     D  ino_gen_id                   10U 0                                      uint          RADDAT
?     *                                                                                       RADDAT
?     *  Qp0lGetAttr()--Get Attributes                                                        RADDAT
     D Qp0lGetAttr...                                                                         RADDAT
     D                 PR            10I 0 extproc('Qp0lGetAttr')                             RADDAT
     D  i_path                             const  likeds(Qlg_Path_Name_t)                     RADDAT
     D  i_attrArray                        const  like(Qlg_attrArray_t  )                     RADDAT
     D  i_pBuffer                      *   value                                              RADDAT
     D  i_bytPrv                     10U 0 value                                              RADDAT
     D  o_sizeNeeded                 10U 0                                                    RADDAT
     D  o_bytRet                     10U 0                                                    RADDAT
     D  i_followLnk                  10U 0 value                                              RADDAT
?     *                                                                                       RADDAT
     D Qlg_Path_Name_t...                                                                     RADDAT
     D                 DS                  qualified align         based(pDummy)              RADDAT
     D   CCSID                       10I 0                                                    RADDAT
     D   Country_ID                   2A                                                      RADDAT
     D   Language_ID                  3A                                                      RADDAT
     D   Reserved                     3A                                                      RADDAT
     D   Path_Type                   10U 0                                                    RADDAT
     D   Path_Length                 10I 0                                                    RADDAT
     D   Path_Name_Delimiter...                                                               RADDAT
     D                                2A                                                      RADDAT
     D   Reserved2                   10A                                                      RADDAT
     D   Path_Name                  256A                                                      RADDAT
?     *                                                                                       RADDAT
     D QLG_PATH_JOB_CCSID...                                                                  RADDAT
     D                 C                   const(0)                                           RADDAT
     D QLG_PATH_JOB_COUNTRYID...                                                              RADDAT
     D                 C                   const(X'0000')                                     RADDAT
     D QLG_PATH_JOB_LANGUAGEID...                                                             RADDAT
     D                 C                   const(X'000000')                                   RADDAT
?     *                                                                                       RADDAT
?     *  The Path_Name is a character string and the delimiter is one byte long.              RADDAT
     D QLG_CHAR_SINGLE...                                                                     RADDAT
     D                 C                   const(0)                                           RADDAT
?     *                                                                                       RADDAT
?     *  The Path_Name is a pointer and the delimiter is one byte long.                       RADDAT
     D QLG_PTR_SINGLE...                                                                      RADDAT
     D                 C                   const(1)                                           RADDAT
?     *                                                                                       RADDAT
?     *  The Path_Name is a character string and the delimiter is two bytes long.             RADDAT
     D QLG_CHAR_DOUBLE...                                                                     RADDAT
     D                 C                   const(2)                                           RADDAT
?     *                                                                                       RADDAT
?     *  The Path_Name is a pointer and the delimiter is two bytes long.                      RADDAT
     D QLG_PTR_DOUBLE...                                                                      RADDAT
     D                 C                   const(3)                                           RADDAT
?     *                                                                                       RADDAT
     D Qlg_attrArray_t...                                                                     RADDAT
     D                 DS                  qualified               based(pDummy)              RADDAT
     D  numE                         10I 0                                                    RADDAT
     D  attr                         10I 0 dim(64)                                            RADDAT
?     *                                                                                       RADDAT
     D Qlg_rtnAttr_t...                                                                       RADDAT
     D                 DS                  qualified               based(pDummy)              RADDAT
     D  ofsNextAttr                  10I 0                                                    RADDAT
     D  ID                           10I 0                                                    RADDAT
     D  size                         10I 0                                                    RADDAT
     D  reserved                      4A                                                      RADDAT
?     *                                                                                       RADDAT
     D QP0L_ATTR_OBJTYPE...                                                                   RADDAT
     D                 C                   const(0)                             CHAR(10)      RADDAT
     D QP0L_ATTR_DATA_SIZE...                                                                 RADDAT
     D                 C                   const(1)                             UINT(4)       RADDAT
     D QP0L_ATTR_ALLOC_SIZE...                                                                RADDAT
     D                 C                   const(2)                             UINT(4)       RADDAT
     D QP0L_ATTR_EXTENDED_ATTR_SIZE...                                                        RADDAT
     D                 C                   const(3)                             UINT(4)       RADDAT
     D QP0L_ATTR_CREATE_TIME...                                                               RADDAT
     D                 C                   const(4)                             UINT(4)       RADDAT
     D QP0L_ATTR_ACCESS_TIME...                                                               RADDAT
     D                 C                   const(5)                             UINT(4)       RADDAT
     D QP0L_ATTR_CHANGE_TIME...                                                               RADDAT
     D                 C                   const(6)                             UINT(4)       RADDAT
     D QP0L_ATTR_MODIFY_TIME...                                                               RADDAT
     D                 C                   const(7)                             UINT(4)       RADDAT
     D QP0L_ATTR_STG_FREE...                                                                  RADDAT
     D                 C                   const(8)                             CHAR(1)       RADDAT
     D QP0L_ATTR_CHECKED_OUT...                                                               RADDAT
     D                 C                   const(9)                             chkOut Fmt    RADDAT
     D QP0L_ATTR_LOCAL_REMOTE...                                                              RADDAT
     D                 C                   const(10)                            CHAR(1)       RADDAT
?     *                                                                                       RADDAT
     D QP0L_DONOT_FOLLOW_SYMLNK...                                                            RADDAT
     D                 C                   const(x'00')                                       RADDAT
     D QP0L_FOLLOW_SYMLNK...                                                                  RADDAT
     D                 C                   const(x'01')                                       RADDAT
?     *                                                                                       RADDAT
     D QP0L_NOT_CHECKED_OUT...                                                                RADDAT
     D                 C                   const(x'00')                                       RADDAT
     D QP0L_CHECKED_OUT...                                                                    RADDAT
     D                 C                   const(x'01')                                       RADDAT
?     *                                                                                       RADDAT
     D QP0L_LOCAL_OBJ...                                                                      RADDAT
     D                 C                   const(x'01')                                       RADDAT
     D QP0L_REMOTE_OBJ...                                                                     RADDAT
     D                 C                   const(x'02')                                       RADDAT
?     *                                                                                       RADDAT
?     *  QlgGetcwd()--Get Current Directory (using NLS-enabled path name)                     RADDAT
?     *  Returns: Qlg_Path_Name_T                                                             RADDAT
     D QlgGetcwd...                                                                           RADDAT
     D                 PR              *   extproc('QlgGetcwd')                               RADDAT
     D  o_path                             const  likeds(Qlg_Path_Name_t)                     RADDAT
     D  i_size                             value  like(size_t)                                RADDAT
?     *                                                                                       RADDAT
?     *  getcwd()--Get Current Directory
     D getcwd...
     D                 PR              *   extproc('getcwd')
     D  o_path                    65535A   const  options(*varsize)                           RADDAT
     D  i_size                             value  like(size_t)                                RADDAT
?     *                                                                                       RADDAT
?     *  QlgChdir()--Change Current Directory (using NLS-enabled path name)                   RADDAT
?     *  Returns: Qlg_Path_Name_T                                                             RADDAT
     D QlgChdir...                                                                            RADDAT
     D                 PR            10I 0 extproc('QlgChdir')                                RADDAT
     D  i_path                             const  likeds(Qlg_Path_Name_t)                     RADDAT
?     *                                                                                       RADDAT
?     *  chdir()--Change Current Directory
     D chdir...
     D                 PR            10I 0 extproc('chdir')
     D  i_path                         *   value  options(*string)
?     *                                                                                       RADDAT
?     *  QSYSINC/SYS.TYPES                                                                    RADDAT
     D off_t           S             10I 0 based(pDummy)                                      RADDAT
     D size_t          S             10U 0 based(pDummy)                                      RADDAT
     D ssize_t         S             10I 0 based(pDummy)                                      RADDAT
     D time_t          S             10I 0 based(pDummy)                                      RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = chmod()--Change File Authorizations         include <sys/stat.h>
     D chmod...                                                                               RADDAT
     D                 PR            10I 0        extproc('chmod')              = int         RADDAT
     D  i_pPath                        *   value  options(*string)              = *path       RADDAT
     D  i_mode                       10U 0 value                                = mode_t =uint
?     *                                                                                       RADDAT
?     *  mkdir()--Make Directory                            include <sys/stat.h>              RADDAT
     D mkdir...
     D                 PR            10I 0        extproc('mkdir')              = rc
     D  i_pPath                        *   value options(*string)               = *path
     D  i_mode                       10U 0 value                                = mode_t =uint
?     *                                                                                       RADDAT
?     *  rmdir()--Remove Directory                          include <sys/stat.h>              RADDAT
     D rmdir...
     D                 PR            10I 0        extproc('rmdir')              = rc
     D  i_pPath                        *   value options(*string)               = *path
?     *                                                                                       RADDAT
?     *  opendir()--Open Directory                          include <dirent.h>                RADDAT
     D opendir...                                                                             RADDAT
     D                 PR              *          extproc('opendir')            = *DIR        RADDAT
     D  i_pDirName                     *   value options(*string)               = *dirname    RADDAT
?     *                                                                                       RADDAT
?     *  readdir()--Read Directory Entry                                                      RADDAT
     D readdir...                                                                             RADDAT
     D                 PR              *          extproc('readdir')            = *dirent     RADDAT
     D  i_dirp                         *   value                                = *DIR        RADDAT
?     *                                                                                       RADDAT
     D dirent_t        DS                  qualified  based(pDummy)                           RADDAT
     D   d_reserv1                   16A                                                      RADDAT
     D   d_fileno_gen_id...                                                                   RADDAT
     D                               10U 0                                                    RADDAT
     D   d_fileno                    10U 0                                                    RADDAT
     D   d_reclen                    10U 0                                                    RADDAT
     D   d_reserv3                   10I 0                                                    RADDAT
     D   d_reserv4                    8A                                                      RADDAT
      /if not defined(*V5R2M0)                                                                RADDAT
     D   d_nlsinfo                         like(qlg_nls_t)                                    RADDAT
      /else                                                                                   RADDAT
     D   d_nlsinfo                         likeds(qlg_nls_t)                                  RADDAT
      /endif                                                                                  RADDAT
     D   d_namelen                   10U 0                                                    RADDAT
     D   d_name                     640A                                                      RADDAT
?     *                                                                                       RADDAT
     D qlg_nls_t       DS                  qualified  based(pDummy)    align                  RADDAT
     D  ccsid                        10I 0                                                    RADDAT
     D  country_id                    2A                                                      RADDAT
     D  language_id                   3A                                                      RADDAT
     D  nls_reserved                  3A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  rewinddir()--Reset Directory Stream to Beginning                                     RADDAT
     D rewinddir...                                                                           RADDAT
     D                 PR                  extproc('rewinddir')                               RADDAT
     D  i_dirp                         *   value                                = *DIR        RADDAT
?     *                                                                                       RADDAT
?     *  closedir()--Close Directory                                                          RADDAT
     D closedir...                                                                            RADDAT
     D                 PR            10I 0        extproc('closedir')           = rc          RADDAT
     D  i_dirp                         *   value                                = *DIR        RADDAT
?     *                                                                                       RADDAT
?     *  fd/-1 = open()--Open File                          include <fcntl.h>                 RADDAT
     D open...                                                                                RADDAT
     D                 PR            10I 0        extproc('open')               = int         RADDAT
     D  i_pPath                        *   value  options(*string)              = *path       RADDAT
     D  i_opnFLag                    10I 0 value                                = int         RADDAT
     D  i_mode                       10U 0 value  options(*nopass)              = uint        RADDAT
     D  i_codePage                   10U 0 value  options(*nopass)              = uint        RADDAT
     D  i_crtCodePage                10U 0 value  options(*nopass)              = uint        RADDAT
?     *                                                                                       RADDAT
?     *  <sys/stat.h>                                                                         RADDAT
     D S_IRUSR         C                   const(         256)                  ! Read For OwnRADDAT
     D S_IWUSR         C                   const(         128)                  ! Write For OwRADDAT
     D S_IXUSR         C                   const(          64)                  ! Exc/Srch ForRADDAT
     D S_IRWXU         C                   const(         448)                  ! Rd/Wrt/Exc ORADDAT
?     *                                                                                       RADDAT
     D S_IRGRP         C                   const(          32)                  ! Read For GroRADDAT
     D S_IWGRP         C                   const(          16)                  ! Write For GrRADDAT
     D S_IXGRP         C                   const(           8)                  ! Exc/Srch ForRADDAT
     D S_IRWXG         C                   const(          56)                  ! Rd/Wrt/Exc GRADDAT
?     *                                                                                       RADDAT
     D S_IROTH         C                   const(           4)                  ! Read For OthRADDAT
     D S_IWOTH         C                   const(           2)                  ! Write For OtRADDAT
     D S_IXOTH         C                   const(           1)                  ! Exc/Srch ForRADDAT
     D S_IRWXO         C                   const(           7)                  ! Rd/Wrt/Exc ORADDAT
?     *                                                                                       RADDAT
     D S_ISUID         C                   const(        2048)
     D S_ISGID         C                   const(        1024)
     D S_ISVTX         C                   const(         512)
?     *                                                                                       RADDAT
?     *  <h/fcntl.h>                                                                          RADDAT
     D O_CREAT         C                   const( 8)                            ! Append Mode RADDAT
     D O_EXCL          C                   const(16)                            ! Exclusive UsRADDAT
     D O_TRUNC         C                   const(64)                            ! Truncate FlaRADDAT
?     *                                                                                       RADDAT
     D O_APPEND        C                   const(256)                           ! Append Mode RADDAT
?     *                                                                                       RADDAT
     D O_CODEPAGE      C                   const(  8388608)                     ! Codepage FlaRADDAT
     D O_TEXTDATA      C                   const( 16777216)                     ! Text Data FlRADDAT
     D O_FORCE_SCAN    C                   const( 67108864)                     ! Force scan  RADDAT
     D O_INHERITMODE   C                   const(134217728)                     ! Inherit ModeRADDAT
     D O_CCSID         C                   const(       32)                     ! CCSID       RADDAT
     D O_TEXT_CREAT    C                   const( 33554432)                     !             RADDAT
?     *                                                                                       RADDAT
     D O_SHARE_RDONLY  C                   const( 65536)                        ! Shared Read RADDAT
     D O_SHARE_WRONLY  C                   const(131072)                        ! Shared WriteRADDAT
     D O_SHARE_RDWR    C                   const(262144)                        ! Shared Rd/WrRADDAT
     D O_SHARE_NONE    C                   const(524288)                        ! No Share    RADDAT
?     *                                                                                       RADDAT
     D O_RDONLY        C                   const(1)                             ! Read Only   RADDAT
     D O_WRONLY        C                   const(2)                             ! Write Only  RADDAT
     D O_RDWR          C                   const(4)                             ! Read/Write  RADDAT
?     *                                                                                       RADDAT
?     *  value/-1 = read()--Write from Descriptor           include <unistd.h>                RADDAT
     D read...                                                                                RADDAT
     D                 PR                  extproc('read')   like(ssize_t   )   = ssize_t     RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
     D  i_pBuffer                      *   value                                = *buf        RADDAT
     D  i_buflen                           value like(size_t    )               = size_t      RADDAT
?     *                                                                                       RADDAT
?     *  value/-1 = write()--Write to Descriptor            include <unistd.h>                RADDAT
     D write...                                                                               RADDAT
     D                 PR                  extproc('write')  like(ssize_t   )   = ssize_t     RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
     D  i_pBuffer                      *   value                                = *buf        RADDAT
     D  i_buflen                           value like(size_t    )               = size_t      RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = ftruncate()--Truncate File                  include <unistd.h>                RADDAT
     D ftruncate...                                                                           RADDAT
     D                 PR            10I 0 extproc('ftruncate')                 = int         RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
     D  i_length                           value like(off_t     )               = off_t       RADDAT
?     *                                                                                       RADDAT
?     *  off_t = lseek()--Set File Read/Write Offset        include <unistd.h>                RADDAT
     D lseek...                                                                               RADDAT
     D                 PR                  extproc('lseek')  like(off_t     )   = off_t       RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
     D  i_offset                           value like(off_t     )               = off_t       RADDAT
     D  i_whence                     10I 0 value                                = int         RADDAT
?     *                                                                                       RADDAT
?     *  <h/unistd.h>                                                                         RADDAT
     D SEEK_SET        C                   const(0)                             ! seek start  RADDAT
     D SEEK_CUR        C                   const(1)                             ! seek curPos RADDAT
     D SEEK_END        C                   const(2)                             ! seek end    RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = unlink()--Remove Link to File               include <unistd.h>                RADDAT
     D unlink...                                                                              RADDAT
     D                 PR            10I 0 extproc('unlink')                    = int         RADDAT
     D  i_pPath                        *   value options(*string)               = *path       RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = Qp0lRenameKeep()--Rename File or Directory, Keep "new" If It Exists           RADDAT
     D Qp0lRenameKeep...                                                                      RADDAT
     D                 PR            10I 0 extproc('Qp0lRenameKeep')            = int         RADDAT
     D  i_pOldPath                     *   value options(*string)               = *path       RADDAT
     D  i_pNewPath                     *   value options(*string)               = *path       RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = Qp0lRenameUnlink()--Rename File or Directory, Unlink "new" If It Exists       RADDAT
     D Qp0lRenameUnlink...                                                                    RADDAT
     D                 PR            10I 0 extproc('Qp0lRenameUnlink')          = int         RADDAT
     D  i_pOldPath                     *   value options(*string)               = *path       RADDAT
     D  i_pNewPath                     *   value options(*string)               = *path       RADDAT
?     *                                                                                       RADDAT
?     *  0/-1 = close()--Close File or Socket Descriptor    include <unistd.h>                RADDAT
      /IF NOT DEFINED(c_close_function)                                                       RADDAT
      /DEFINE c_close_function                                                                RADDAT
     D close...                                                                               RADDAT
     D                 PR            10I 0 extproc('close')                     = int         RADDAT
     D  i_fd                         10I 0 value                                = int         RADDAT
      /ENDIF                                                                                  RADDAT
?     *                                                                                       RADDAT
?     *  erno--Set Pointer to Runtime Error Code                                              RADDAT
     D errno           PR              *                     extproc('__errno')               RADDAT
?     *                                                                                       RADDAT
?     *  strerror -- Set Pointer to Runtime Error Message                                     RADDAT
     D strerror        PR              *                     extproc('strerror')              RADDAT
     D  errno                        10I 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  <sys/errno.h>                                                                        RADDAT
     D EDOM_C          C                   const(3001)                          domain error iRADDAT
     D ERANGE_C        C                   const(3002)                          range error inRADDAT
     D ETRUNC_C        C                   const(3003)                          truncation on RADDAT
     D ENOTOPEN_C      C                   const(3004)                          file has not bRADDAT
     D ENOTREAD_C      C                   const(3005)                          file not openeRADDAT
     D ERECIO_C        C                   const(3008)                          file opened foRADDAT
     D ENOTWRITE_C     C                   const(3009)                          file not openeRADDAT
     D ESTDIN_C        C                   const(3010)                          stdin cannot bRADDAT
     D ESTDOUT_C       C                   const(3011)                          stdout cannot RADDAT
     D ESTDERR_C       C                   const(3012)                          stderr cannot RADDAT
     D EBADSEEK_C      C                   const(3013)                          bad offset to RADDAT
     D EBADNAME_C      C                   const(3014)                          invalid file nRADDAT
     D EBADMODE_C      C                   const(3015)                          invalid file mRADDAT
     D EBADPOS_C       C                   const(3017)                          invalid positiRADDAT
     D ENOPOS_C        C                   const(3018)                          no record at sRADDAT
     D ENUMMBRS_C      C                   const(3019)                          no ftell if moRADDAT
     D ENUMRECS_C      C                   const(3020)                          no ftell if toRADDAT
     D EBADFUNC_C      C                   const(3022)                          invalid functiRADDAT
     D ENOREC_C        C                   const(3026)                          record not fouRADDAT
     D EBADDATA_C      C                   const(3028)                          message data iRADDAT
     D EBADOPT_C       C                   const(3040)                          bad option on RADDAT
     D ENOTUPD_C       C                   const(3041)                          file not openeRADDAT
     D ENOTDLT_C       C                   const(3042)                          file not openeRADDAT
     D EPAD_C          C                   const(3043)                          padding occurrRADDAT
     D EBADKEYLN_C     C                   const(3044)                          bad key lengthRADDAT
     D EPUTANDGET_C    C                   const(3080)                          illegal write RADDAT
     D EGETANDPUT_C    C                   const(3081)                          illegal read aRADDAT
     D EIOERROR_C      C                   const(3101)                          I/O exception RADDAT
     D EIORECERR_C     C                   const(3102)                          I/O exception RADDAT
?     *                                                                                       RADDAT
?     *  The following values are defined by POSIX ISO/IEC 9945-1:1990.                       RADDAT
     D EINVAL_C        C                   const(3021)                          invalid argumeRADDAT
     D EIO_C           C                   const(3006)                          input/output eRADDAT
     D ENODEV_C        C                   const(3007)                          no such deviceRADDAT
     D EBUSY_C         C                   const(3029)                          resource busy RADDAT
     D ENOENT_C        C                   const(3025)                          no such file oRADDAT
     D EPERM_C         C                   const(3027)                          operation not RADDAT
?     *                                                                                       RADDAT
?     *  AS/400 specific error numbers                                                        RADDAT
     D EACCES_C        C                   const(3401)                          Permission denRADDAT
     D ENOTDIR_C       C                   const(3403)                          Not a directorRADDAT
     D ENOSPC_C        C                   const(3404)                          No space availRADDAT
     D EXDEV_C         C                   const(3405)                          Improper link.RADDAT
     D EWOULDBLOCK_C   C                   const(3406)                          Operation woulRADDAT
     D EAGAIN_C        C                   const(3406)                          Operation woulRADDAT
     D EINTR_C         C                   const(3407)                          Interrupted fuRADDAT
     D EFAULT_C        C                   const(3408)                          The address usRADDAT
     D ETIME_C         C                   const(3409)                          Operation timeRADDAT
     D ENXIO_C         C                   const(3415)                          No such deviceRADDAT
     D ECLOSED_C       C                   const(3417)                          Socket closed RADDAT
     D EADDRINUSE_C    C                   const(3420)                          Address alreadRADDAT
     D EADDRNOTAVAIL_C...                                                                     RADDAT
     D                 C                   const(3421)                          Address not avRADDAT
     D EAFNOSUPPORT_C  C                   const(3422)                          The type of soRADDAT
     D EALREADY_C      C                   const(3423)                          Operation alreRADDAT
     D ECONNABORTED_C  C                   const(3424)                          Connection endRADDAT
     D ECONNREFUSED_C  C                   const(3425)                          A remote host RADDAT
     D ECONNRESET_C    C                   const(3426)                          A connection wRADDAT
     D EDESTADDRREQ_C  C                   const(3427)                          Operation requRADDAT
     D EHOSTDOWN_C     C                   const(3428)                          A remote host RADDAT
     D EHOSTUNREACH_C  C                   const(3429)                          A route to theRADDAT
     D EINPROGRESS_C   C                   const(3430)                          Operation in pRADDAT
     D EISCONN_C       C                   const(3431)                          A connection hRADDAT
     D EMSGSIZE_C      C                   const(3432)                          Message size oRADDAT
     D ENETDOWN_C      C                   const(3433)                          The network isRADDAT
     D ENETRESET_C     C                   const(3434)                          A socket is coRADDAT
     D ENETUNREACH_C   C                   const(3435)                          Cannot reach tRADDAT
     D ENOBUFS_C       C                   const(3436)                          There is not eRADDAT
     D ENOPROTOOPT_C   C                   const(3437)                          The protocol dRADDAT
     D ENOTCONN_C      C                   const(3438)                          Requested operRADDAT
     D ENOTSOCK_C      C                   const(3439)                          The specified RADDAT
     D ENOTSUP_C       C                   const(3440)                          Operation not RADDAT
     D EOPNOTSUPP_C    C                   const(3440)                          Operation not RADDAT
     D EPFNOSUPPORT_C  C                   const(3441)                          The socket proRADDAT
     D EPROTONOSUPPORT_C...                                                                   RADDAT
     D                 C                   const(3442)                          No protocol ofRADDAT
     D EPROTOTYPE_C    C                   const(3443)                          The socket typRADDAT
     D ERCVDERR_C      C                   const(3444)                          An error indicRADDAT
     D ESHUTDOWN_C     C                   const(3445)                          Cannot send daRADDAT
     D ESOCKTNOSUPPORT_C...                                                                   RADDAT
     D                 C                   const(3446)                          The specified RADDAT
     D ETIMEDOUT_C     C                   const(3447)                          A remote host RADDAT
     D EUNATCH_C       C                   const(3448)                          The protocol rRADDAT
     D EBADF_C         C                   const(3450)                          Descriptor notRADDAT
     D EMFILE_C        C                   const(3452)                          Too many open RADDAT
     D ENFILE_C        C                   const(3453)                          Too many open RADDAT
     D EPIPE_C         C                   const(3455)                          Broken pipe.  RADDAT
     D EEXIST_C        C                   const(3457)                          File exists.  RADDAT
     D EDEADLK_C       C                   const(3459)                          Resource deadlRADDAT
     D ENOMEM_C        C                   const(3460)                          Storage allocaRADDAT
     D EOWNERTERM_C    C                   const(3462)                          The mutex no lRADDAT
     D EDESTROYED_C    C                   const(3463)                          he synchronizaRADDAT
     D ETERM_C         C                   const(3464)                          Operation termRADDAT
     D EMLINK_C        C                   const(3468)                          Maximum link cRADDAT
     D ESPIPE_C        C                   const(3469)                          Seek request nRADDAT
     D ENOSYS_C        C                   const(3470)                          Function not iRADDAT
     D EISDIR_C        C                   const(3471)                          Specified targRADDAT
     D EROFS_C         C                   const(3472)                          Read-only fileRADDAT
     D EUNKNOWN_C      C                   const(3474)                          Unknown systemRADDAT
     D EITERBAD_C      C                   const(3475)                          Iterator is inRADDAT
     D EDAMAGE_C       C                   const(3484)                          A damaged objeRADDAT
     D ELOOP_C         C                   const(3485)                          A loop exists RADDAT
     D ENAMETOOLONG_C  C                   const(3486)                          A path name isRADDAT
     D ENOLCK_C        C                   const(3487)                          No locks availRADDAT
     D ENOTEMPTY_C     C                   const(3488)                          Directory not RADDAT
     D ENOSYSRSC_C     C                   const(3489)                          System resourcRADDAT
     D ECONVERT_C      C                   const(3490)                          Conversion errRADDAT
     D E2BIG_C         C                   const(3491)                          Argument list RADDAT
     D EILSEQ_C        C                   const(3492)                          Conversion stoRADDAT
     D ESOFTDAMAGE_C   C                   const(3497)                          Object has sofRADDAT
     D ENOTENROLL_C    C                   const(3498)                          User not enrolRADDAT
     D EOFFLINE_C      C                   const(3499)                          Object is suspRADDAT
     D EROOBJ_C        C                   const(3500)                          Object is a reRADDAT
     D ELOCKED_C       C                   const(3506)                          Area being reaRADDAT
     D EFBIG_C         C                   const(3507)                          Object too larRADDAT
     D EIDRM_C         C                   const(3509)                          The semaphore,RADDAT
     D ENOMSG_C        C                   const(3510)                          The queue doesRADDAT
     D EFILECVT_C      C                   const(3511)                          File ID converRADDAT
     D EBADFID_C       C                   const(3512)                          A File ID coulRADDAT
     D ESTALE_C        C                   const(3513)                          A File ID coulRADDAT
     D ESRCH_C         C                   const(3515)                          No such procesRADDAT
     D ENOTSIGINIT_C   C                   const(3516)                          Process not enRADDAT
     D ECHILD_C        C                   const(3517)                          No child proceRADDAT
     D EBADH_C         C                   const(3520)                          Handle is not RADDAT
     D ETOOMANYREFS_C  C                   const(3523)                          The operation RADDAT
     D ENOTSAFE_C      C                   const(3524)                          Function not aRADDAT
     D EOVERFLOW_C     C                   const(3525)                          Object is too RADDAT
     D EJRNDAMAGE_C    C                   CONST(3526)                          Journal damageRADDAT
     D EJRNINACTIVE_C  C                   CONST(3527)                          Journal inactiRADDAT
     D EJRNRCVSPC_C    C                   CONST(3528)                          Journal space RADDAT
     D EJRNRMT_C       C                   CONST(3529)                          Journal is remRADDAT
     D ENEWJRNRCV_C    C                   CONST(3530)                          New journal reRADDAT
     D ENEWJRN_C       C                   CONST(3531)                          New journal isRADDAT
     D EJOURNALED_C    C                   CONST(3532)                          Object alreadyRADDAT
     D EJRNENTTOOLONG_C...                                                                    RADDAT
     D                 C                   CONST(3533)                          Entry too largRADDAT
     D EDATALINK_C     C                   CONST(3534)                          Object is a DaRADDAT
     D ENOTAVAIL_C     C                   CONST(3535)                          Independent ASRADDAT
     D ENOTTY_C        C                   CONST(3536)                          Inappropriate RADDAT
     D EFBIG2_C        C                   CONST(3540)                          Write or truncRADDAT
     D ETXTBSY_C       C                   CONST(3543)                          Text file busyRADDAT
     D EASPGRPNOTSET_C...                                                                     RADDAT
     D                 C                   CONST(3544)                          ASP group not RADDAT
     D ERESTART_C      C                   CONST(3545)                          System call caRADDAT
     D ESCANFAILURE_C  C                   CONST(3546)                          Object marked RADDAT
?     *                                                                                       RADDAT
?     *  Unix return codes                                                                    RADDAT
     D RC_OK           C                   const(0)                                           RADDAT
     D RC_ERROR        C                   const(-1)                                          RADDAT
?     *                                                                                       RADDAT
?     *  Convert External Form to Numeric Value (CVTEFN)                                      RADDAT
     D cvtefnd...                                                                             RADDAT
     D                 PR             8F   extproc('cvtefnd')                                 RADDAT
     D  i_source                       *   value                                              RADDAT
     D  i_len                        10U 0 value                                              RADDAT
     D  i_mask                         *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  Test Bit in String (TSTBTS)                                                          RADDAT
     D tstbts...                                                                              RADDAT
     D                 PR            10I 0 extproc('tstbts')                                  RADDAT
     D  bit_string                     *   value                                              RADDAT
     D  bit_offset                   10I 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  getenv()--Get Value of Environment Variable                                          RADDAT
     D getenv...                                                                              RADDAT
     D                 PR              *   extproc('getenv')                                  RADDAT
     D  name                           *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  putenv()--Change or Add Environment Variable                                         RADDAT
     D putenv...                                                                              RADDAT
     D                 PR            10I 0 extproc('putenv')                                  RADDAT
     D  string                         *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  Qp0zDltEnv()--Delete an Environment Variable                                         RADDAT
     D Qp0zDltEnv...                                                                          RADDAT
     D                 PR            10I 0 extproc('Qp0zDltEnv')                              RADDAT
     D  name                           *   value  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *  Qp0zInitEnv()--Initialize Environment for Variables                                  RADDAT
     D Qp0zInitEnv...                                                                         RADDAT
     D                 PR            10I 0 extproc('Qp0zInitEnv')                             RADDAT
?     *                                                                                       RADDAT
     D ENVIRON         S               *   import('environ')                                  RADDAT
?     *                                                                                       RADDAT
?     *  Generate Universal Unique Identifier (GENUUID)                                       RADDAT
     D genUUID...                                                                             RADDAT
     D                 PR                  extproc('_GENUUID')                                RADDAT
     D  uuid_template                  *   value                                              RADDAT
?     *                                                                                       RADDAT
     D uuid_template_t...                                                                     RADDAT
     D                 DS                  qualified  based(pDummy)                           RADDAT
     D  bytPrv                       10U 0                                                    RADDAT
     D  bytAvl                       10U 0                                                    RADDAT
     D  reserved                      8A                                                      RADDAT
     D  uuid                         16A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  Convert Hex to Character (CVTHC)                                                     RADDAT
     D cvthc...                                                                               RADDAT
     D                 PR                  extproc('cvthc')                                   RADDAT
     D  pResult                        *   value                                              RADDAT
     D  pSource                        *   value                                              RADDAT
     D  sourceSize                   10I 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  Convert Eight Bit Character to Hex Nibbles (CVTCH)                                   RADDAT
     D cvtch...                                                                               RADDAT
     D                 PR                  extproc('cvtch')                                   RADDAT
     D  pResult                        *   value                                              RADDAT
     D  pSource                        *   value                                              RADDAT
     D  sourceLen                    10I 0 value                                              RADDAT
?     *                                                                                       RADDAT
?     *  Cipher (CIPHER)                                                                      RADDAT
     D cipher...                                                                              RADDAT
     D                 PR                  extproc('_CIPHER')                                 RADDAT
     D                                 *   const                                              RADDAT
     D                                 *   value                                              RADDAT
     D                                 *   const                                              RADDAT
?     *                                                                                       RADDAT
     D cipherCtrls_t   DS                  qualified  based(pDummy)  align                    RADDAT
     D  function               1      2A                                                      RADDAT
     D  hashAlg                3      3A                                                      RADDAT
     D  sequence               4      4A                                                      RADDAT
     D  dataLength             5      8U 0                                                    RADDAT
     D  output                 9      9A                                                      RADDAT
     D  reserved_1            10     16A                                                      RADDAT
     D  hashContext           17     32*                                                      RADDAT
     D  HMACKey               33     48*                                                      RADDAT
     D  HMACKeyLength         49     52U 0                                                    RADDAT
     D  reserved_2            53     96A                                                      RADDAT
?     *                                                                                       RADDAT
     D cCIPHER_MD5...                                                                         RADDAT
     D                 C                   const(x'00')                                       RADDAT
     D cCIPHER_SHA1...                                                                        RADDAT
     D                 C                   const(x'01')                                       RADDAT
?     *                                                                                       RADDAT
     D cCIPHER_ONLY...                                                                        RADDAT
     D                 C                   const(x'00')                                       RADDAT
     D cCIPHER_FIRST...                                                                       RADDAT
     D                 C                   const(x'01')                                       RADDAT
     D cCIPHER_MIDDLE...                                                                      RADDAT
     D                 C                   const(x'02')                                       RADDAT
     D cCIPHER_FINAL...                                                                       RADDAT
     D                 C                   const(x'03')                                       RADDAT
?     *                                                                                       RADDAT
     D cCIPHER_HASH...                                                                        RADDAT
     D                 C                   const(x'00')                                       RADDAT
     D cCIPHER_HMAC...                                                                        RADDAT
     D                 C                   const(x'01')                                       RADDAT
?     *                                                                                       RADDAT
 DEF  /ENDIF                                                                                  RADDAT
