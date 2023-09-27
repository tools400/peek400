      *===============================================================*
      *                                                               *
      *  Additional information about MBRL0200:                       *
      *                                                               *
      *   M2MNME - Member name used                                   *
      *   M2SRCT - Source type                                        *
      *   M2CRDT - Creation date and time                             *
      *   M2LCDT - Last source change date and time                   *
      *   M2MTXT - Member text description                            *
      *   M2TCID - Member text description CCSID                      *
      *                                                               *
      *===============================================================*
      *
      *  list API format MBRL0200
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units. See GETDBR_DMO)
     D MBRL0200_t      DS                  qualified template
     D  M2MNME                 1     10
     D  M2SRCT                11     20
     D  M2CRDT                21     33
     D  M2LCDT                34     46
     D  M2MTXT                47     96
     D  M2TCCS                97    100I 0
      *
