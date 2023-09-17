?     *                                                                                       RADDAT
?     *============================================================*                          RADDAT
?     *    ChkUsrSetg    Prüfen der Benutzervoreinstellungen       *                          RADDAT
?     *                  auf Aktualität                            *                          RADDAT
?     *============================================================*                          RADDAT
?     *                                                                                       RADDAT
     C     ChkUsrSetg    BEGSR                                                                RADDAT
?     *                                                                                       RADDAT
?     *  Ende der alten Daten                                                                 RADDAT
     C     x'8B'         SCAN      S_Data:1      X                                            RADDAT
 B01 C     X             IFEQ      *ZEROS                                                     RADDAT
     C     ' '           CHECKR    S_Data        X                                            RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   SUB       1             X                                            RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
?     *  Ende der neuen Daten                                                                 RADDAT
     C     x'8B'         SCAN      SET0000:1     Y                                            RADDAT
     C                   SUB       1             Y                                            RADDAT
?     *                                                                                       RADDAT
?     *  Aktualisieren, wenn die neuen Daten                                                  RADDAT
?     *  länger als die "Altdaten" sind ...                                                   RADDAT
 B01 C     Y             IFGT      X                                                          RADDAT
?     *  ... extrahieren alte Daten                                                           RADDAT
     C     X             SUBST (P) S_Data:1      S_Data                                       RADDAT
?     *  ... extrahieren überhang der neuen Daten                                             RADDAT
     C                   ADD       1             X                                            RADDAT
     C                   SUBST (P) SET0000:X     SET0000                                      RADDAT
?     *  ... zusammenfügen alt + neu                                                          RADDAT
     C                   MOVEA (P) S_Data        SET0000A                                     RADDAT
     C                   MOVEA     SET0000       SET0000A(X)                                  RADDAT
     C                   MOVEA (P) SET0000A      S_Data                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
?     *                                                                                       RADDAT
