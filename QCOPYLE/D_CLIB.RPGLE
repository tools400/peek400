**FREE
/IF NOT DEFINED(CLIB)
/DEFINE CLIB

//  Basics C data types
dcl-s ulong_t uns(10) template;
dcl-s uint_t  uns(10) template;

//  system -- Execute a Command
dcl-pr system int(10) extproc('system');
  i_clcommand     pointer value options(*string);
end-pr;

dcl-s excp_msgid      char(7) import('_EXCP_MSGID');

//  time -- Determine Current Time
dcl-pr time int(10) extproc('time');
  timeptr         pointer value;
end-pr;

//  strftime -- Convert to Formatted Time
dcl-pr strftime int(10) extproc('strftime');
  dest            pointer value;
  maxsize         int(10) value;
  format          pointer value options(*string);
  timeptr         const  likeds(tm_t);
end-pr;

dcl-ds tm_t qualified template;
  tm_sec          int(10);
  tm_min          int(10);
  tm_hour         int(10);
  tm_mday         int(10);
  tm_mon          int(10);
  tm_year         int(10);
  tm_wday         int(10);
  tm_yday         int(10);
  tm_isdst        int(10);
end-ds;

//  localtime() -- Correct Local Time, returns tm_t*
dcl-pr localtime pointer extproc('localtime');
  time            int(10) const;
end-pr;

//  localtime_r() -- Correct Local Time
dcl-pr localtime_r pointer extproc('localtime_r');
  time            int(10) const;
  tm              const  likeds(tm_t);
end-pr;

//  strtok -- Tokenize String
dcl-pr strtok pointer extproc('strtok');
  i_string        pointer value  options(*string);
  i_token         pointer value  options(*string);
end-pr;

//  atoi -- Convert Character String to Integer
dcl-pr atoi int(10) extproc('atoi');
  i_string        pointer value  options(*string);
end-pr;

//  memcpy -- Copy Bytes
dcl-pr memcpy pointer extproc('memcpy');
  i_pdest         pointer value;
  i_psrc          pointer value;
  i_count         uns(10) value;
end-pr;

//  memset -- Set Bytes to Value
dcl-pr memset pointer extproc('memset');
  i_pdest         pointer value;
  i_char          int(10) value;
  i_count         uns(10) value;
end-pr;

//  memmove -- Copy Bytes
//     memmove allows copying between objects that may overlap
//     as if src is first copied into a temporary array.
dcl-pr memmove pointer extproc('memmove');
  pmemdest        pointer value;
  pmemsrc         pointer value;
  memsize         value like(size_t);
end-pr;

//  memcmp -- Compare Buffers
dcl-pr memcmp int(10) extproc('memcmp');
  pbuf1           pointer value;
  pbuf2           pointer value;
  count           value like(size_t);
end-pr;

//  memicmp -- Compare Bytes (ignore case)
dcl-pr memicmp int(10) extproc('__memicmp');
  pbuf1           pointer value;
  pbuf2           pointer value;
  count           uns(10) value;
end-pr;

//  malloc -- Reserve Storage Block
dcl-pr malloc pointer extproc('malloc');
  i_size          uns(10) value;
end-pr;

//  realloc -- Change Reserved Storage Block Size
dcl-pr realloc pointer extproc('realloc');
  i_pmem          pointer value;
  i_size          uns(10) value;
end-pr;

//  free -- Release Storage Blocks
dcl-pr free extproc('free');
  i_pmem          pointer value;
end-pr;

//  srand -- Set Seed for rand Function   e.g.:   srand(getSeed(*null))
dcl-pr srand extproc('srand');
  i_seed          uns(10) value;
end-pr;

//  rand -- Generate Random Number                x = rand()
dcl-pr rand int(10) extproc('rand');
end-pr;

dcl-c rand_max const(32767);

//  getSeed -- Get Seed for srand function
dcl-pr getseed int(10) extproc('time');
  i_timeptr       pointer value;
end-pr;

