      /if not defined(CEERTX)
      /define CEERTX
      *
      *  Register Call Stack Entry Termination User Exit Procedure (CEERTX)
     d CEERTX...
     d                 pr                         extproc('CEERTX')
     d  i_procPtr                      *   const  procptr
     d  i_rtxToken                     *   const  options(*omit)
     d  o_fc                                      likeds(cee_fc_t)
     d                                            options(*omit)
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
      /endif
