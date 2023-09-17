      /IF NOT DEFINED(QUSRJOBI)                                                               RADDAT
      /DEFINE QUSRJOBI
?     *                                                                                       RADDAT
      /IF NOT DEFINED(qJob_t    )                                                             RADDAT
      /DEFINE qJob_t                                                                          RADDAT
?     *   Qualified job name                                                                  RADDAT
     D qJob_t          DS                  qualified           based(pDummy)                  RADDAT
     D  name                         10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
      /ENDIF                                                                                  RADDAT
?     *                                                                                       RADDAT
?     *  Retrieve Job Information (QUSRJOBI) API                                              RADDAT
     D QUSRJOBI...
     D                 PR                  extpgm('QUSRJOBI')
     D  o_rcvVar                  65535A          options(*varsize)
     D  i_rcvVarLen                  10I 0 const
     D  i_format                      8A   const
     D  i_qJob                       26A   const
     D  i_intJobID                   16A   const
     D  io_errCode                65535A          options(*nopass: *varsize)    OptGrp 1
     D  i_resPrfStat                  1A   const  options(*nopass)              OptGrp 2
?     *                                                                                       RADDAT
?     *  This format returns basic performance information about a job.                       RADDAT
     D jobi0100_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  reserved_1                    2A                                                      RADDAT
     D  runPty                       10I 0                                                    RADDAT
     D  timeSlice                    10I 0                                                    RADDAT
     D  dftWait                      10I 0                                                    RADDAT
     D  purge                        10A
?     *                                                                                       RADDAT
?     *  This format returns information equivalent to that found on the                      RADDAT
?     *  Work with Active Jobs (WRKACTJOB) command.                                           RADDAT
     D jobi0200_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  sbsDName                     10A                                                      RADDAT
     D  runPty                       10I 0                                                    RADDAT
     D  sysPoolID                    10I 0                                                    RADDAT
     D  prcTimeUsd                   10I 0                                                    RADDAT
     D  numAuxIORq                   10I 0                                                    RADDAT
     D  numIntTact                   10I 0                                                    RADDAT
     D  rspTimeTot                   10I 0                                                    RADDAT
     D  fncType                       1A                                                      RADDAT
     D  fncName                      10A                                                      RADDAT
     D  actJobSts                     4A                                                      RADDAT
     D  numDBLckW                    10I 0                                                    RADDAT
     D  numIntLckW                   10I 0                                                    RADDAT
     D  numNonDBLckW                 10I 0                                                    RADDAT
     D  timeDBLckW                   10I 0                                                    RADDAT
     D  timeIntLckW                  10I 0                                                    RADDAT
     D  timeNonDBLckW                10I 0                                                    RADDAT
     D  reserved_01                   1A                                                      RADDAT
     D  currSysPoolID                10I 0                                                    RADDAT
     D  thrdCount                    10I 0                                                    RADDAT
     D  prcUntTmUsd                  20U 0                                                    RADDAT
     D  numAuxIORqLng                20U 0                                                    RADDAT
     D  prcUntTmUsdDB                20U 0                                                    RADDAT
     D  pageFaults                   20U 0                                                    RADDAT
     D  actJobStsJobEnd...                                                                    RADDAT
     D                                4A                                                      RADDAT
     D  memPoolName                  10A                                                      RADDAT
     D  msgRply                       1A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  This format returns job queue and output queue information for a job, as             RADDAT
