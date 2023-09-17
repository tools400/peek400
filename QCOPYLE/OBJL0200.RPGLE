?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about OBJL0200:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *   O2ONME - Object name used                                   *                       RADDAT
?     *   O2OLIB - Library name used                                  *                       RADDAT
?     *   O2TYPE - Object type used                                   *                       RADDAT
?     *   O2ISTS - Information status                                 *                       RADDAT
?     *   O2XATR - Extended object attribute                          *                       RADDAT
?     *   O2TEXT - Text descrition                                    *                       RADDAT
?     *   O2UATR - User defined attribute                             *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  list API format OBJL0200                                                             RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XLIST into its units. See GETDBR_DMO)                                      RADDAT
     D OBJL0200        DS                                                                     RADDAT
     D  O2ONME                 1     10A                                                      RADDAT
     D  O2LNME                11     20A                                                      RADDAT
     D  O2TYPE                21     30A                                                      RADDAT
     D  O2ISTS                31     31A                                                      RADDAT
     D  O2XATR                32     41A                                                      RADDAT
     D  O2TEXT                42     91A                                                      RADDAT
     D  O2UATR                92    101A                                                      RADDAT
?     *                                                                                       RADDAT