//  strlen -- Determine String Length
dcl-pr strlen uns(10) extproc('strlen');
  i_string        pointer value;
end-pr;

//  tmpnam -- Produce Temporary File Name
dcl-pr tmpnam pointer extproc('tmpnam');
  ptmpnme         pointer value;
end-pr;

dcl-c l_tmpnam const(39);                              // ! <stdio.h>

dcl-c tmp_max const(32767);                            // ! <stdio.h>

//  qsort -- Sort Array
dcl-pr qsort pointer extproc('qsort');
  memptr          pointer value;
  numelem         value  like(size_t);
  width           value  like(size_t);
  psortfunc       pointer(*proc) value;
end-pr;

//  bsearch -- Search Arrays
dcl-pr bsearch pointer extproc('bsearch');
  keyptr          pointer value;
  memptr          pointer value;
  numelem         value  like(size_t);
  width           value  like(size_t);
  psearchfnc      pointer(*proc) value;
end-pr;

//  iconv_open()--Code Conversion Allocation API
dcl-pr iconv_open extproc('iconv_open') like(iconv_t);
  i_tocode        pointer value;
  i_fromcode      pointer value;
end-pr;

dcl-ds iconv_t qualified align template;
  return_value    int(10);
  cd              int(10) dim(12);
end-ds;

dcl-ds iconv_fromcode_t qualified template;
  ibmccsid        char(8);
  ccsid           char(5);
  convalt         char(3);
  substalt        char(1);
  shiftstatealt   char(1);
  inplengthopt    char(1);
  erroption       char(1);
  reserved        char(12);
end-ds;

dcl-ds iconv_tocode_t qualified template;
  ibmccsid        char(8);
  ccsid           char(5);
  reserved        char(19);
end-ds;

//  QtqIconvOpen()--Code Conversion Allocation API
dcl-pr qtqiconv_open extproc('QtqIconvOpen') likeds(iconv_t);
  i_tocode        const  likeds(qtqcode_t);
  i_fromcode      const  likeds(qtqcode_t);
end-pr;

dcl-ds qtqcode_t qualified template;
  ccsid           int(10);
  conversiona     int(10);
  substitutiona   int(10);
  shiftstatea     int(10);
  inplenopt       int(10);
  erroptmxddta    int(10);
  reserved        char(12);
end-ds;

//  iconv()--Code Conversion API
dcl-pr iconv uns(10) extproc('iconv');
  i_cd            value likeds(iconv_t);
  i_pinbuf        pointer;
  i_inbytleft     uns(10);
  i_poutbuf       pointer;
  i_outbytleft    uns(10);
end-pr;

dcl-c ciconv_error const(4294967295);

//  iconv_close()--Code Conversion Deallocation API
dcl-pr iconv_close int(10) extproc('iconv_close');
  i_cd            value likeds(iconv_t  );
end-pr;

//  0/-1 = stat()--Get File Information                // include <sys/stat.h>
dcl-pr stat int(10) extproc('stat');
  i_ppath         pointer value options(*string);
  i_pstat         pointer value;
end-pr;

dcl-ds st_stat_t qualified align template;
  mode            uns(10);
  ino             uns(10);
  nlink           uns(5);
  reserved2       char(2);
  uid             uns(10);
  gid             uns(10);
  size            int(10);
  atime           int(10);
  mtime           int(10);
  ctime           int(10);
  dev             uns(10);
  blksize         uns(10);
  allocsize       uns(10);
  objtype         char(11);
  reserved3       char(1);
  codepage        uns(5);
  ccsid           uns(5);
  rdev            uns(10);
  nlink32         uns(10);
  rdev64          uns(20);
  dev64           uns(20);
  reserved1       char(36);
  ino_gen_id      uns(10);
end-ds;

//  Qp0lGetAttr()--Get Attributes
dcl-pr qp0lgetattr int(10) extproc('Qp0lGetAttr');
  i_path          const  likeds(qlg_path_name_t);
  i_attrarray     const  like(qlg_attrarray_t  );
  i_pbuffer       pointer value;
  i_bytprv        uns(10) value;
  o_sizeneeded    uns(10);
  o_bytret        uns(10);
  i_followlnk     uns(10) const;
