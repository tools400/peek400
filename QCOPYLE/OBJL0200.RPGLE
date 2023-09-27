      *===============================================================*
      *                                                               *
      *  Additional information about OBJL0200:                       *
      *                                                               *
      *   O2ONME - Object name used                                   *
      *   O2OLIB - Library name used                                  *
      *   O2TYPE - Object type used                                   *
      *   O2ISTS - Information status                                 *
      *   O2XATR - Extended object attribute                          *
      *   O2TEXT - Text descrition                                    *
      *   O2UATR - User defined attribute                             *
      *                                                               *
      *===============================================================*
      *
      *  list API format OBJL0200
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units. See GETDBR_DMO)
     D OBJL0200_t      DS                  qualified template
     D  O2ONME                 1     10A
     D  O2LNME                11     20A
     D  O2TYPE                21     30A
     D  O2ISTS                31     31A
     D  O2XATR                32     41A
     D  O2TEXT                42     91A
     D  O2UATR                92    101A
      *