?     *  well as information about the submitter's job if the job is a submitted batch job.   RADDAT
     D jobi0300_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  jobQ                         10A                                                      RADDAT
     D  jobQLib                      10A                                                      RADDAT
     D  jobQPty                       2A                                                      RADDAT
     D  outQ                         10A                                                      RADDAT
     D  outQLib                      10A                                                      RADDAT
     D  outQPty                       2A                                                      RADDAT
     D  prtDev                       10A                                                      RADDAT
     D  sbmJob                       10A                                                      RADDAT
     D  sbmUser                      10A                                                      RADDAT
     D  sbmNbr                        6A                                                      RADDAT
     D  sbmMsgQ                      10A                                                      RADDAT
     D  sbmMsgQLib                   10A                                                      RADDAT
     D  stsOnJobQ                    10A                                                      RADDAT
     D  datTimSbm                     8A                                                      RADDAT
     D  jobDate                       7A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  This format primarily returns job attribute types of information.                    RADDAT
     D jobi0400_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  dateTimeEnt                  13A                                                      RADDAT
     D  dateTimeAct                  13A                                                      RADDAT
     D  jobAcctCode                  15A                                                      RADDAT
     D  jobD                         10A                                                      RADDAT
     D  jobDLib                      10A                                                      RADDAT
     D  unitOfWorkID                 24A                                                      RADDAT
     D  mode                          8A                                                      RADDAT
     D  inqMsgRply                   10A                                                      RADDAT
     D  logCLPgms                    10A                                                      RADDAT
     D  brkMsgHdl                    10A                                                      RADDAT
     D  stsMsgHdl                    10A                                                      RADDAT
     D  devRcvrAct                   13A                                                      RADDAT
     D  ddmCnvHdl                    10A                                                      RADDAT
     D  dateSep                       1A                                                      RADDAT
     D  dateFmt                       4A                                                      RADDAT
     D  prtText                      30A                                                      RADDAT
     D  sbmJob                       10A                                                      RADDAT
     D  sbmUser                      10A                                                      RADDAT
     D  sbmNbr                        6A                                                      RADDAT
     D  sbmMsgQ                      10A                                                      RADDAT
     D  sbmMsgQLib                   10A                                                      RADDAT
     D  timeSep                       1A                                                      RADDAT
     D  ccsid                        10I 0                                                    RADDAT
     D  dateTimeScd                   8A                                                      RADDAT
     D  prtKeyFmt                    10A                                                      RADDAT
     D  sortSeq                      10A                                                      RADDAT
     D  sortSeqLib                   10A                                                      RADDAT
     D  langID                        3A                                                      RADDAT
     D  countryID                     2A                                                      RADDAT
     D  complSts                      1A                                                      RADDAT
     D  signedOnJob                   1A                                                      RADDAT
     D  jobSws                        8A                                                      RADDAT
     D  msgQFullAct                  10A                                                      RADDAT
     D  reserved_01                   1A                                                      RADDAT
     D  msgQMaxSize                  10I 0                                                    RADDAT
     D  dftCcsid                     10I 0                                                    RADDAT
     D  rtgData                      80A                                                      RADDAT
     D  decFmt                        1A                                                      RADDAT
     D  chrIDCtrl                    10A                                                      RADDAT
     D  serverType                   30A                                                      RADDAT
     D  alwMltThrds                   1A                                                      RADDAT
     D  jobLogPnd                     1A                                                      RADDAT
     D  reserved_02                   1A                                                      RADDAT
     D  jobEndRsn                    10I 0                                                    RADDAT
     D  jobTypeEnhncd                10I 0                                                    RADDAT
     D  dateTimeEnd                  13A                                                      RADDAT
     D  reserved_03                   1A                                                      RADDAT
     D  splFActn                     10A                                                      RADDAT
     D  ofsAspGrpInf                 10I 0                                                    RADDAT
     D  numEAspGrpInf                10I 0                                                    RADDAT
     D  lenAspGrpInfE                10I 0                                                    RADDAT
     D  timeZoneDscNm                10A                                                      RADDAT
     D  jobLogOutput                 10A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  This format returns information about active jobs only.                              RADDAT
?     *  It is intended to supplement the JOBI0400 format.                                    RADDAT
     D jobi0600_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  jobSws                        8A                                                      RADDAT
     D  endStatus                     1A                                                      RADDAT
     D  sbsD                         10A                                                      RADDAT
     D  sbsDLib                      10A                                                      RADDAT
     D  curUser                      10A                                                      RADDAT
     D  dbcs                          1A                                                      RADDAT
     D  exitKey                       1A                                                      RADDAT
     D  cancelKey                     1A                                                      RADDAT
     D  prdRetCode                   10I 0                                                    RADDAT
     D  userRetCode                  10I 0                                                    RADDAT
     D  pgmretCode                   10I 0                                                    RADDAT
     D  spcEnv                       10A                                                      RADDAT
     D  device                       10A                                                      RADDAT
     D  grpPrf                       10A                                                      RADDAT
     D  grpPrfAry                    10A   dim(15)                                            RADDAT
     D  jobUsrID                     10A                                                      RADDAT
     D  jobUsrIDStg                   1A                                                      RADDAT
?     *                                                                                       RADDAT
?     *  This format returns library list information for an active job.                      RADDAT
     D jobi0700_t      DS                  qualified           based(pDummy)                  RADDAT
     D  bytRet                       10I 0                                                    RADDAT
     D  bytAvl                       10I 0                                                    RADDAT
     D  job                          10A                                                      RADDAT
     D  user                         10A                                                      RADDAT
     D  nbr                           6A                                                      RADDAT
     D  intJobID                     16A                                                      RADDAT
     D  status                       10A                                                      RADDAT
     D  type                          1A                                                      RADDAT
     D  subType                       1A                                                      RADDAT
     D  reserved_1                    2A                                                      RADDAT
     D  numSysLibE                   10I 0                                                    RADDAT
     D  numPrdLibE                   10I 0                                                    RADDAT
     D  numCurLibE                   10I 0                                                    RADDAT
     D  numUsrLibE                   10I 0                                                    RADDAT
?     *   System library list                   Array (*) of CHAR(11)                         RADDAT
?     *   Product libraries                     Array (*) of CHAR(11)                         RADDAT
?     *   Current library                       Array (*) of CHAR(11)                         RADDAT
?     *   User library list                     Array (*) of CHAR(11)                         RADDAT
?     *                                                                                       RADDAT
      /ENDIF
