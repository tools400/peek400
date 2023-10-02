      /if not defined(QTNRCMTI)
      /define QTNRCMTI
      *
      *  ... Retrieve Commitment Information (QTNRCMTI) API
     d QTNRCMTI...
     d                 pr                  extpgm('QTNRCMTI')
     D  o_rcvVar                  65535A          options(*varsize)
     D  i_rcvVarLen                  10I 0 const
     D  i_format                      8A   const
     D  io_errCode                65535A          options(*varsize)
      *
      *  This format returns commitment information.
     D cmti0100_t      DS                  qualified           based(pDummy)
     D  bytRet                       10I 0
     D  bytAvl                       10I 0
     D  status                        1A
     D  lockLevel                    10A
     D  scope                         1A
     D  statusActGrp                  1A
     D  waitOutcome                   1A
     D  problemAction                 1A
     D  voteReadOnly                  1A
     D  actionEndJob                  1A
     D  dftJrnName                   10A
     D  dftJrnLib                    10A
     D  LUOW_id                      39A
     D  lastAgentPermitted...
     D                                1A
     D  okToLeaveOut                  1A
     D  acceptVoteReliable...
     D                                1A
      *
      /endif