end-pr;

dcl-ds qlg_path_name_t qualified align template;
  ccsid           int(10);
  country_id      char(2);
  language_id     char(3);
  reserved        char(3);
  path_type       uns(10);
  path_length     int(10);
  path_name_delimiter
  char(2);
  reserved2       char(10);
  path_name       char(256);
end-ds;

dcl-c qlg_path_job_ccsid      const(0);
dcl-c qlg_path_job_countryid  const(x'0000');
dcl-c qlg_path_job_languageid const(x'000000');

dcl-ds qlg_attrarray_t qualified template;
  nume            int(10);
  attr            int(10) dim(64);
end-ds;

dcl-ds qlg_rtnattr_t qualified template;
  ofsnextattr     int(10);
  id              int(10);
  size            int(10);
  reserved        char(4);
end-ds;

dcl-c qp0l_attr_objtype              const(0);
dcl-c qp0l_attr_data_size            const(1);
dcl-c qp0l_attr_alloc_size           const(2);
dcl-c qp0l_attr_extended_attr_size   const(3);
dcl-c qp0l_attr_create_time          const(4);
dcl-c qp0l_attr_access_time          const(5);
dcl-c qp0l_attr_change_time          const(6);
dcl-c qp0l_attr_modify_time          const(7);
dcl-c qp0l_attr_stg_free             const(8);
dcl-c qp0l_attr_checked_out          const(9);
dcl-c qp0l_attr_local_remote         const(10);

dcl-c qp0l_donot_follow_symlnk       const(x'00');
dcl-c qp0l_follow_symlnk             const(x'01');

dcl-c qp0l_not_checked_out           const(x'00');
dcl-c qp0l_checked_out               const(x'01');

dcl-c qp0l_local_obj                 const(x'01');
dcl-c qp0l_remote_obj                const(x'02');

//  QSYSINC/SYS.TYPES
dcl-s off_t           int(10) template;
dcl-s size_t          uns(10) template;
dcl-s ssize_t         int(10) template;
dcl-s time_t          int(10) template;

//  opendir()--Open Directory                          // include <dirent.h>
dcl-pr opendir pointer extproc('opendir');
  i_pdirname      pointer value options(*string);
end-pr;

//  readdir()--Read Directory Entry
dcl-pr readdir pointer extproc('readdir');
  i_dirp          pointer value;
end-pr;

dcl-ds dirent_t qualified  template;
  d_reserv1       char(16);
  d_fileno_gen_id uns(10);
  d_fileno        uns(10);
  d_reclen        uns(10);
  d_reserv3       int(10);
  d_reserv4       char(8);
/if not defined(*V5R2M0)
  d_nlsinfo       like(qlg_nls_t);
/else
  d_nlsinfo       likeds(qlg_nls_t);
/endif
  d_namelen       uns(10);
  d_name          char(640);
end-ds;

dcl-ds qlg_nls_t qualified align template;
  ccsid           int(10);
  country_id      char(2);
  language_id     char(3);
  nls_reserved    char(3);
end-ds;

//  rewinddir()--Reset Directory Stream to Beginning
dcl-pr rewinddir extproc('rewinddir');
  i_dirp          pointer value;
end-pr;

//  closedir()--Close Directory
dcl-pr closedir int(10) extproc('closedir');
  i_dirp          pointer value;
end-pr;

//  fd/-1 = open()--Open File                          // include <fcntl.h>
dcl-pr open int(10) extproc('open');
  i_ppath         pointer value  options(*string);
  i_opnflag       int(10) value;
  i_mode          uns(10) value  options(*nopass);
  i_codepage      uns(10) value  options(*nopass);
end-pr;

