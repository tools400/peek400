     /* =================================================================== */
     /*   >>PRE-COMPILER<<                                                  */
     /*     >>CRTCMD<<  RUNSQLSTM     SRCFILE(&SL/&SF) SRCMBR(&SM) +        */
     /*                               COMMIT(*NONE) NAMING(*SQL) +          */
     /*                               DFTRDBCOL(&LI);                       */
     /*     >>EXECUTE<<                                                     */
     /*   >>END-PRE-COMPILER<<                                              */
     /* =================================================================== */

/* Table with all field types that Peek/400 supports, e.g. for testing   */
/* the update programs, the hex editor and the text editor. Each type is */
/* there with and without NULL values. BOOLEAN requires IBM i 7.5.       */
/* Unqualified names refer to the default schema DFTRDBCOL(&LI).         */

CREATE TABLE ALLTYPES (
  ID          INTEGER                              NOT NULL,
  BOOL        BOOLEAN                              DEFAULT NULL,
  BOOL_NN     BOOLEAN                              NOT NULL DEFAULT TRUE,
  ALPHA       CHAR(10)                             DEFAULT NULL,
  VARALPHA    VARCHAR(10)                          DEFAULT NULL,
  NOT_NULL    CHAR(10)                             NOT NULL DEFAULT '',
  UTF8        CHAR(20)          CCSID 1208         DEFAULT NULL,
  VARUTF8     VARCHAR(20)       CCSID 1208         DEFAULT NULL,
  "SMALLINT"  SMALLINT                             DEFAULT NULL,
  "INTEGER"   INTEGER                              DEFAULT NULL,
  "BIGINT"    BIGINT                               DEFAULT NULL,
  PACKED      DECIMAL(11, 2)                       DEFAULT NULL,
  ZONED       NUMERIC(11, 2)                       DEFAULT NULL,
  REAL        REAL                                 DEFAULT NULL,
  "DOUBLE"    DOUBLE PRECISION                     DEFAULT NULL,
  "DATE"      DATE                                 DEFAULT NULL,
  "TIME"      TIME                                 DEFAULT NULL,
  "TIMESTAMP" TIMESTAMP                            DEFAULT NULL,
  TS12        TIMESTAMP(12)                        DEFAULT NULL,
  UCS2_NN     GRAPHIC(128)      CCSID 13488        NOT NULL DEFAULT '',
  UCS2        GRAPHIC(128)      CCSID 13488        DEFAULT NULL,
  VARUCS2_NN  VARGRAPHIC(128)   CCSID 13488        NOT NULL DEFAULT '',
  VARUCS2     VARGRAPHIC(128)   CCSID 13488        DEFAULT NULL,
  UTF16_NN    GRAPHIC(128)      CCSID 1200         NOT NULL DEFAULT '',
  UTF16       GRAPHIC(128)      CCSID 1200         DEFAULT NULL,
  VARUTF16_N  VARGRAPHIC(128)   CCSID 1200         NOT NULL DEFAULT '',
  VARUTF16    VARGRAPHIC(128)   CCSID 1200         DEFAULT NULL,
  LONG_CHAR   CHAR(2000)                           DEFAULT NULL,
  PRIMARY KEY (ID));

LABEL ON TABLE ALLTYPES IS 'PEEK400 - All field types';

LABEL ON COLUMN ALLTYPES (
  ID          TEXT IS 'Record ID',
  BOOL        TEXT IS 'BOOLEAN',
  BOOL_NN     TEXT IS 'BOOLEAN NOT NULL',
  ALPHA       TEXT IS 'CHAR(10)',
  VARALPHA    TEXT IS 'VARCHAR(10)',
  NOT_NULL    TEXT IS 'CHAR(10) NOT NULL',
  UTF8        TEXT IS 'CHAR(20) CCSID 1208',
  VARUTF8     TEXT IS 'VARCHAR(20) CCSID 1208',
  "SMALLINT"  TEXT IS 'SMALLINT',
  "INTEGER"   TEXT IS 'INTEGER',
  "BIGINT"    TEXT IS 'BIGINT',
  PACKED      TEXT IS 'DECIMAL(11, 2)',
  ZONED       TEXT IS 'NUMERIC(11, 2)',
  REAL        TEXT IS 'REAL',
  "DOUBLE"    TEXT IS 'DOUBLE PRECISION',
  "DATE"      TEXT IS 'DATE',
  "TIME"      TEXT IS 'TIME',
  "TIMESTAMP" TEXT IS 'TIMESTAMP',
  TS12        TEXT IS 'TIMESTAMP(12)',
  UCS2_NN     TEXT IS 'GRAPHIC(128) CCSID 13488 NOT NULL',
  UCS2        TEXT IS 'GRAPHIC(128) CCSID 13488',
  VARUCS2_NN  TEXT IS 'VARGRAPHIC(128) CCSID 13488 NOT NULL',
  VARUCS2     TEXT IS 'VARGRAPHIC(128) CCSID 13488',
  UTF16_NN    TEXT IS 'GRAPHIC(128) CCSID 1200 NOT NULL',
  UTF16       TEXT IS 'GRAPHIC(128) CCSID 1200',
  VARUTF16_N  TEXT IS 'VARGRAPHIC(128) CCSID 1200 NOT NULL',
  VARUTF16    TEXT IS 'VARGRAPHIC(128) CCSID 1200',
  LONG_CHAR   TEXT IS 'CHAR(2000), longer than 1024');
