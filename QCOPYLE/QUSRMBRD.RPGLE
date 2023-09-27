      /if not defined(QUSRMBRD)
      /define QUSRMBRD
      *
      *  Retrieve Member Description (QUSRMBRD) API
     d QUSRMBRD...
     d                 pr                         extpgm('QUSRMBRD')
     d  o_rcvVar                  65535a          options(*varsize)
     d  i_lenRcvVar                  10i 0 const
     d  i_format                      8a   const
     d  i_qFile                      20A   const
     d  i_mbr                        10a   const
     d  i_ovrPrc                      1a   const
     d  io_errCode                65535a          options(*nopass: *varsize)    | OptGrp 1
     d  i_findMbrPrc                  1a   const  options(*nopass)              | OptGrp 2
      *
      /endif