//  <sys/stat.h>
dcl-c s_irusr const(         256);                     // ! Read For Own
dcl-c s_iwusr const(         128);                     // ! Write For Ow
dcl-c s_ixusr const(          64);                     // ! Exc/Srch For
dcl-c s_irwxu const(         448);                     // ! Rd/Wrt/Exc O

dcl-c s_irgrp const(          32);                     // ! Read For Gro
dcl-c s_iwgrp const(          16);                     // ! Write For Gr
dcl-c s_ixgrp const(           8);                     // ! Exc/Srch For
dcl-c s_irwxg const(          56);                     // ! Rd/Wrt/Exc G

dcl-c s_iroth const(           4);                     // ! Read For Oth
dcl-c s_iwoth const(           2);                     // ! Write For Ot
dcl-c s_ixoth const(           1);                     // ! Exc/Srch For
dcl-c s_irwxo const(           7);                     // ! Rd/Wrt/Exc O

//  <h/fcntl.h>
dcl-c o_creat const( 8);                               // ! Append Mode
dcl-c o_excl const(16);                                // ! Exclusive Us
dcl-c o_trunc const(64);                               // ! Truncate Fla

dcl-c o_append const(256);                             // ! Append Mode

dcl-c o_codepage const(  8388608);                     // ! Codepage Fla
dcl-c o_textdata const( 16777216);                     // ! Text Data Fl
dcl-c o_inheritmode const(134217728);                  // ! Inherit Mode
dcl-c o_ccsid const(       32);                        // ! CCSID

dcl-c o_share_rdonly const( 65536);                    // ! Shared Read
dcl-c o_share_wronly const(131072);                    // ! Shared Write
dcl-c o_share_rdwr const(262144);                      // ! Shared Rd/Wr
dcl-c o_share_none const(524288);                      // ! No Share

dcl-c o_rdonly const(1);                               // ! Read Only
dcl-c o_wronly const(2);                               // ! Write Only
dcl-c o_rdwr const(4);                                 // ! Read/Write

//  value/-1 = read()--Write from Descriptor           // include <unistd.h>
dcl-pr read
       extproc('read')   like(ssize_t   );
  i_fd            int(10) value;
  i_pbuffer       pointer value;
  i_buflen        value like(size_t    );
end-pr;

//  value/-1 = write()--Write to Descriptor            // include <unistd.h>
dcl-pr write
       extproc('write')  like(ssize_t   );
  i_fd            int(10) value;
  i_pbuffer       pointer value;
  i_buflen        value like(size_t    );
end-pr;

//  0/-1 = ftruncate()--Truncate File                  // include <unistd.h>
dcl-pr ftruncate
       int(10) extproc('ftruncate');
  i_fd            int(10) value;
  i_length        value like(off_t     );
end-pr;

//  off_t = lseek()--Set File Read/Write Offset        // include <unistd.h>
dcl-pr lseek
       extproc('lseek')  like(off_t     );
  i_fd            int(10) value;
  i_offset        value like(off_t     );
  i_whence        int(10) value;
end-pr;

//  <h/unistd.h>
dcl-c seek_set const(0);                               // ! seek start
dcl-c seek_cur const(1);                               // ! seek curPos
dcl-c seek_end const(2);                               // ! seek end

//  0/-1 = unlink()--Remove Link to File               // include <unistd.h>
dcl-pr unlink
       int(10) extproc('unlink');
  i_ppath         pointer value options(*string);
end-pr;

//  0/-1 = Qp0lRenameKeep()--Rename File or Directory, Keep "new" If It Exists
dcl-pr qp0lrenamekeep
       int(10) extproc('Qp0lRenameKeep');
  i_poldpath      pointer value options(*string);
  i_pnewpath      pointer value options(*string);
end-pr;

//  0/-1 = close()--Close File or Socket Descriptor    // include <unistd.h>
dcl-pr close
       int(10) extproc('close');
  i_fd            int(10) value;
end-pr;

//  erno--Set Pointer to Runtime Error Code
dcl-pr errno           pointer extproc('__errno');
end-pr;

