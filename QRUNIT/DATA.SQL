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

