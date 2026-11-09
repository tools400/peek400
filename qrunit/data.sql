      --%METADATA                                                      *
      -- %TEXT Insert Data SQL Script                                  *
      --%EMETADATA                                                     *
     /* =================================================================== */
     /*   >>PRE-COMPILER<<                                                  */
     /*     >>CRTCMD<<  RUNSQLSTM     SRCFILE(&SL/&SF) SRCMBR(&SM) +        */
     /*                               COMMIT(*NONE) NAMING(*SQL) +          */
     /*                               DFTRDBCOL(&LI);                       */
     /*     >>EXECUTE<<                                                     */
     /*   >>END-PRE-COMPILER<<                                              */
     /* =================================================================== */

/* Unqualified names refer to the default schema DFTRDBCOL(&LI), which */
/* is the library passed to STRPREPRC LIB(), e.g. by CRTDB.            */

/* HCUSTOMER: */

CREATE OR REPLACE ALIAS Y2018 FOR "HCUSTOMER" (Y2018);
INSERT INTO Y2018 (CUSTNBR,NAME,STREET,ZIPCODE,CITY,COUNTRY)
  VALUES (1 ,'Dagobert Duck','Rich People Boulevard','1313','Duckburg',
          'America');
DROP ALIAS Y2018;

CREATE OR REPLACE ALIAS Y2017 FOR "HCUSTOMER" (Y2017);
INSERT INTO Y2017 (CUSTNBR,NAME,STREET,ZIPCODE,CITY,COUNTRY)
  VALUES (47 ,'Dagobert Duck','Rich People Road','1313','Duckburg',
          'America');
DROP ALIAS Y2017;

/* HORDER: */

CREATE OR REPLACE ALIAS Y2018 FOR "HORDER" (Y2018);
INSERT INTO Y2018 (ORDNBR,CUSTNBR,COMMENTS,ORDCRTD,ORDCRTT)
  VALUES (1 , 1 ,'My first oder in 2018','2018-05-25','15:30:25');
DROP ALIAS Y2018;

CREATE OR REPLACE ALIAS Y2017 FOR "HORDER" (Y2017);
INSERT INTO Y2017 (ORDNBR,CUSTNBR,COMMENTS,ORDCRTD,ORDCRTT)
  VALUES (1 , 47 ,'My first order in 2017','2017-03-15','09:55:47');
DROP ALIAS Y2017;

/* IITEM: */

CREATE OR REPLACE ALIAS Y2018 FOR "HITEM" (Y2018);
INSERT INTO Y2018 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 10 ,'201805', 9.99 , 7);
INSERT INTO Y2018 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 20 ,'201807', 19.99 , 1);
INSERT INTO Y2018 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 30 ,'201809', 10.50 , 1);
DROP ALIAS Y2018;

CREATE OR REPLACE ALIAS Y2017 FOR "HITEM" (Y2017);
INSERT INTO Y2017 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 10 ,'201805', 9.99 , 7);
INSERT INTO Y2017 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 20 ,'201807', 19.99 , 1);
INSERT INTO Y2017 (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 30 ,'201809', 10.50 , 1);
DROP ALIAS Y2017;

/* CUSTOMER: */

INSERT INTO CUSTOMER (CUSTNBR,NAME,STREET,ZIPCODE,CITY,COUNTRY)
  VALUES (1 ,'Donald Duck','Wet Foot Road 1','1313','Duckburg',
          'America');

/* ORDER: */

INSERT INTO "ORDER" (ORDNBR,CUSTNBR,COMMENTS,ORDCRTD,ORDCRTT)
  VALUES (1 , 1 ,'MY FIRST ORDER.','2019-08-25','18:54:00');

/* ITEM: */

INSERT INTO ITEM (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 10 ,'100100', 15.49 , 5);
INSERT INTO ITEM (ORDNBR,ITMSQN,ITMNBR,PRICE,QTYORD)
  VALUES (1 , 20 ,'100101', 5.10 , 3);

/* ALLTYPES: */
/* Characters outside of ASCII are given as UTF-16 (UX'...'), so that   */
/* this script does not depend on the CCSID of the source file.          */

/* 1: Only the key, all NULL-capable fields are NULL. */
INSERT INTO ALLTYPES (ID) VALUES (1);

/* 2: All fields with typical values. */
INSERT INTO ALLTYPES (ID, BOOL, BOOL_NN, ALPHA, VARALPHA, NOT_NULL,
                      UTF8, VARUTF8, "SMALLINT", "INTEGER", "BIGINT",
                      PACKED, ZONED, REAL, "DOUBLE",
                      "DATE", "TIME", "TIMESTAMP", TS12,
                      UCS2_NN, UCS2, VARUCS2_NN, VARUCS2,
                      UTF16_NN, UTF16, VARUTF16_N, VARUTF16, LONG_CHAR)
  VALUES (2, TRUE, FALSE, 'Alpha', 'Varchar', 'Not null',
          'UTF-8', 'Varchar UTF-8', 12345, 1234567890,
          1234567890123456789,
          123456789.12, -123456789.12, 1.5E-5, -1.234567890123E+100,
          '2026-11-06', '20:35:00', '2026-11-06-20.35.00.123456',
          '2026-11-06-20.35.00.123456789012',
          'UCS-2 not null', 'UCS-2', 'Vargraphic UCS-2 not null',
          'Vargraphic UCS-2',
          'UTF-16 not null', 'UTF-16', 'Vargraphic UTF-16 not null',
          'Vargraphic UTF-16',
          'Start of the long field' || REPEAT(' ', 1001) ||
          'Behind position 1024' || REPEAT(' ', 935) ||
          'End of the field');

/* 3: Umlauts, characters that the job CCSID cannot display (Chinese,  */
/*    emoji in UTF-16), empty fields of variable length and the lowest  */
/*    values.                                                           */
INSERT INTO ALLTYPES (ID, BOOL, BOOL_NN, ALPHA, VARALPHA, NOT_NULL,
                      UTF8, VARUTF8, "SMALLINT", "INTEGER", "BIGINT",
                      PACKED, ZONED, REAL, "DOUBLE",
                      "DATE", "TIME", "TIMESTAMP", TS12,
                      UCS2_NN, UCS2, VARUCS2_NN, VARUCS2,
                      UTF16_NN, UTF16, VARUTF16_N, VARUTF16, LONG_CHAR)
  VALUES (3, FALSE, TRUE,
          /* Umlauts A, O, U, a, o, u and sharp s */
          UX'00C400D600DC00E400F600FC00DF',
          '', '',
          /* 'Gruesse' with u umlaut and sharp s, two Chinese characters */
          UX'0047007200FC00DF006500206C495B57',
          '',
          -32768, -2147483648, -9223372036854775808,
          -999999999.99, 0, 0, 0,
          '0001-01-01', '00:00:00', '0001-01-01-00.00.00.000000',
          '0001-01-01-00.00.00.000000000000',
          /* Umlauts A, O, U and two Chinese characters */
          UX'00C400D600DC00206C495B57', UX'00C400D600DC00206C495B57',
          '', '',
          /* Umlauts A, O, U, two Chinese characters and an emoji */
          UX'00C400D600DC00206C495B570020D83DDE00',
          UX'00C400D600DC00206C495B570020D83DDE00',
          '', '',
          '');