//  strerror -- Set Pointer to Runtime Error Message
dcl-pr strerror        pointer extproc('strerror');
  errno           int(10) value;
end-pr;

//  <sys/errno.h>
dcl-c edom_c const(3001);                              // domain error i
dcl-c erange_c const(3002);                            // range error in
dcl-c etrunc_c const(3003);                            // truncation on
dcl-c enotopen_c const(3004);                          // file has not b
dcl-c enotread_c const(3005);                          // file not opene
dcl-c erecio_c const(3008);                            // file opened fo
dcl-c enotwrite_c const(3009);                         // file not opene
dcl-c estdin_c const(3010);                            // stdin cannot b
dcl-c estdout_c const(3011);                           // stdout cannot
dcl-c estderr_c const(3012);                           // stderr cannot
dcl-c ebadseek_c const(3013);                          // bad offset to
dcl-c ebadname_c const(3014);                          // invalid file n
dcl-c ebadmode_c const(3015);                          // invalid file m
dcl-c ebadpos_c const(3017);                           // invalid positi
dcl-c enopos_c const(3018);                            // no record at s
dcl-c enummbrs_c const(3019);                          // no ftell if mo
dcl-c enumrecs_c const(3020);                          // no ftell if to
dcl-c ebadfunc_c const(3022);                          // invalid functi
dcl-c enorec_c const(3026);                            // record not fou
dcl-c ebaddata_c const(3028);                          // message data i
dcl-c ebadopt_c const(3040);                           // bad option on
dcl-c enotupd_c const(3041);                           // file not opene
dcl-c enotdlt_c const(3042);                           // file not opene
dcl-c epad_c const(3043);                              // padding occurr
dcl-c ebadkeyln_c const(3044);                         // bad key length
dcl-c eputandget_c const(3080);                        // illegal write
dcl-c egetandput_c const(3081);                        // illegal read a
dcl-c eioerror_c const(3101);                          // I/O exception
dcl-c eiorecerr_c const(3102);                         // I/O exception

//  The following values are defined by POSIX ISO/IEC 9945-1:1990.
dcl-c einval_c const(3021);                            // invalid argume
dcl-c eio_c const(3006);                               // input/output e
dcl-c enodev_c const(3007);                            // no such device
dcl-c ebusy_c const(3029);                             // resource busy
dcl-c enoent_c const(3025);                            // no such file o
dcl-c eperm_c const(3027);                             // operation not

//  AS/400 specific error numbers
dcl-c eacces_c const(3401);                            // Permission den
dcl-c enotdir_c const(3403);                           // Not a director
dcl-c enospc_c const(3404);                            // No space avail
dcl-c exdev_c const(3405);                             // Improper link.
dcl-c ewouldblock_c const(3406);                       // Operation woul
dcl-c eagain_c const(3406);                            // Operation woul
dcl-c eintr_c const(3407);                             // Interrupted fu
dcl-c efault_c const(3408);                            // The address us
dcl-c etime_c const(3409);                             // Operation time
dcl-c enxio_c const(3415);                             // No such device
dcl-c eclosed_c const(3417);                           // Socket closed
dcl-c eaddrinuse_c const(3420);                        // Address alread
dcl-c eaddrnotavail_c
      const(3421);                                     // Address not av
dcl-c eafnosupport_c const(3422);                      // The type of so
dcl-c ealready_c const(3423);                          // Operation alre
dcl-c econnaborted_c const(3424);                      // Connection end
dcl-c econnrefused_c const(3425);                      // A remote host
dcl-c econnreset_c const(3426);                        // A connection w
dcl-c edestaddrreq_c const(3427);                      // Operation requ
dcl-c ehostdown_c const(3428);                         // A remote host
dcl-c ehostunreach_c const(3429);                      // A route to the
dcl-c einprogress_c const(3430);                       // Operation in p
dcl-c eisconn_c const(3431);                           // A connection h
dcl-c emsgsize_c const(3432);                          // Message size o
dcl-c enetdown_c const(3433);                          // The network is
dcl-c enetreset_c const(3434);                         // A socket is co
dcl-c enetunreach_c const(3435);                       // Cannot reach t
dcl-c enobufs_c const(3436);                           // There is not e
dcl-c enoprotoopt_c const(3437);                       // The protocol d
dcl-c enotconn_c const(3438);                          // Requested oper
dcl-c enotsock_c const(3439);                          // The specified
dcl-c enotsup_c const(3440);                           // Operation not
dcl-c eopnotsupp_c const(3440);                        // Operation not
dcl-c epfnosupport_c const(3441);                      // The socket pro
dcl-c eprotonosupport_c
      const(3442);                                     // No protocol of
