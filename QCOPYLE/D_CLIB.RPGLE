      /IF NOT DEFINED(CLIB)
      /DEFINE CLIB
      *
      *  Basics C data types
     D uLong_t         S             10U 0 template
     D uInt_t          S             10U 0 template
      *
      *  system -- Execute a Command
     D system          PR            10I 0 extproc('system')
     D  i_clCommand                    *   value options(*string)
      *
     D EXCP_MSGID      S              7A   import('_EXCP_MSGID')
      *
      *  time -- Determine Current Time
     D time...
     D                 PR            10i 0 extproc('time')
     D  timeptr                        *   value
      *
      *  strftime -- Convert to Formatted Time
     D strftime...
     D                 PR            10i 0 extproc('strftime')
     D  dest                           *   value
     D  maxsize                      10i 0 value
     D  format                         *   value options(*string)
     D  timeptr                            const  likeds(tm_t)
      *
     D tm_t            DS                  qualified template
     D  tm_sec                       10I 0
     D  tm_min                       10I 0
     D  tm_hour                      10I 0
     D  tm_mday                      10I 0
     D  tm_mon                       10I 0
     D  tm_year                      10I 0
     D  tm_wday                      10I 0
     D  tm_yday                      10I 0
     D  tm_isdst                     10I 0
      *
      *  localtime() -- Correct Local Time, returns tm_t*
     D localtime...
     D                 PR              *   extproc('localtime')
     D  time                         10I 0 const
      *
      *  localtime_r() -- Correct Local Time
     D localtime_r...
     D                 PR              *   extproc('localtime_r')
     D  time                         10I 0 const
     D  tm                                 const  likeds(tm_t)
      *
      *  strtok -- Tokenize String
     D strtok          PR              *          extproc('strtok')
     D  i_string                       *   value  options(*string)
     D  i_token                        *   value  options(*string)
      *
      *  atoi -- Convert Character String to Integer
     D atoi            PR            10I 0        extproc('atoi')
     D  i_string                       *   value  options(*string)
      *
      *  memcpy -- Copy Bytes
     D memcpy          PR              *          extproc('memcpy')
     D  i_pDest                        *   value
     D  i_pSrc                         *   value
     D  i_count                      10U 0 value
      *
      *  memset -- Set Bytes to Value
     D memset          PR              *          extproc('memset')
     D  i_pDest                        *   value
     D  i_char                       10I 0 value
     D  i_count                      10U 0 value
      *
      *  memmove -- Copy Bytes
      *     memmove allows copying between objects that may overlap
      *     as if src is first copied into a temporary array.
     D memmove         PR              *          extproc('memmove')
     D  pMemDest                       *   value
     D  pMemSrc                        *   value
     D  memSize                            value like(size_t)
      *
      *  memcmp -- Compare Buffers
     D memcmp          PR            10I 0        extproc('memcmp')
     D  pBuf1                          *   value
     D  pBuf2                          *   value
     D  count                              value like(size_t)
      *
      *  memicmp -- Compare Bytes (ignore case)
     D memicmp         PR            10I 0        extproc('__memicmp')
     D  pBuf1                          *   value
     D  pBuf2                          *   value
     D  count                        10U 0 value
      *
      *  malloc -- Reserve Storage Block
     D malloc          PR              *          extproc('malloc')
     D  i_size                       10U 0 value
      *
      *  realloc -- Change Reserved Storage Block Size
     D realloc         PR              *          extproc('realloc')
     D  i_pMem                         *   value
     D  i_size                       10U 0 value
      *
      *  free -- Release Storage Blocks
     D free            PR                         extproc('free')
     D  i_pMem                         *   value
      *
      *  srand -- Set Seed for rand Function   e.g.:   srand(getSeed(*null))
     D srand           PR                         extproc('srand')
     D  i_seed                       10U 0 value
      *
      *  rand -- Generate Random Number                x = rand()
     D rand            PR            10I 0        extproc('rand')
      *
     D RAND_MAX        C                   const(32767)
      *
      *  getSeed -- Get Seed for srand function
     D getSeed         PR            10I 0        extproc('time')
     D  i_timePtr                      *   value
      *
      *  strlen -- Determine String Length
     D strlen...
     D                 PR            10U 0 extproc('strlen')
     D  i_string                       *   value
      *
      *  tmpnam -- Produce Temporary File Name
     D tmpnam          PR              *          extproc('tmpnam')
     D  pTmpNme                        *   value
      *
     D L_tmpnam        C                   const(39)                            ! <stdio.h>
      *
     D TMP_MAX         C                   const(32767)                         ! <stdio.h>
      *
      *  qsort -- Sort Array
     D qsort           PR              *                       extproc('qsort')
     D  memPtr                         *   value
     D  numElem                            value  like(size_t)
     D  width                              value  like(size_t)
     D  pSortFunc                      *   value  procptr
      *
      *  bsearch -- Search Arrays
     D bsearch         PR              *          extproc('bsearch')
     D  keyPtr                         *   value
     D  memPtr                         *   value
     D  numElem                            value  like(size_t)
     D  width                              value  like(size_t)
     D  pSearchFnc                     *   value  procptr
      *
      *  iconv_open()--Code Conversion Allocation API
     D iconv_open...
     D                 PR                  extproc('iconv_open')
     D                                     like(iconv_t   )
     D  i_toCode                       *   value
     D  i_fromCode                     *   value
      *
     D iconv_t         DS                  qualified align template
     D  return_value                 10I 0
     D  cd                           10I 0 dim(12)
      *
     D iconv_fromcode_t...
     D                 DS                  qualified template
     D  ibmccsid                      8A
     D  ccsid                         5A
     D  convAlt                       3A
     D  substAlt                      1A
     D  shiftStateAlt                 1A
     D  inpLengthOpt                  1A
     D  errOption                     1A
     D  reserved                     12A
      *
     D iconv_tocode_t...
     D                 DS                  qualified template
     D  ibmccsid                      8A
     D  ccsid                         5A
     D  reserved                     19A
      *
      *  QtqIconvOpen()--Code Conversion Allocation API
     D QtqIconv_open...
     D                 PR                  extproc('QtqIconvOpen')
     D                                     likeds(iconv_t)
     D  i_toCode                           const  likeds(QtqCode_t)
     D  i_fromCode                         const  likeds(QtqCode_t)
      *
     D QtqCode_t...
     D                 DS                  qualified template
     D  ccsid                        10I 0
     D  conversionA                  10I 0
     D  substitutionA                10I 0
     D  shiftStateA                  10I 0
     D  inpLenOpt                    10I 0
     D  errOptMxdDta                 10I 0
     D  reserved                     12A
      *
      *  iconv()--Code Conversion API
     D iconv...
     D                 PR            10U 0        extproc('iconv')
     D  i_cd                               value likeds(iconv_t  )
     D  i_pInBuf                       *
     D  i_inBytLeft                  10U 0
     D  i_pOutBuf                      *
     D  i_outBytLeft                 10U 0
      *
     D cICONV_ERROR    C                   const(4294967295)
      *
      *  iconv_close()--Code Conversion Deallocation API
     D iconv_close...
     D                 PR            10I 0        extproc('iconv_close')
     D  i_cd                               value likeds(iconv_t  )
      *
      *  0/-1 = stat()--Get File Information                include <sys/stat.h>
     D stat...
     D                 PR            10I 0        extproc('stat')               = int
     D  i_pPath                        *   value options(*string)               = *path
     D  i_pStat                        *   value                                = *buf
      *
     D st_stat_t       DS                  qualified align template
     D  mode                         10U 0                                      mode_t =uint
     D  ino                          10U 0                                      ino_t  =uint
     D  nlink                         5U 0                                      nlink_t=ushort
     D  reserved2                     2A
     D  uid                          10U 0                                      uid_t  =uint
     D  gid                          10U 0                                      gid_t  =uint
     D  size                         10I 0                                      off_t  =int
     D  atime                        10I 0                                      time_t =long
     D  mtime                        10I 0                                      time_t =long
     D  ctime                        10I 0                                      time_t =long
     D  dev                          10U 0                                      dev_t  =uint
     D  blksize                      10U 0                                      size_t =uint
     D  allocsize                    10U 0                                      ulong
     D  objtype                      11A                                        qp0l_objtype_t
     D  reserved3                     1A
     D  codepage                      5U 0                                      ushort
     D  ccsid                         5U 0                                      ushort
     D  rdev                         10U 0                                      dev_t  =uint
     D  nlink32                      10U 0                                      nlink32_t=ulng
     D  rdev64                       20U 0                                      dev64_t=ullng
     D  dev64                        20U 0                                      dev64_t=ullng
     D  reserved1                    36A
     D  ino_gen_id                   10U 0                                      uint
      *
      *  Qp0lGetAttr()--Get Attributes
     D Qp0lGetAttr...
     D                 PR            10I 0 extproc('Qp0lGetAttr')
     D  i_path                             const  likeds(Qlg_Path_Name_t)
     D  i_attrArray                        const  like(Qlg_attrArray_t  )
     D  i_pBuffer                      *   value
     D  i_bytPrv                     10U 0 value
     D  o_sizeNeeded                 10U 0
     D  o_bytRet                     10U 0
     D  i_followLnk                  10U 0 const
      *
     D Qlg_Path_Name_t...
     D                 DS                  qualified align template
     D   CCSID                       10I 0
     D   Country_ID                   2A
     D   Language_ID                  3A
     D   Reserved                     3A
     D   Path_Type                   10U 0
     D   Path_Length                 10I 0
     D   Path_Name_Delimiter...
     D                                2A
     D   Reserved2                   10A
     D   Path_Name                  256A
      *
     D QLG_PATH_JOB_CCSID...
     D                 C                   const(0)
     D QLG_PATH_JOB_COUNTRYID...
     D                 C                   const(X'0000')
     D QLG_PATH_JOB_LANGUAGEID...
     D                 C                   const(X'000000')
      *
     D Qlg_attrArray_t...
     D                 DS                  qualified template
     D  numE                         10I 0
     D  attr                         10I 0 dim(64)
      *
     D Qlg_rtnAttr_t...
     D                 DS                  qualified template
     D  ofsNextAttr                  10I 0
     D  ID                           10I 0
     D  size                         10I 0
     D  reserved                      4A
      *
     D QP0L_ATTR_OBJTYPE...
     D                 C                   const(0)                             CHAR(10)
     D QP0L_ATTR_DATA_SIZE...
     D                 C                   const(1)                             UINT(4)
     D QP0L_ATTR_ALLOC_SIZE...
     D                 C                   const(2)                             UINT(4)
     D QP0L_ATTR_EXTENDED_ATTR_SIZE...
     D                 C                   const(3)                             UINT(4)
     D QP0L_ATTR_CREATE_TIME...
     D                 C                   const(4)                             UINT(4)
     D QP0L_ATTR_ACCESS_TIME...
     D                 C                   const(5)                             UINT(4)
     D QP0L_ATTR_CHANGE_TIME...
     D                 C                   const(6)                             UINT(4)
     D QP0L_ATTR_MODIFY_TIME...
     D                 C                   const(7)                             UINT(4)
     D QP0L_ATTR_STG_FREE...
     D                 C                   const(8)                             CHAR(1)
     D QP0L_ATTR_CHECKED_OUT...
     D                 C                   const(9)                             chkOut Fmt
     D QP0L_ATTR_LOCAL_REMOTE...
     D                 C                   const(10)                            CHAR(1)
      *
     D QP0L_DONOT_FOLLOW_SYMLNK...
     D                 C                   const(x'00')
     D QP0L_FOLLOW_SYMLNK...
     D                 C                   const(x'01')
      *
     D QP0L_NOT_CHECKED_OUT...
     D                 C                   const(x'00')
     D QP0L_CHECKED_OUT...
     D                 C                   const(x'01')
      *
     D QP0L_LOCAL_OBJ...
     D                 C                   const(x'01')
     D QP0L_REMOTE_OBJ...
     D                 C                   const(x'02')
      *
      *  QSYSINC/SYS.TYPES
     D off_t           S             10I 0 template
     D size_t          S             10U 0 template
     D ssize_t         S             10I 0 template
     D time_t          S             10I 0 template
      *
      *  opendir()--Open Directory                          include <dirent.h>
     D opendir...
     D                 PR              *          extproc('opendir')            = *DIR
     D  i_pDirName                     *   value options(*string)               = *dirname
      *
      *  readdir()--Read Directory Entry
     D readdir...
     D                 PR              *          extproc('readdir')            = *dirent
     D  i_dirp                         *   value                                = *DIR
      *
     D dirent_t        DS                  qualified  template
     D   d_reserv1                   16A
     D   d_fileno_gen_id...
     D                               10U 0
     D   d_fileno                    10U 0
     D   d_reclen                    10U 0
     D   d_reserv3                   10I 0
     D   d_reserv4                    8A
      /if not defined(*V5R2M0)
     D   d_nlsinfo                         like(qlg_nls_t)
      /else
     D   d_nlsinfo                         likeds(qlg_nls_t)
      /endif
     D   d_namelen                   10U 0
     D   d_name                     640A
      *
     D qlg_nls_t       DS                  qualified align template
     D  ccsid                        10I 0
     D  country_id                    2A
     D  language_id                   3A
     D  nls_reserved                  3A
      *
      *  rewinddir()--Reset Directory Stream to Beginning
     D rewinddir...
     D                 PR                  extproc('rewinddir')
     D  i_dirp                         *   value                                = *DIR
      *
      *  closedir()--Close Directory
     D closedir...
     D                 PR            10I 0        extproc('closedir')           = rc
     D  i_dirp                         *   value                                = *DIR
      *
      *  fd/-1 = open()--Open File                          include <fcntl.h>
     D open...
     D                 PR            10I 0        extproc('open')               = int
     D  i_pPath                        *   value  options(*string)              = *path
     D  i_opnFLag                    10I 0 value                                = int
     D  i_mode                       10U 0 value                                = uint
     D                                            options(*nopass)
     D  i_codePage                   10U 0 value                                = uint
     D                                            options(*nopass)
      *
      *  <sys/stat.h>
     D S_IRUSR         C                   const(         256)                  ! Read For Own
     D S_IWUSR         C                   const(         128)                  ! Write For Ow
     D S_IXUSR         C                   const(          64)                  ! Exc/Srch For
     D S_IRWXU         C                   const(         448)                  ! Rd/Wrt/Exc O
      *
     D S_IRGRP         C                   const(          32)                  ! Read For Gro
     D S_IWGRP         C                   const(          16)                  ! Write For Gr
     D S_IXGRP         C                   const(           8)                  ! Exc/Srch For
     D S_IRWXG         C                   const(          56)                  ! Rd/Wrt/Exc G
      *
     D S_IROTH         C                   const(           4)                  ! Read For Oth
     D S_IWOTH         C                   const(           2)                  ! Write For Ot
     D S_IXOTH         C                   const(           1)                  ! Exc/Srch For
     D S_IRWXO         C                   const(           7)                  ! Rd/Wrt/Exc O
      *
      *  <h/fcntl.h>
     D O_CREAT         C                   const( 8)                            ! Append Mode
     D O_EXCL          C                   const(16)                            ! Exclusive Us
     D O_TRUNC         C                   const(64)                            ! Truncate Fla
      *
     D O_APPEND        C                   const(256)                           ! Append Mode
      *
     D O_CODEPAGE      C                   const(  8388608)                     ! Codepage Fla
     D O_TEXTDATA      C                   const( 16777216)                     ! Text Data Fl
     D O_INHERITMODE   C                   const(134217728)                     ! Inherit Mode
     D O_CCSID         C                   const(       32)                     ! CCSID
      *
     D O_SHARE_RDONLY  C                   const( 65536)                        ! Shared Read
     D O_SHARE_WRONLY  C                   const(131072)                        ! Shared Write
     D O_SHARE_RDWR    C                   const(262144)                        ! Shared Rd/Wr
     D O_SHARE_NONE    C                   const(524288)                        ! No Share
      *
     D O_RDONLY        C                   const(1)                             ! Read Only
     D O_WRONLY        C                   const(2)                             ! Write Only
     D O_RDWR          C                   const(4)                             ! Read/Write
      *
      *  value/-1 = read()--Write from Descriptor           include <unistd.h>
     D read...
     D                 PR                  extproc('read')   like(ssize_t   )   = ssize_t
     D  i_fd                         10I 0 value                                = int
     D  i_pBuffer                      *   value                                = *buf
     D  i_buflen                           value like(size_t    )               = size_t
      *
      *  value/-1 = write()--Write to Descriptor            include <unistd.h>
     D write...
     D                 PR                  extproc('write')  like(ssize_t   )   = ssize_t
     D  i_fd                         10I 0 value                                = int
     D  i_pBuffer                      *   value                                = *buf
     D  i_buflen                           value like(size_t    )               = size_t
      *
      *  0/-1 = ftruncate()--Truncate File                  include <unistd.h>
     D ftruncate...
     D                 PR            10I 0 extproc('ftruncate')                 = int
     D  i_fd                         10I 0 value                                = int
     D  i_length                           value like(off_t     )               = off_t
      *
      *  off_t = lseek()--Set File Read/Write Offset        include <unistd.h>
     D lseek...
     D                 PR                  extproc('lseek')  like(off_t     )   = off_t
     D  i_fd                         10I 0 value                                = int
     D  i_offset                           value like(off_t     )               = off_t
     D  i_whence                     10I 0 value                                = int
      *
      *  <h/unistd.h>
     D SEEK_SET        C                   const(0)                             ! seek start
     D SEEK_CUR        C                   const(1)                             ! seek curPos
     D SEEK_END        C                   const(2)                             ! seek end
      *
      *  0/-1 = unlink()--Remove Link to File               include <unistd.h>
     D unlink...
     D                 PR            10I 0 extproc('unlink')                    = int
     D  i_pPath                        *   value options(*string)               = *path
      *
      *  0/-1 = Qp0lRenameKeep()--Rename File or Directory, Keep "new" If It Exists
     D Qp0lRenameKeep...
     D                 PR            10I 0 extproc('Qp0lRenameKeep')            = int
     D  i_pOldPath                     *   value options(*string)               = *path
     D  i_pNewPath                     *   value options(*string)               = *path
      *
      *  0/-1 = close()--Close File or Socket Descriptor    include <unistd.h>
     D close...
     D                 PR            10I 0 extproc('close')                     = int
     D  i_fd                         10I 0 value                                = int
      *
      *  erno--Set Pointer to Runtime Error Code
     D errno           PR              *                     extproc('__errno')
      *
      *  strerror -- Set Pointer to Runtime Error Message
     D strerror        PR              *                     extproc('strerror')
     D  errno                        10I 0 value
      *
      *  <sys/errno.h>
     D EDOM_C          C                   const(3001)                          domain error i
     D ERANGE_C        C                   const(3002)                          range error in
     D ETRUNC_C        C                   const(3003)                          truncation on
     D ENOTOPEN_C      C                   const(3004)                          file has not b
     D ENOTREAD_C      C                   const(3005)                          file not opene
     D ERECIO_C        C                   const(3008)                          file opened fo
     D ENOTWRITE_C     C                   const(3009)                          file not opene
     D ESTDIN_C        C                   const(3010)                          stdin cannot b
     D ESTDOUT_C       C                   const(3011)                          stdout cannot
     D ESTDERR_C       C                   const(3012)                          stderr cannot
     D EBADSEEK_C      C                   const(3013)                          bad offset to
     D EBADNAME_C      C                   const(3014)                          invalid file n
     D EBADMODE_C      C                   const(3015)                          invalid file m
     D EBADPOS_C       C                   const(3017)                          invalid positi
     D ENOPOS_C        C                   const(3018)                          no record at s
     D ENUMMBRS_C      C                   const(3019)                          no ftell if mo
     D ENUMRECS_C      C                   const(3020)                          no ftell if to
     D EBADFUNC_C      C                   const(3022)                          invalid functi
     D ENOREC_C        C                   const(3026)                          record not fou
     D EBADDATA_C      C                   const(3028)                          message data i
     D EBADOPT_C       C                   const(3040)                          bad option on
     D ENOTUPD_C       C                   const(3041)                          file not opene
     D ENOTDLT_C       C                   const(3042)                          file not opene
     D EPAD_C          C                   const(3043)                          padding occurr
     D EBADKEYLN_C     C                   const(3044)                          bad key length
     D EPUTANDGET_C    C                   const(3080)                          illegal write
     D EGETANDPUT_C    C                   const(3081)                          illegal read a
     D EIOERROR_C      C                   const(3101)                          I/O exception
     D EIORECERR_C     C                   const(3102)                          I/O exception
      *
      *  The following values are defined by POSIX ISO/IEC 9945-1:1990.
     D EINVAL_C        C                   const(3021)                          invalid argume
     D EIO_C           C                   const(3006)                          input/output e
     D ENODEV_C        C                   const(3007)                          no such device
     D EBUSY_C         C                   const(3029)                          resource busy
     D ENOENT_C        C                   const(3025)                          no such file o
     D EPERM_C         C                   const(3027)                          operation not
      *
      *  AS/400 specific error numbers
     D EACCES_C        C                   const(3401)                          Permission den
     D ENOTDIR_C       C                   const(3403)                          Not a director
     D ENOSPC_C        C                   const(3404)                          No space avail
     D EXDEV_C         C                   const(3405)                          Improper link.
     D EWOULDBLOCK_C   C                   const(3406)                          Operation woul
     D EAGAIN_C        C                   const(3406)                          Operation woul
     D EINTR_C         C                   const(3407)                          Interrupted fu
     D EFAULT_C        C                   const(3408)                          The address us
     D ETIME_C         C                   const(3409)                          Operation time
     D ENXIO_C         C                   const(3415)                          No such device
     D ECLOSED_C       C                   const(3417)                          Socket closed
     D EADDRINUSE_C    C                   const(3420)                          Address alread
     D EADDRNOTAVAIL_C...
     D                 C                   const(3421)                          Address not av
     D EAFNOSUPPORT_C  C                   const(3422)                          The type of so
     D EALREADY_C      C                   const(3423)                          Operation alre
     D ECONNABORTED_C  C                   const(3424)                          Connection end
     D ECONNREFUSED_C  C                   const(3425)                          A remote host
     D ECONNRESET_C    C                   const(3426)                          A connection w
     D EDESTADDRREQ_C  C                   const(3427)                          Operation requ
     D EHOSTDOWN_C     C                   const(3428)                          A remote host
     D EHOSTUNREACH_C  C                   const(3429)                          A route to the
     D EINPROGRESS_C   C                   const(3430)                          Operation in p
     D EISCONN_C       C                   const(3431)                          A connection h
     D EMSGSIZE_C      C                   const(3432)                          Message size o
     D ENETDOWN_C      C                   const(3433)                          The network is
     D ENETRESET_C     C                   const(3434)                          A socket is co
     D ENETUNREACH_C   C                   const(3435)                          Cannot reach t
     D ENOBUFS_C       C                   const(3436)                          There is not e
     D ENOPROTOOPT_C   C                   const(3437)                          The protocol d
     D ENOTCONN_C      C                   const(3438)                          Requested oper
     D ENOTSOCK_C      C                   const(3439)                          The specified
     D ENOTSUP_C       C                   const(3440)                          Operation not
     D EOPNOTSUPP_C    C                   const(3440)                          Operation not
     D EPFNOSUPPORT_C  C                   const(3441)                          The socket pro
     D EPROTONOSUPPORT_C...
     D                 C                   const(3442)                          No protocol of
     D EPROTOTYPE_C    C                   const(3443)                          The socket typ
     D ERCVDERR_C      C                   const(3444)                          An error indic
     D ESHUTDOWN_C     C                   const(3445)                          Cannot send da
     D ESOCKTNOSUPPORT_C...
     D                 C                   const(3446)                          The specified
     D ETIMEDOUT_C     C                   const(3447)                          A remote host
     D EUNATCH_C       C                   const(3448)                          The protocol r
     D EBADF_C         C                   const(3450)                          Descriptor not
     D EMFILE_C        C                   const(3452)                          Too many open
     D ENFILE_C        C                   const(3453)                          Too many open
     D EPIPE_C         C                   const(3455)                          Broken pipe.
     D EEXIST_C        C                   const(3457)                          File exists.
     D EDEADLK_C       C                   const(3459)                          Resource deadl
     D ENOMEM_C        C                   const(3460)                          Storage alloca
     D EOWNERTERM_C    C                   const(3462)                          The mutex no l
     D EDESTROYED_C    C                   const(3463)                          he synchroniza
     D ETERM_C         C                   const(3464)                          Operation term
     D EMLINK_C        C                   const(3468)                          Maximum link c
     D ESPIPE_C        C                   const(3469)                          Seek request n
     D ENOSYS_C        C                   const(3470)                          Function not i
     D EISDIR_C        C                   const(3471)                          Specified targ
     D EROFS_C         C                   const(3472)                          Read-only file
     D EUNKNOWN_C      C                   const(3474)                          Unknown system
     D EITERBAD_C      C                   const(3475)                          Iterator is in
     D EDAMAGE_C       C                   const(3484)                          A damaged obje
     D ELOOP_C         C                   const(3485)                          A loop exists
     D ENAMETOOLONG_C  C                   const(3486)                          A path name is
     D ENOLCK_C        C                   const(3487)                          No locks avail
     D ENOTEMPTY_C     C                   const(3488)                          Directory not
     D ENOSYSRSC_C     C                   const(3489)                          System resourc
     D ECONVERT_C      C                   const(3490)                          Conversion err
     D E2BIG_C         C                   const(3491)                          Argument list
     D EILSEQ_C        C                   const(3492)                          Conversion sto
     D ESOFTDAMAGE_C   C                   const(3497)                          Object has sof
     D ENOTENROLL_C    C                   const(3498)                          User not enrol
     D EOFFLINE_C      C                   const(3499)                          Object is susp
     D EROOBJ_C        C                   const(3500)                          Object is a re
     D ELOCKED_C       C                   const(3506)                          Area being rea
     D EFBIG_C         C                   const(3507)                          Object too lar
     D EIDRM_C         C                   const(3509)                          The semaphore,
     D ENOMSG_C        C                   const(3510)                          The queue does
     D EFILECVT_C      C                   const(3511)                          File ID conver
     D EBADFID_C       C                   const(3512)                          A File ID coul
     D ESTALE_C        C                   const(3513)                          A File ID coul
     D ESRCH_C         C                   const(3515)                          No such proces
     D ENOTSIGINIT_C   C                   const(3516)                          Process not en
     D ECHILD_C        C                   const(3517)                          No child proce
     D ETOOMANYREFS_C  C                   const(3523)                          The operation
     D ENOTSAFE_C      C                   const(3524)                          Function not a
     D EOVERFLOW_C     C                   const(3525)                          Object is too
     D EJRNDAMAGE_C    C                   CONST(3526)                          Journal damage
     D EJRNINACTIVE_C  C                   CONST(3527)                          Journal inacti
     D EJRNRCVSPC_C    C                   CONST(3528)                          Journal space
     D EJRNRMT_C       C                   CONST(3529)                          Journal is rem
     D ENEWJRNRCV_C    C                   CONST(3530)                          New journal re
     D ENEWJRN_C       C                   CONST(3531)                          New journal is
     D EJOURNALED_C    C                   CONST(3532)                          Object already
     D EJRNENTTOOLONG_C...
     D                 C                   CONST(3533)                          Entry too larg
     D EDATALINK_C     C                   CONST(3534)                          Object is a Da
     D ENOTAVAIL_C     C                   CONST(3535)                          Independent AS
     D ENOTTY_C        C                   CONST(3536)                          Inappropriate
     D EFBIG2_C        C                   CONST(3540)                          Write or trunc
     D ETXTBSY_C       C                   CONST(3543)                          Text file busy
     D EASPGRPNOTSET_C...
     D                 C                   CONST(3544)                          ASP group not
     D ERESTART_C      C                   CONST(3545)                          System call ca
     D ESCANFAILURE_C  C                   CONST(3546)                          Object marked
      *
      *  Unix return codes
     D RC_OK           C                   const(0)
     D RC_ERROR        C                   const(-1)
      *
      *  Convert External Form to Numeric Value (CVTEFN)
     D cvtefnd...
     D                 PR             8F   extproc('cvtefnd')
     D  i_source                       *   value
     D  i_len                        10U 0 value
     D  i_mask                         *   value
      *
      *  Test Bit in String (TSTBTS)
     D tstbts...
     D                 PR            10I 0 extproc('tstbts')
     D  bit_string                     *   value
     D  bit_offset                   10I 0 value
      *
      *  getenv()--Get Value of Environment Variable
     D getenv...
     D                 PR              *   extproc('getenv')
     D  name                           *   value  options(*string)
      *
      *  putenv()--Change or Add Environment Variable
     D putenv...
     D                 PR            10I 0 extproc('putenv')
     D  string                         *   value  options(*string)
      *
      *  Qp0zDltEnv()--Delete an Environment Variable
     D Qp0zDltEnv...
     D                 PR            10I 0 extproc('Qp0zDltEnv')
     D  name                           *   value  options(*string)
      *
      *  Qp0zInitEnv()--Initialize Environment for Variables
     D Qp0zInitEnv...
     D                 PR            10I 0 extproc('Qp0zInitEnv')
      *
     D ENVIRON         S               *   import('environ')
      *
      *  Generate Universal Unique Identifier (GENUUID)
     D genUUID...
     D                 PR                  extproc('_GENUUID')
     D  uuid_template                  *   value
      *
     D uuid_template_t...
     D                 DS                  qualified  template
     D  bytPrv                       10U 0
     D  bytAvl                       10U 0
     D  reserved                      8A
     D  uuid                         16A
      *
      *  Convert Hex to Character (CVTHC)
     D cvthc...
     D                 PR                  extproc('cvthc')
     D  pResult                        *   value
     D  pSource                        *   value
     D  sourceSize                   10I 0 value
      *
      *  Convert Eight Bit Character to Hex Nibbles (CVTCH)
     D cvtch...
     D                 PR                  extproc('cvtch')
     D  pResult                        *   value
     D  pSource                        *   value
     D  sourceLen                    10I 0 value
      *
      *  Cipher (CIPHER)
     D cipher...
     D                 PR                  extproc('_CIPHER')
     D                                 *   const
     D                                 *   value
     D                                 *   const
      *
     D cipherCtrls_t   DS                  qualified align template
     D  function               1      2A
     D  hashAlg                3      3A
     D  sequence               4      4A
     D  dataLength             5      8U 0
     D  output                 9      9A
     D  reserved_1            10     16A
     D  hashContext           17     32*
     D  HMACKey               33     48*
     D  HMACKeyLength         49     52U 0
     D  reserved_2            53     96A
      *
     D cCIPHER_MD5...
     D                 C                   const(x'00')
     D cCIPHER_SHA1...
     D                 C                   const(x'01')
      *
     D cCIPHER_ONLY...
     D                 C                   const(x'00')
     D cCIPHER_FIRST...
     D                 C                   const(x'01')
     D cCIPHER_MIDDLE...
     D                 C                   const(x'02')
     D cCIPHER_FINAL...
     D                 C                   const(x'03')
      *
     D cCIPHER_HASH...
     D                 C                   const(x'00')
     D cCIPHER_HMAC...
     D                 C                   const(x'01')
      *
      /ENDIF
