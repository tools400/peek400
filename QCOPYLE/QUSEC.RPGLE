     D*** START HEADER FILE SPECIFICATIONS ****************************
     D*
     D*Header File Name: H/QUSEC
     D*
     D*Descriptive Name: Error Code Parameter.
     D*
     D*5763-SS1  (C) Copyright IBM Corp. 1994,1994
     D*All rights reserved.
     D*US Government Users Restricted Rights -
     D*Use, duplication or disclosure restricted
     D*by GSA ADP Schedule Contract with IBM Corp.
     D*
     D*Licensed Materials-Property of IBM
     D*
     D*
     D*Description: Include header file for the error code parameter.
     D*
     D*Header Files Included: None.
     D*
     D*Macros List: None.
     D*
     D*Structure List: Qus_EC_t
     D*
     D*Function Prototype List: None.
     D*
     D*Change Activity:
     D*
     D*CFD List:
     D*
     D*FLAG REASON       LEVEL DATE   PGMR      CHANGE DESCRIPTION
     D*---- ------------ ----- ------ --------- ----------------------
     D*$A0= D2862000     3D10  931201 DPOHLSON: New Include
     D*
     D*End CFD List.
     D*
     D*Additional notes about the Change Activity
     D*End Change Activity.
     D*** END HEADER FILE SPECIFICATIONS ******************************
     D*****************************************************************
     D*Record structure for Error Code Parameter
     D****                                                          ***
     D*NOTE: The following type definition only defines the fixed
     D*   portion of the format.  Verying length field Exception
     D*   Data will not be defined here.
     D*****************************************************************
     DQUSEC            DS
     D*                                             Qus EC
     D QUSBPRV                 1      4I 0          inz(256)
     D*                                             Bytes Provided
     D QUSBAVL                 5      8I 0
     D*                                             Bytes Available
     D QUSEI                   9     15
     D*                                             Exception Id
     D QUSERVED               16     16
     D*                                             Reserved
     D QUSED01                17    256
     D*
     D*                                      Varying length