dcl-c eprototype_c const(3443);                        // The socket typ
dcl-c ercvderr_c const(3444);                          // An error indic
dcl-c eshutdown_c const(3445);                         // Cannot send da
dcl-c esocktnosupport_c
      const(3446);                                     // The specified
dcl-c etimedout_c const(3447);                         // A remote host
dcl-c eunatch_c const(3448);                           // The protocol r
dcl-c ebadf_c const(3450);                             // Descriptor not
dcl-c emfile_c const(3452);                            // Too many open
dcl-c enfile_c const(3453);                            // Too many open
dcl-c epipe_c const(3455);                             // Broken pipe.
dcl-c eexist_c const(3457);                            // File exists.
dcl-c edeadlk_c const(3459);                           // Resource deadl
dcl-c enomem_c const(3460);                            // Storage alloca
dcl-c eownerterm_c const(3462);                        // The mutex no l
dcl-c edestroyed_c const(3463);                        // he synchroniza
dcl-c eterm_c const(3464);                             // Operation term
dcl-c emlink_c const(3468);                            // Maximum link c
dcl-c espipe_c const(3469);                            // Seek request n
dcl-c enosys_c const(3470);                            // Function not i
dcl-c eisdir_c const(3471);                            // Specified targ
dcl-c erofs_c const(3472);                             // Read-only file
dcl-c eunknown_c const(3474);                          // Unknown system
dcl-c eiterbad_c const(3475);                          // Iterator is in
dcl-c edamage_c const(3484);                           // A damaged obje
dcl-c eloop_c const(3485);                             // A loop exists
dcl-c enametoolong_c const(3486);                      // A path name is
dcl-c enolck_c const(3487);                            // No locks avail
dcl-c enotempty_c const(3488);                         // Directory not
dcl-c enosysrsc_c const(3489);                         // System resourc
dcl-c econvert_c const(3490);                          // Conversion err
dcl-c e2big_c const(3491);                             // Argument list
dcl-c eilseq_c const(3492);                            // Conversion sto
dcl-c esoftdamage_c const(3497);                       // Object has sof
dcl-c enotenroll_c const(3498);                        // User not enrol
dcl-c eoffline_c const(3499);                          // Object is susp
dcl-c eroobj_c const(3500);                            // Object is a re
dcl-c elocked_c const(3506);                           // Area being rea
dcl-c efbig_c const(3507);                             // Object too lar
dcl-c eidrm_c const(3509);                             // The semaphore,
dcl-c enomsg_c const(3510);                            // The queue does
dcl-c efilecvt_c const(3511);                          // File ID conver
dcl-c ebadfid_c const(3512);                           // A File ID coul
dcl-c estale_c const(3513);                            // A File ID coul
dcl-c esrch_c const(3515);                             // No such proces
dcl-c enotsiginit_c const(3516);                       // Process not en
dcl-c echild_c const(3517);                            // No child proce
dcl-c etoomanyrefs_c const(3523);                      // The operation
dcl-c enotsafe_c const(3524);                          // Function not a
dcl-c eoverflow_c const(3525);                         // Object is too
dcl-c ejrndamage_c const(3526);                        // Journal damage
dcl-c ejrninactive_c const(3527);                      // Journal inacti
dcl-c ejrnrcvspc_c const(3528);                        // Journal space
dcl-c ejrnrmt_c const(3529);                           // Journal is rem
dcl-c enewjrnrcv_c const(3530);                        // New journal re
dcl-c enewjrn_c const(3531);                           // New journal is
dcl-c ejournaled_c const(3532);                        // Object already
dcl-c ejrnenttoolong_c
      const(3533);                                     // Entry too larg
