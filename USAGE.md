# Peek/400 – Verwendung

Wie Sie mit Peek/400 arbeiten: der Aufruf, die wichtigsten Tasten und Auswahlen und die
Anpassungen. Wozu Peek/400 dient und wie Sie es installieren, steht in [README.md](README.md).
Alle Einzelheiten beschreibt das Benutzerhandbuch auf [Deutsch](doc/Peek400g.pdf) und
[Englisch](doc/Peek400e.pdf), die Parameter der Befehle `PEEK` und `TREE` erklärt ihre Hilfe
(Bedienerführung mit F4, dann F1).

## Schnellstart

```clle
PEEK FILE(MYLIB/MYFILE)
```

Die wichtigsten Parameter:

| Parameter | Bedeutung |
|---|---|
| `FILE`, `MEMBER` | Datei und Teildatei |
| `ACCESS` | Zugriffsart: `*KEY` (Schlüsselfolge), `*RRN` (Satzfolge) oder `*SQL` |
| `WHERE`, `ORDERBY` | SQL-Auswahl und -Sortierung |
| `LANGUAGE` | Sprache der Bildschirme, z.B. `GER` oder `ENG` |
| `ALWCHGLIB`, `ALWCHGFILE`, `ALWCHGMBR`, `ALWCHGRCD` | Wechsel von Bibliothek, Datei und Teildatei bzw. Ändern der Datensätze erlauben |
| `ENVFILE`, `ENVMBR`, `ENVSAVE` | Arbeitsumgebung laden und beim Verlassen speichern |

Der erste Aufruf in einem Job dauert etwas länger, weil Peek/400 einmalig Vorbereitungen in
`QTEMP` trifft.

Standardbelegung der wichtigsten Tasten und Auswahlen:

| Taste | Funktion | Auswahl | Funktion |
|---|---|---|---|
| F1 | SQL-Auswahl | 2 | Ändern |
| F2 | Spalten pinnen | 3 | Kopieren |
| F3 | Beenden | 4 | Löschen |
| F5 | Aktualisieren | 5 | Anzeigen |
| F6 | Datensatz einfügen | 6 | Drucken |
| F9 | Datenbankrelationen | 9 | In externe Datei kopieren |
| F11 | Layout | P / U | Zeile pinnen / lösen |
| F16 | Suchen | S | Sortierung umschalten |
| F17 / F18 | Dateianfang / Dateiende | H | Hex-Anzeige umschalten |
| F23 / F24 | Weitere Auswahlen / Tasten | RB | Update-Programm neu erstellen |

Im Bildschirm „Datensatz ändern“ öffnet F9 den Hex-Editor und F10 den Text-Editor für das Feld
unter dem Cursor.

## Anpassen

- **Funktionstasten und Auswahlen:** Die Belegung ist pro Benutzer in einer Datei mit dem Namen des
  Benutzerprofils in der Programmbibliothek gespeichert. Neue Benutzer erhalten eine Kopie von
  `PEEKUSR`. Wenn Sie `PEEKUSR` ändern, ändern Sie damit die Standardbelegung für neue Benutzer.
- **Kurzbefehle:** Einträge der Section `*CMD`, z.B. `FD` → `DSPFD FILE(&L/&F)`. Peek/400 ersetzt
  `&L`, `&F` und `&N` durch Bibliothek, Datei und Teildatei, `&R` durch die Satznummer und
  `%Feldname` durch den Feldinhalt des aktuellen Datensatzes.
- **Eigene Sprache:** Die Nachrichtendatei `PEEKGER` kopieren, die Texte übersetzen und Peek/400 mit
  `LANGUAGE(...)` starten.
- **Exit-Programme:** Die Quellen von `EXIT01` und `EXIT06` liegen in `QEXAMPLE` und können
  angepasst werden.
