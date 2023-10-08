      /if not defined(QWCRSVAL)
      /define QWCRSVAL
      *
      *  Retrieve System Values (QWCRSVAL) API
     d QWCRSVAL...
     d                 pr                         extpgm('QWCRSVAL')
     d  o_rcvVar                  65535a          options(*varsize)
     d  i_lenRcvVar                  10i 0 const
     d  i_numSysVal                  10i 0 const
     d  i_arySysVal                  10a   const  options(*varsize) dim(128)
     d  io_errCode                65535a          options(*varsize)
      *
      *  Return value
     d QWCRSVAL_rtnValue_t...
     d                 ds          4096    qualified template
     d  numSysValRtn                 10i 0
     d  ofsSysValTbl                 10i 0 dim(128)
      *
     d QWCRSVAL_sysValInfTbl_t...
     d                 ds                  qualified based(pSysValTbl)
     d  sysVal                       10a
     d  type                          1a
     d  infStatus                     1a
     d  length                       10i 0
     d  data                       4096A
      *
      * --------------------------------------------------
      *  Pre-defined structures for complex system values
      * --------------------------------------------------
      *
      *  QACGLVL:         Accounting level
     d QWCRSVAL_acgLvl_t...
     d                 ds                  qualified
     d  option                       10a   dim(8)
      *
      *  QALWOBJRST:      Allow object restore options
     d QWCRSVAL_alwObjRst_t...
     d                 ds                  qualified
     d  option                       10a   dim(15)
      *
      *  QALWUSRDMN:      Allow user domain
     d QWCRSVAL_alwUsrDmn_t...
     d                 ds                  qualified
     d  lib                          10a   dim(50)
      *
      *  QATNPGM:        Attention program
     d QWCRSVAL_atnPgm_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QAUDCTL:         Auditing control
     d QWCRSVAL_audCtl_t...
     d                 ds                  qualified
     d  option                       10a   dim(5)
      *
      *  QAUDLVL:         Auditing level
     d QWCRSVAL_audLvl_t...
     d                 ds                  qualified
     d  option                       10a   dim(16)
      *
      *  QAUDLVL2:        Auditing level extension
     d QWCRSVAL_audLvl2_t...
     d                 ds                  qualified
     d  option                       10a   dim(99)
      *
      *  QBOOKPATH:      Book and bookshelf search path
     d QWCRSVAL_bookPath_t...
     d                 ds                  qualified
     d  path                         63A   dim(5)
      *
      *  QCFGMSGQ:       Configuration message queue
     d QWCRSVAL_cfgMsgQ_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QCHRID:         Character set and code page
     d QWCRSVAL_chrID_t...
     d                 ds                  qualified
     d  ccsid                        10a
     d  codePage                     10a
      *
      *  QCMNRCYLMT:     Communications recovery limit
     d QWCRSVAL_cmnRcyLmt_t...
     d                 ds                  qualified
     d  count                        10a
     d  interval                     10a
      *
      *  QCTLSBSD:       Controlling subsystem
     d QWCRSVAL_ctlSbsD_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QDATETIME:      System date and time       (YYYYMMDDHHNNSSXXXXXX)
     d QWCRSVAL_dateTime_t...
     d                 ds                  qualified
     d  date                          8a
     d  time                          6a
     d  mSecs                         6a
      *
      *  QIGCCDEFNT:     Double-byte coded font name
     d QWCRSVAL_igcCdeFnt_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QINACTMSGQ:   Inactive message queue
     d QWCRSVAL_inActMsgQ_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QIPLDATTIM:   Automatic IPL date and time  (value = CYYMMDDHHMMSS)
     d QWCRSVAL_iplDatTim_t...
     d                 ds                  qualified
     d  spcVal                 1     10A
     d  value                  1     13A
      *
      *  QPRBFTR:      Problem filter
     d QWCRSVAL_prbFtr_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QPWDVLDPGM:   Password validation program
     d QWCRSVAL_pwdVldPgm_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QRMTSIGN:     Remote sign-on
     d QWCRSVAL_rmtSign_t...
     d                 ds                  qualified
     d  spcVal                       10a
     d  pgm                          10a   overlay(spcVal)
     d  lib                          10a
      *
      *  QSCANFS:      Scan file systems
     d QWCRSVAL_scanFS_t...
     d                 ds                  qualified
     d  option                       10a   dim(20)
      *
      *  QSCANFSCTL:   Scan file systems control
     d QWCRSVAL_scanFSCtl_t...
     d                 ds                  qualified
     d  option                       10a   dim(20)
      *
      *  QSETJOBATR:   Set job attributes from locale
     d QWCRSVAL_setJobAtr_t...
     d                 ds                  qualified
     d  attr                         10a   dim(16)
      *
      *  QSRTSEQ:      Sort sequence table
     d QWCRSVAL_srtSeq_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QSTRUPPGM:    Startup program name
     d QWCRSVAL_strUpPgm_t...
     d                 ds                  qualified
     d  name                         10a
     d  lib                          10a
      *
      *  QSYSLIBL:     System library list
     d QWCRSVAL_sysLibl_t...
     d                 ds                  qualified
     d  lib                          10a   dim(15)
      *
      *  QUSRLIBL:     User library list
     d QWCRSVAL_usrLibl_t...
     d                 ds                  qualified
     d  lib                          10a   dim(25)
      *
      *  QUTCOFFSET:   Coordinated universal time offset
     d QWCRSVAL_utcOffset_t...
     d                 ds                  qualified
     d  timeZoneID                    1a
     d  hours                         2a
     d  minutes                       2a
      *
      /endif
