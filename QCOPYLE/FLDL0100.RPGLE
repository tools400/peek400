      *===============================================================*
      *                                                               *
      *  Additional information about FLDL0100:                       *
      *                                                               *
      *   F1FNME - File name used                                     *
      *   F1DTYP - Data type                                          *
      *            A=alphanumeric data                                *
      *            B=Binary                                           *
      *            D=Digits only                                      *
      *            E=Either DBCS or alphanumeric                      *
      *            F=Floating point                                   *
      *            G=Graphic data type                                *
      *            H=Hexadecimal                                      *
      *            I=Inhibit entry                                    *
      *            J=Double-byte character set (DBCS) data only       *
      *            L=Date                                             *
      *            M=Numeric only                                     *
      *            N=Numeric shift                                    *
      *            O=(Open) Both DBCS and alphanumeric                *
      *            P=Packed decimal                                   *
      *            S=Zoned decimal                                    *
      *            T=Time                                             *
      *            W=Katakana                                         *
      *            X=Alphabetic only (character)                      *
      *            Y=Numeric only                                     *
      *            Z=Timestamp                                        *
      *   F1USE  - Use                                                *
      *            I=Input                                            *
      *            O=Output                                           *
      *            B=Both input and output                            *
      *            N=Neither                                          *
      *   F1OBUF - Output buffer position                             *
      *   F1IBUF - Input buffer position                              *
      *   F1FLEN - Field length in bytes                              *
      *   F1DIGT - Digits                                             *
      *   F1DECP - Decimal position                                   *
      *            The number of decimal positions. This entry is     *
      *            zero if the field is not numeric.                  *
      *   F1FTXT - Field text description                             *
      *   F1EDTC - Edit code                                          *
      *   F1EDWL - Edit word length                                   *
      *   F1EDWD - Edit word                                          *
      *   F1COL1 - Column heading 1                                   *
      *   F1COL2 - Column heading 2                                   *
      *   F1COL3 - Column heading 3                                   *
      *   F1IFNM - Internal field name                                *
      *   F1AFNM - Alternative field name                             *
      *   F1AFNL - Length of alternative field name                   *
      *   F1NDBC - Number of DBCS characters                          *
      *   F1NALW - Null values allowed                                *
      *            0=not allowed                                      *
      *            1=allowed                                          *
      *   F1HVRI - Host variable indicator                            *
      *   F1DTFM - Date and time format                               *
      *            (Only available for date, time and timestamp)      *
      *            *USA=IBM USA standard                              *
      *            *ISO=International standard organisation           *
      *            *EUR=IBM European standard                         *
      *            *JIS=Japanese industrial standard                  *
      *            *SAA=SAA timestamp                                 *
      *            *MDY=Month/day/year                                *
      *            *DMY=Day/month/year                                *
      *            *YMD=Year/month/day                                *
      *            *JUL=Julian                                        *
      *            *HMS=Hour/minute/second                            *
      *   F1DTSP - Date and time separator                            *
      *            (Only available for date, time and timestamp)      *
      *            /  -  .  ,  :                                      *
      *   F1VFMI - Variable length field indicator                    *
      *            (overlay for MI mapping)                           *
      *   F1FTCC - Field text description CCSID                       *
      *            0=there is no fild text description                *
      *   F1FDCC - Field data CCSID                                   *
      *            0=there is no field data                           *
      *   F1CHCC - Field column headings CCSID                        *
      *            0=there are no field column headings               *
      *   F1EWCC - Field edit words CCSID                             *
      *            0=there are no field edit words                    *
      *   F1VFLD - Internal field name for variable length fields     *
      *   F1KEYF - Internal indicator for key fields                  *
      *   F1SEQ  - Internal sequence number of field in record format *
      *   F1UCS2 - UCS-2 Field                                        *
      *                                                               *
      *===============================================================*
      *
      *  list API format FLDL0100
     D FLDL0100_t      DS                  qualified template
     D  F1FNME                 1     10
     D  F1DTYP                11     11
     D  F1USE                 12     12
     D  F1OBUF                13     16I 0
     D  F1IBUF                17     20I 0
     D  F1FLEN                21     24I 0
     D  F1DIGT                25     28I 0
     D  F1DECP                29     32I 0
     D  F1FTXT                33     82
     D  F1EDTC                83     84
     D  F1EDWL                85     88I 0
     D  F1EDWD                89    152
     D  F1COL1               153    172
     D  F1COL2               173    192
     D  F1COL3               193    212
     D  F1IFNM               213    222
     D  F1AFNM               223    252
     D  F1AFNL               253    256I 0
     D  F1NDBC               257    260I 0
     D  F1NALW               261    261
     D  F1HVRI               262    262
     D  F1DTFM               263    266
     D  F1DTSP               267    267
     D  F1VFMI               268    268
     D  F1FTCC               269    272I 0
     D  F1FDCC               273    276I 0
     D  F1CHCC               277    280I 0
     D  F1EWCC               281    284I 0
     D  F1VFLD               513    522
     D  F1KEYF               533    534
     D  F1SEQ                535    538I 0
     D  F1UCS2               539    539
      *
