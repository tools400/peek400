      /if not defined(CEECNDHDLR)
      /define CEECNDHDLR
      *
      *  CEEHDLR—Register user-written condition handler
     d ceehdlr         pr
     d  i_pHdlProc                     *   const procptr
     d  i_pToken                       *   const
     d  o_fc                                     likeds(cee_fc_t)
     d                                           options(*omit)
      *
      *  CEEHDLU—Unregister user-written condition handler
     d ceehdlu         pr
     d  i_pHdlProc                     *   const procptr
     d  o_fc                                     likeds(cee_fc_t)
     d                                           options(*omit)
      *
      *  Condition token, used as feedback code
     d cee_fc_t        ds                  qualified template
     d  Condition_ID...
     d                         1      4A
     d   MsgSev                1      2I 0
     d   Msg_No                3      4U 0
     d  Flags                  5      5A
     d  Facility_ID...
     d                         6      8A
     d  I_S_Info               9     12A
      *
      *  Prototype for the condition handler.
     D errorHandler    pr                  extproc('errorHandler')
     D i_condition                         value likeds(cee_fc_t)
     D i_tokenIn                     10i 0 value
     D i_resultCode                  10i 0
     D o_newCondition                            likeds(cee_fc_t)
      *
      * Action codes are:
     D CEE_RESUME      C                   10
     D CEE_PERCOLATE   C                   20
      *
      /endif
