?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about MBRL0200:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *   M2MNME - Member name used                                   *                       RADDAT
?     *   M2SRCT - Source type                                        *                       RADDAT
?     *   M2CRDT - Creation date and time                             *                       RADDAT
?     *   M2LCDT - Last source change date and time                   *                       RADDAT
?     *   M2MTXT - Member text description                            *                       RADDAT
?     *   M2TCID - Member text description CCSID                      *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  list API format MBRL0200                                                             RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XLIST into its units. See GETDBR_DMO)                                      RADDAT
     D MBRL0200        DS                                                                     RADDAT
     D  M2MNME                 1     10                                                       RADDAT
     D  M2SRCT                11     20                                                       RADDAT
     D  M2CRDT                21     33                                                       RADDAT
     D  M2LCDT                34     46
     D  M2MTXT                47     96
     D  M2TCCS                97    100I 0                                                    RADDAT
?     *                                                                                       RADDAT
