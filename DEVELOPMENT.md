# Peek/400 – Hinweise für Entwickler

Wie Peek/400 gebaut und getestet und wie ein Release erstellt wird. Zur Benutzung siehe
[README.md](README.md).

## Bauen

Peek/400 ist ein IFS-Projekt für TOBi (`makei`). `iproj.json` und die `Rules.mk` der Verzeichnisse
beschreiben alle Objekte, TOBi baut sie auf dem IBM i aus den Dateien des Projekts. Bearbeiten und
bauen lässt sich das Projekt z.B. mit VS Code (Code for IBM i) oder in RDi mit IFS Projects.

Zwei Umgebungsvariablen steuern den Build:

| Variable | Bedeutung |
|---|---|
| `PEEKLIB` | Zielbibliothek, zugleich aktuelle Bibliothek der Übersetzungsjobs, z.B. `PEEK412P`. Legen Sie sie vorher an. |
| `DBGVIEW` | Debug-Sicht der Module, für die Entwicklung `*LIST`. Ohne die Variable nimmt TOBi `*ALL`. |

Im Projektverzeichnis auf dem IBM i (`makei` liegt in `/QOpenSys/pkgs/bin`):

```sh
PEEKLIB=PEEK412P DBGVIEW='*LIST' makei build                              # alles bauen, was sich geändert hat
PEEKLIB=PEEK412P DBGVIEW='*LIST' makei compile -f qrpglesrc/peek05.rpgle   # eine Quelle übersetzen
```

Ob alles gebaut wurde, zeigt die Zusammenfassung am Ende (`Objects: … failed`). Die Meldungen der
Compiler stehen in `.evfevent/`, das Job-Log in `.logs/`.

## Tests

Die Regressionstests in `qrunit/` (iRPGUnit) baut TOBi nicht mit. Sie werden im Projektverzeichnis
übersetzt, weil die Copybooks relativ dazu eingebunden werden, mit der Peek-Bibliothek in der
Bibliotheksliste. Jede Testsuite läuft in einem eigenen Job:

```clle
RUCRTRPG TSTPGM(PEEK412P/PEEKSRVT) SRCSTMF('qrunit/peeksrvt.rpgle') BNDDIR(PEEK) DBGVIEW(*LIST) TGTCCSID(273)
RUCALLTST TSTPGM(PEEK412P/PEEKSRVT)
```

## Release erstellen

**Version erhöhen**, bevor das Produkt gebaut wird:

- `qrpglesrc/peek05.rpgle`: die Konstanten `COPYRIGHT`, `RELEASE` und `Version`
- `qrpglesrc/peek33.rpgle`: einen Schritt für die neue Version, der die Benutzereinstellungen
  aktualisiert, und `qrunit/peekpgmt.rpgle`: die Version in `test32_peek33_versionRaised`
- `qddssrc/peekusrdta.sql`: den Eintrag `*VERSION`
- `doc/whats_new.txt`: den Abschnitt der neuen Version
- `.project`: die Version im Namen des Projekts

**Produkt bauen** auf dem IBM i, im Projektverzeichnis:

```sh
tools/mkproduct.sh 4.1.2
```

Das Skript baut die Produktbibliothek `PEEK` ohne Debug-Sichten. Die Bibliothek darf noch nicht
existieren. Es legt die Quelldateien für die Kunden an (`QEXAMPLE`, `QCOPYLE`, `QMSG_*`, `QCMDSRC`),
setzt Eigentümer und Berechtigungen und löscht die erzeugten Update-Programme in der
Entwicklungsbibliothek `PEEK412P`. Zum Schluss sichert es `PEEK` und `PEEK412P` in die
Sicherungsdateien `PEEK412` und `PEEK412P` in der Bibliothek des angemeldeten Benutzers.
Voraussetzungen sind TOBi und der Befehl `CRTMSGDS` in der Bibliotheksliste. Die weiteren
Einstellungen (`PRODLIB`, `OWNER`, `SAVFLIB`) beschreibt der Kopf des Skripts.

**Veröffentlichen** auf dem PC: `.github/release.ps1` lädt die Sicherungsdateien vom IBM i und
veröffentlicht die Sicherungsdatei des Produkts zusammen mit den Handbüchern als Release auf
GitHub. Den Text des Releases nimmt das Skript aus `doc/whats_new.txt`. Seine Dateien legt das
Skript in `temp/` ab. Git ignoriert das Verzeichnis, die Sicherungsdateien landen also nicht im
Repository.

```powershell
.\.github\release.ps1 download -Version 4.1.2           # PEEK412 und PEEK412P per FTP vom IBM i holen
.\.github\release.ps1 publish  -Version 4.1.2 -WhatIf   # Probelauf: prüft alles, ändert nichts
.\.github\release.ps1 publish  -Version 4.1.2           # Tag v4.1.2 anlegen und pushen, Release erstellen
.\.github\release.ps1 update   -Version 4.1.2           # Handbücher und Text des Releases v4.1.2 aktualisieren
```

In der Eingabeaufforderung (`cmd.exe`) lauten die Aufrufe `.github\release download -Version 4.1.2`
usw. Dann startet `.github\release.cmd` das Skript mit PowerShell.

Ins Release geht nur `PEEK412`, die Entwicklungsbibliothek `PEEK412P` nicht. Weitere Parameter
zeigt `Get-Help .\.github\release.ps1 -Full`.

`update` ist für Korrekturen nach dem Release: Es ersetzt die Handbücher, die sich gegenüber dem
Release geändert haben, und den Text, wenn sich der Abschnitt in `doc/whats_new.txt` geändert hat.
Die Änderungen müssen committet und gepusht sein. Die Sicherungsdatei bleibt, wie sie ist; ein
geändertes Produkt braucht eine neue Version. Auch hier zeigt `-WhatIf` vorher, was sich ändern
würde. Mit `-Confirm` fragt das Skript vor jedem Schritt, so bleibt z.B. ein auf GitHub bearbeiteter
Text erhalten, wenn nur die Handbücher ersetzt werden sollen.

## Handbücher

Die Quellen der Handbücher sind die `.doc`-Dateien in `doc/`: `Peek400g.doc` (Deutsch) und
`Peek400e.doc` (Englisch). Die PDFs daneben gehören zum Release, siehe oben.
