**FREE
//===============================================================*
//                                                               *
//  Additional information about FLDL0100:                       *
//                                                               *
//   F1FNME - File name used                                     *
//   F1DTYP - Data type                                          *
//            A=alphanumeric data                                *
//            B=Binary                                           *
//            D=Digits only                                      *
//            E=Either DBCS or alphanumeric                      *
//            F=Floating point                                   *
//            G=Graphic data type                                *
//            H=Hexadecimal                                      *
//            I=Inhibit entry                                    *
//            J=Double-byte character set (DBCS) data only       *
//            L=Date                                             *
//            M=Numeric only                                     *
//            N=Numeric shift                                    *
//            O=(Open) Both DBCS and alphanumeric                *
//            P=Packed decimal                                   *
//            S=Zoned decimal                                    *
//            T=Time                                             *
//            W=Katakana                                         *
//            X=Alphabetic only (character)                      *
//            Y=Numeric only                                     *
//            Z=Timestamp                                        *
//   F1USE  - Use                                                *
//            I=Input                                            *
//            O=Output                                           *
//            B=Both input and output                            *
//            N=Neither                                          *
//   F1OBUF - Output buffer position                             *
//   F1IBUF - Input buffer position                              *
//   F1FLEN - Field length in bytes                              *
//   F1DIGT - Digits                                             *
//   F1DECP - Decimal position                                   *
//            The number of decimal positions. This entry is     *
//            zero if the field is not numeric.                  *
//   F1FTXT - Field text description                             *
//   F1EDTC - Edit code                                          *
//   F1EDWL - Edit word length                                   *
//   F1EDWD - Edit word                                          *
//   F1COL1 - Column heading 1                                   *
//   F1COL2 - Column heading 2                                   *
//   F1COL3 - Column heading 3                                   *
//   F1IFNM - Internal field name                                *
//   F1AFNM - Alternative field name                             *
//   F1AFNL - Length of alternative field name                   *
//   F1NDBC - Number of DBCS characters                          *
//   F1NALW - Null values allowed                                *
//            0=not allowed                                      *
//            1=allowed                                          *
//   F1HVRI - Host variable indicator                            *
//   F1DTFM - Date and time format                               *
//            (Only available for date, time and timestamp)      *
//            *USA=IBM USA standard                              *
//            *ISO=International standard organisation           *
//            *EUR=IBM European standard                         *
//            *JIS=Japanese industrial standard                  *
//            *SAA=SAA timestamp                                 *
//            *MDY=Month/day/year                                *
//            *DMY=Day/month/year                                *
//            *YMD=Year/month/day                                *
//            *JUL=Julian                                        *
//            *HMS=Hour/minute/second                            *
//   F1DTSP - Date and time separator                            *
//            (Only available for date, time and timestamp)      *
//            /  -  .  ,  :                                      *
//   F1VFMI - Variable length field indicator                    *
//            (overlay for MI mapping)                           *
//   F1FTCC - Field text description CCSID                       *
//            0=there is no fild text description                *
//   F1FDCC - Field data CCSID                                   *
//            0=there is no field data                           *
//   F1CHCC - Field column headings CCSID                        *
//            0=there are no field column headings               *
//   F1EWCC - Field edit words CCSID                             *
//            0=there are no field edit words                    *
//   F1VFLD - Internal field name for variable length fields     *
//   F1KEYF - Internal indicator for key fields                  *
//   F1SEQ  - Internal sequence number of field in record format *
//   F1UCS2 - UCS-2 Field                                        *
//                                                               *
//===============================================================*
//
//  list API format FLDL0100
dcl-ds fldl0100_t qualified template;
  f1fnme          char(10);
  f1dtyp          char(1);
  f1use           char(1);
  f1obuf          int(10);
  f1ibuf          int(10);
  f1flen          int(10);
  f1digt          int(10);
  f1decp          int(10);
  f1ftxt          char(50);
  f1edtc          char(2);
  f1edwl          int(10);
  f1edwd          char(64);
  f1col1          char(20);
  f1col2          char(20);
  f1col3          char(20);
  f1ifnm          char(10);
  f1afnm          char(30);
  f1afnl          int(10);
  f1ndbc          int(10);
  f1nalw          char(1);
  f1hvri          char(1);
  f1dtfm          char(4);
  f1dtsp          char(1);
  f1vfmi          char(1);
  f1ftcc          int(10);
  f1fdcc          int(10);
  f1chcc          int(10);
  f1ewcc          int(10);
  f1vfld          char(10) pos(513);
  f1keyf          char(2) pos(533);
  f1seq           int(10);
  f1ucs2          char(1);
end-ds;
//