dcl-c edatalink_c const(3534);                         // Object is a Da
dcl-c enotavail_c const(3535);                         // Independent AS
dcl-c enotty_c const(3536);                            // Inappropriate
dcl-c efbig2_c const(3540);                            // Write or trunc
dcl-c etxtbsy_c const(3543);                           // Text file busy
dcl-c easpgrpnotset_c
      const(3544);                                     // ASP group not
dcl-c erestart_c const(3545);                          // System call ca
dcl-c escanfailure_c const(3546);                      // Object marked

//  Unix return codes
dcl-c rc_ok const(0);
dcl-c rc_error const(-1);

//  Convert External Form to Numeric Value (CVTEFN)
dcl-pr cvtefnd
       float(8) extproc('cvtefnd');
  i_source        pointer value;
  i_len           uns(10) value;
  i_mask          pointer value;
end-pr;

//  Test Bit in String (TSTBTS)
dcl-pr tstbts
       int(10) extproc('tstbts');
  bit_string      pointer value;
  bit_offset      int(10) value;
end-pr;

//  getenv()--Get Value of Environment Variable
dcl-pr getenv
       pointer extproc('getenv');
  name            pointer value  options(*string);
end-pr;

//  putenv()--Change or Add Environment Variable
dcl-pr putenv
       int(10) extproc('putenv');
  string          pointer value  options(*string);
end-pr;

//  Qp0zDltEnv()--Delete an Environment Variable
dcl-pr qp0zdltenv
       int(10) extproc('Qp0zDltEnv');
  name            pointer value  options(*string);
end-pr;

//  Qp0zInitEnv()--Initialize Environment for Variables
dcl-pr qp0zinitenv
       int(10) extproc('Qp0zInitEnv');
end-pr;

dcl-s environ         pointer import('environ');

//  Generate Universal Unique Identifier (GENUUID)
dcl-pr genuuid
       extproc('_GENUUID');
  uuid_template   pointer value;
end-pr;

dcl-ds uuid_template_t
       qualified  template;
  bytprv          uns(10);
  bytavl          uns(10);
  reserved        char(8);
  uuid            char(16);
end-ds;

//  Convert Hex to Character (CVTHC)
dcl-pr cvthc
       extproc('cvthc');
  presult         pointer value;
  psource         pointer value;
  sourcesize      int(10) value;
end-pr;

//  Convert Eight Bit Character to Hex Nibbles (CVTCH)
dcl-pr cvtch
       extproc('cvtch');
  presult         pointer value;
  psource         pointer value;
  sourcelen       int(10) value;
end-pr;

//  Cipher (CIPHER)
dcl-pr cipher extproc('_CIPHER');
  *N              pointer const;
  *N              pointer value;
  *N              pointer const;
end-pr;

dcl-ds cipherctrls_t qualified align template;
  function        char(2) pos(1);
  hashalg         char(1) pos(3);
  sequence        char(1) pos(4);
  datalength      uns(10) pos(5);
  output          char(1) pos(9);
  reserved_1      char(7) pos(10);
  hashcontext     pointer pos(17);
  hmackey         pointer pos(33);
  hmackeylength   uns(10) pos(49);
  reserved_2      char(44) pos(53);
end-ds;

dcl-c ccipher_md5    const(x'00');
dcl-c ccipher_sha1   const(x'01');

dcl-c ccipher_only   const(x'00');
dcl-c ccipher_first  const(x'01');
dcl-c ccipher_middle const(x'02');
dcl-c ccipher_final  const(x'03');

dcl-c ccipher_hash   const(x'00');
dcl-c ccipher_hmac   const(x'01');

/ENDIF
