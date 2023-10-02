      *
      *============================================================*
      *    ChkUsrSetg    Prüfen der Benutzervoreinstellungen       *
      *                  auf Aktualität                            *
      *============================================================*
      *
     C     ChkUsrSetg    BEGSR
      *
      *  Ende der alten Daten
     C     x'8B'         SCAN      S_Data:1      X
     C     X             IFEQ      *ZEROS
     C     ' '           CHECKR    S_Data        X
     C                   ELSE
     C                   SUB       1             X
     C                   ENDIF
      *
      *  Ende der neuen Daten
     C     x'8B'         SCAN      SET0000:1     Y
     C                   SUB       1             Y
      *
      *  Aktualisieren, wenn die neuen Daten
      *  länger als die "Altdaten" sind ...
     C     Y             IFGT      X
      *  ... extrahieren alte Daten
     C     X             SUBST (P) S_Data:1      S_Data
      *  ... extrahieren überhang der neuen Daten
     C                   ADD       1             X
     C                   SUBST (P) SET0000:X     SET0000
      *  ... zusammenfügen alt + neu
     C                   MOVEA (P) S_Data        SET0000A
     C                   MOVEA     SET0000       SET0000A(X)
     C                   MOVEA (P) SET0000A      S_Data
     C                   ENDIF
      *
     C                   ENDSR
      *
