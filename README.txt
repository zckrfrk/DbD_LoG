## README ZUR VERSION 4.0.1 - Bugfixes + kleine Änderungen zum SÜNDHAFT-GROẞEN-UPDATE ##

HUHW zu meinem Tool, mit welchem man sich für Dead by Daylight zufällig Charaktere, Perks, Items, Addons und Opfergaben auswählen kann. Viel Spaß damit!
Es ist lange noch nicht perfekt, deshalb bitte ich, mir Auffälligkeiten (Fehler, Probleme, Vorschläge und Verbesserungsvorschläge) gerne auf Discord oder via Mail mitzuteilen: zckrfrk.business@t-online.de. Vielen Dank!

Zum Starten des Tools musst du nur im entpackten Ordner die BAT-Datei doppelklicken: "DBD Loadout Generator - SurvCore Editon.bat".

Um eine Verknüpfung auf dem Desktop zu erstellen, kannst du auf die jeweilige Batch-Datei ("DBD Loadout Generator - SurvCore Editon.bat") rechtsklicken und Senden An > Desktop (Verknüpfung erstellen) auswählen.

Bei Verwendung des Tools gerne meinen Namen "@zckrfrk" erwähnen/angeben, ich freue mich immer! :DD

Weitere Links:
Link zu Git: https://github.com/zockerfreak/DeadByDaylight_Randomizer-SurvCoreEdition
Discord: https://discord.gg/xSXKYzK
Youtube: https://www.youtube.com/@zckrfrk
Streams: https://zfstream.de

Danke, dass du mein Tool nutzt!

Beste Grüße,
Mari aka Zckrfrk

►► ERKLÄRUNG DES TOOLS ◄◄
Da das Tool auf den ersten Blick eventuell etwas erschlagend aussehen könnte, gebe ich hiermit eine kleine Anleitung zum Besten, in dem ich auf jedes Element des Tools genauer eingehe.
► Tool als Fenster: Beim Öffnen der .BAT-Datei öffnen sich zwei Fenster (eines mit einem schwarzen Logo und eines mit einem blauen Logo). Das mit dem schwarzen Logo ist für das automatische Öffnen des anderen Fensters da und kann ignoriert werden. Um das Fenster des Tools aufzurufen, wenn es schon per .BAT-Datei geöffnet wurde, ist das Fenster mit dem blauen Logo (Powershell) notwendig. Wenn das Tool (Fenster mit blauem Logo) geschlossen wird, dann schließt sich das andere Fenster (schwarzes Logo) gleich mit.
► Role: Im Dropdown-Menü kann man zwischen Survivor und Killer auswählen. Klickt man auf das Dropdown-Fenster und dann auf die jeweilig andere Rolle, ändern sich die Optionen der Rolle.
► Language: Hier kann die Sprache für die Augabe angepasst werden. Spielst du DbD auf Englisch? - Dann wähle "English" aus, spielst du es auf Deutsch, dann natürlich "Deutsch".
► Save Config: Dieser Button speichert die aktuelle Sprache, die aktuelle Rolle als Startrolle des Tools und die aktuellen Optionen der jeweiligen Rolle ("Survivor Options" bzw. "Killer Options")
► Survivor Options: In diesem Bereich kannst du anhaken, was du für deinen Survivor generieren möchtest. Nur sichtbar, wenn der Mode auf "Survivor" steht.
► Killer Options: In diesem Bereich kannst du anhaken, was du für deinen Killer generieren möchtest. Nur sichtbar, wenn der Mode auf "Killer" steht.
► Survivor: Diese Checkbox sorgt dafür, dass angehakt auch ein Survivor-Name generiert wird.
► Killer: Diese Checkbox sorgt dafür, dass angehakt auch ein Killer-Name generiert wird.
► Perks: Diese Checkbox sorgt dafür, dass angehakt auch vier Perks für die jeweilig aktive Rolle generiert wird.
► Item: Diese Checkbox sorgt dafür, dass angehakt auch ein Item für deinen Survivor generiert wird.
► Add-ons: Diese Checkbox sorgt dafür, dass angehakt auch Add-ons für das Item für deinen Survivor generiert wird.
► Addon-Farben: Diese Checkbox sorgt dafür, dass angehakt eine Addon-Kombination aus zwei Farben für deinen Killer generiert wird. Dies ist vor allem in Turnier-Kontexten angebracht, damit nicht zu starke Addons genutzt werden.
► Offering: Diese Checkbox sorgt dafür, dass angehakt eine Opfergabe für die jeweilig aktive Rolle generiert wird.
► GO: Dieser Button generiert ein Loadout, abhängig von der im Mode angegebenen Rolle, den in den Options (Survivor Options oder Killer Options) angehakten Checkboxen und der in Language angegebenen Sprache.
► switch: Dieser Button kann verwendet werden, wenn du ein Loadout generiert hast, dies aber in der jeweils anderen Sprache angezeigt haben möchtest.
► both: Dieser Button kann verwendet werden, wenn du ein Loadout generiert hast, dies aber zusätzlich zu der momentan ausgewählten Sprache noch in der jeweils anderen Sprache angezeigt haben möchtest.
► COPY: Dieser Button speichert dein generiertes Loadout in der Zwischenablage, sodass du es z.B. in einem Chat oder einer manuell einfügen kannst.
► EXPORT: Dieser Button speichert dein generiertes Loadout in der TXT-Datei "export", welche sich im gleichen Ordner, wie die .BAT-Datei befindet.
► CLEAR: Dieser Button entfernt dein generiertes Loadout aus dem Ausgabefenster des Tool und leert die TXT-Datei "export" vollständig.
► OBS-Einbindung: Das Tool kann in OBS (und ähnliche Softwares) eingebunden werden. Dies geschieht mithilfe der TXT-Datei "export". In OBS angekommen kannst du über das Plus (+) eine neue "Text (GDI+)" Quelle hinzufügen, z.B. mit dem Namen "export". In den Eigenschaften der OBS-Quelle musst du nun den Haken "Aus Datei lesen" setzen und mithilfe des Buttons "Durchsuchen" in den Pfad des Skripts navigieren und die TXT-Datei "export" auswählen. Du kannst nun weiter in den Einstellungen herumprobieren, wie du die TXT-Datei eingeblendet haben willst. Ich empfehle folgende Einstellungen: 1. Schriftgröße 60 | 2. Vertikale Ausrichtung: Unten | 3. Benutzerdefinierten Textbereich benutzen: anhaken (Breite: 1920, Höhe 1080) | 4. Zeilenumbruch: anhaken. Zudem kann der OBS-Quelle noch ein Hotkey hinterlegt werden (Einstellungen > Hotkeys). Jedoch kann auch mit dem CLEAR-Button in meinem Tool gearbeitet werden, dann wird das Loadout auch nicht mehr angezeigt, bis das nächste generiert wird.
► Bei weiteren Fragen kontaktiert mich gerne über die oben stehenden Links!


# CHANGELOG #
Zur leichteren Lesbarkeit wird das de oder en vor dem Dateinamen hier im Changelog weggelassen.

#########################
### aktuelle Version: ###
#########################

 ─────────────────────────────────────────────────────┐
  VERSION 4.0.1 - Bugfixes + kleine Änderungen zum SÜNDHAFT-GROẞEN-UPDATE  
└─────────────────────────────────────────────────────

→ SurvCore Editon Version 4.0.1 - Update vom 13.09.2026 - DbD Version 10.1.2 ←

1. Bugfixes
• Problem behoben, bei dem die "Offering" Checkbox bei "Survivor" gefehlt hatte, wenn von "Surv" auf Killer und dann wieder zurück gewechselt wurde
• Problem behoben, bei dem die Language automatisch zu "Deutsch" gesprungen ist, wenn Language "English" ausgewählt war und Role geändert wurde

2. Änderungen
• Checkbox "Addon-Farben" in "Addon-Colours" umbenannt
• "Mode" in "Role" umbenannt (sowohl in der GUI als auch im Skript)
• alle "Anführungsstriche" aus der CSV-Datei "items_Survivors" entfernt (wurden zuvor ebenso in der Ausgabe der GUI angezeigt)
• Erklärung des Tools im README angepasst: Mode → Role / Inhalt des Punktes "Save Config" / fehlenden Punkt "Killer" hinzugefügt

3. Neue Funktionalität
• Feature hinzugefügt, dass nun auch die zuletzt verwendete Rolle in der Config mitgespeichert wird (sodass Killer-Mains nicht immer von der Surv-Rolle wechseln müssen beim Start des Tools)


############################
### ehemalige Versionen: ###
############################


# VERSION 4.0 - SÜNDHAFT-GROẞES-UPDATE #

SurvCore Editon Version 4.0 - Update vom 27.08.2026 - DbD Version 10.1.0

1. Skripte für Survivor und Killer zusammengelegt und mit vielerlei neuen Features versehen:
• Nun können Killer- und Surv-Loadouts innerhalb eines Tools generiert werden
• Möglichkeit eingebaut, anzuhaken, was generiert werden soll
• Smarter Sprachenwechsel & Anzeige des generierten Loadouts in zwei Sprachen gleichzeitig
• Möglichkeit eingebaut, generiertes Loadout direkt in OBS anzuzeigen (per TXT-File)
• Neue Buttons hinzugefügt: Save Config, switch, both, EXPORT, CLEAR
• "Generieren"-Button wurde zum "GO"-Button
• weitere Updates, um das Tool mit weiteren Funktionen zu füttern und umfangreicher zu gestalten
• meinen Namen in der UI-Überschrift hinzugefügt

2. Neue Perknamen und Charaktere hinzugefügt:
◘ Das Urteil / The Judgment
• perks_Killer: Verheeren ↔ Lay Waste; Fluch: Unter deiner Knute ↔ Hex: Under your Thumb; Himmlischer Zeuge ↔ Celestial Witness
◘ Aurora Stardotter
• perks_Survivors: Ruf der Erlösung ↔ Salvation's Cry; Segen: Standhaft ↔ Boon: Steadfast; Früchte deiner Arbeit ↔ Fruits of your Labor

3. Neue Perknamen (in Klammern) ergänzt von entfernten Charakteren:
◘ Laurie Strode
• de_perks_Survivors: Einziger Überlebender → Einziger Überlebender (Bis zum Letzen)
• de_perks_Survivors: Entscheidungsschlag → Entscheidungsschlag (Lebenswille)
• de_perks_Survivors: Objekt der Besessenheit → Objekt der Besessenheit (Von Besessenheit angetrieben)
• en_perks_Survivors: Sole Survivor → Sole Survivor (Down to the Last)
• en_perks_Survivors: Decisive Strike → Decisive Strike (Will to Live)
• en_perks_Survivors: Object of Obsession → 
Object of Obsession (Bound by Obsession)
◘ Pinhead
• de_perks_Killer: Sackgasse → Sackgasse (Schonungslos)
• de_perks_Killer: Fluch: Spielzeug → Fluch: Spielzeug (Fluch: Opfer des Schicksals)
• de_perks_Killer: Geißelhaken: Gabe des Schmerzes → Geißelhaken: Gabe des Schmerzes (Geißelhaken: Nässende Wunden)
• en_perks_Killer: Deadlock → Deadlock (No Holds Barred)
• en_perks_Killer: Hex: Plaything → Hex: Plaything (Hex: Fortune's Fool)
• en_perks_Killer: Scourge Hook: Gift of Pain → Scourge Hook: Gift of Pain (Scourge Hook: Weeping Wounds)
◘ Michael Myers
• de_perks_Killer: Erlöschendes Licht → Erlöschendes Licht (Die Schwachen erlegen)
• de_perks_Killer: Das Beste kommt zum Schluss → Das Beste kommt zum Schluss (Lass sie warten)
• de_perks_Killer: Spiele mit deinem Essen → Spiele mit deinem Essen (Sieh sie laufen)
• en_perks_Killer: Dying Light → Dying Light (Cull the Weak)
• en_perks_Killer: Save the best for last → Save the best for last (Keep Them Waiting)
• en_perks_Killer: Play with your food → Play with your food (See How They Run)

4. CSV-Dateien in neuem Ordner "data" zusammengelegt, entschlackt (weniger CSVs) und mit de_ID, de_Name, en_Name & en_ID versehen:
• de_addonsColours_Killer + en_addonsColours_Killer → addonsColours_Killer
• de_chars_Killer + en_chars_Killer → chars_Killer
• de_chars_Survivors + en_chars_Survivors → chars_Survivors
• de_items_Survivors + en_items_Survivors → items_Survivors
• de_offerings_Killer + en_offerings_Killer → offerings_Killer
• de_offerings_Survivors + en_offerings_Survivors → offerings_Survivors
• de_perks_Killer + en_perks_Killer → perks_Killer
• de_perks_Survivors + en_perks_Survivors → perks_Survivors
• Alte Ordner "de" und "en" für Survivor wurden gelöscht.

5. Fehler behoben:
• en_chars_Survivors: Èlodie Rakoto → Élodie Rakoto	
• en_itemCategory_FL_Survivors: Anniversary → Anniversary Flashlight
• en_itemCategory_M_Survivors: Bloodsense → Bloodsense Map
• de_offerings_Survivors: Versteindertes Eichenholz → Versteinertes Eichenholz
• de_perks_Killer: Sackgaße → Sackgasse
• de_perks_Killer: Pop Gös the Weasel → Pop Goes the Weasel
• de_perks_Killer: Haß → Hass
• de_perks_Killer: Geißelhaken: Gezackter Kompaß → Geißelhaken: Gezackter Kompass
• chars_Survivors: Yui kimura → Yui Kimura


# VERSION 3.0 - KILLER-UPDATE #

SurvCore Editon Version 3.0 - Update vom 22.07.2026 - DbD Version 10.0.3 (ebenso wie Version 2.5)

1. DATEIEN
	1.1 Killer-Ordner "KillerEdition" für das Loadout für Killer
		1.1.1 Unterordner: de_Killer / en_Killer
			1.1.1.1 Dateien: _addonsColours_Killer / _chars_Killer / _offerings_Killer / _perks_Killer
		1.1.2 weitere Dateien: DBD Loadout Generator - KillerEditon.bat / language_Killer / skript_Killer (mir war wichtig, dass keine zwei Dateien gleich heißen, um Redundanzen zu vermeiden)
	1.2 README mit #RautenUmrahmten# Überschriften versehen (aktuelle Version & ehemalige Versionen) und aktuelle Version wird schön eingerahmt + Erklärung am Anfang vom README mit der Killer-Batch-Datei erweitert
	
2. SKRIPT
	2.1 Skript "skript" im Oberordner ist weiterhin das Skript für das Survivor-Loadout und wird vom Namen her nicht verändert
		2.1.1 Überschrift vom Fenster wurde angepasst [Z11: $form.Text = "DBD Loadout Generator - Survivor"]

	2.2 Skript im Unterordner wurde "skript_Killer" genannt
		2.2.1 Überschrift vom Fenster wurde angepasst [Z11: $form.Text = "DBD Loadout Generator - Killer"]
		2.2.2 Killer Skript anhand Surv Skript händisch angepasst, Variablen verändert, Item-Section entfernt und erfolgreich getestet

# VERSION 2.5 - SHANE-UPDATE #
SurvCore Editon Version 2.5 - Update vom 22.07.2026 - DbD Version 10.0.3

1. DATEIEN
	1.1 Neue Perknamen von neuem Surv in _perks_Survivors  mit aufgenommen
		1.1.1 Shane Wiigwaas (Kreuzverhör / Vollgas / Zur Hand gehen || Cross-Examination / Wide Open Throttle / Lend a Hand)
	1.2 Neuen Char mit aufgenommen
		• [53] _chars_Survivors (+ Shane Wiigwaas)
	1.3 Neue Items vom 10-jährigen-Jubiläums-Event hinzugefügt (je eines)
		• [7] _itemCategory_FL_Survivors
		• [8] _itemCategory_MK_Survivors
		• [10] _itemCategory_TB_Survivors


# VERSION 2.4 - KWON-UPDATE #
SurvCore Editon Version 2.4 - Update vom 12.05.2026 - DbD Version 9.6.2

1. DATEIEN
	1.1 Neue Perknamen von neuen Survs in _perks_Survivors  mit aufgenommen
		1.1.1 Vee Boonyasak (Eins, Zwei, Drei, Vier! / Geisternoten / Leben auf Tour || die englischen Perk-Namen waren schon aufgenommen)
		1.1.2 Dustin Henderson (Bada Bada Bumm / Planänderung / Teamwork: Volle Runde || Bada Bada Bumm / Change of Plan / Teamwork: Full Circuit)
		1.1.3 Elf (Teamwork: Sanfte Töne / Wir sehen dich / Übersinnliche Wahrnehmung || Teamwork: Soft-Spoken / We See You / Extrasensory Perception)
		1.1.4 Kwon Tae-Young (Ein Platz für uns / Fünf Züge voraus / Im Flow || A Place For Us / Five Moves Ahead / Flow State)
	1.2 Neue Chars mit aufgenommen
		• [52] _chars_Survivors (+ Vee Boonyasak + Dustin Henderson + Elf bzw. Eleven + Kwon Tae-Young)
	1.3 Namen angepasst und/oder Reihenfolge an die Reihenfolge in DbD angepasst und/oder die letzte Zeile entfernt
		• [170] _perks_Survivors 
		• [14] _addons_FL_Survivors (+ Defekte Glühbirne bzw. engl. Äquivalent)
		• [5] _addons_FV_Survivors
		• [6] _addons_K_Survivors (- Abgegriffenes Abzeichen)
		• [5] _addons_M_Survivors
		• [14] _addons_MK_Survivors (+ Veredeltes Serum bzw. engl. Äquivalent)
		• [11] _addons_TB_Survivors
		• [6] _itemCategory_FL_Survivors (+ Geburtstags-Taschenlampe + Irrlicht bzw. engl. Äquivalent)
		• [3] _itemCategory_FV_Survivors 
		• [3] _itemCategory_K_Survivors
		• [4] _itemCategory_M_Survivors (+ Blutsinn-Karte bzw. engl. Äquivalent & Fehlerbehebung "Crypric Map" → "Cryptic Map")
		• [7] _itemCategory_MK_Survivors (+ Notfall-Sani-Kasten + Halloween-Brotdose + Geburtstag-Sani-Kasten bzw. engl. Äquivalent)
		• [9] _itemCategory_TB_Survivors (+ Festliche Werkzeugkiste + Geburtstags-Werkzeugkiste bzw. engl. Äquivalent)
		• [3] _itemCategory_X_Survivors (+ Chinesische Böller + Partykracher zum dritten Geburtstag bzw. engl. Äquivalent)
		• [35] _items_Survivors (noch fehlende ergänzt)
		• [43] _offerings_Survivors (- Blutpunkte-Offerings + VIP-Armband bzw. engl. Äquivalent)
		

# VERSION 2.3 - VEE-UPDATE #
SurvCore Editon Version 2.3 - Update vom 27.09.2025 - DbD Version 9.2.0

1. DATEIEN
	1.1 Neue Perknamen von Vee wurden mit aufgenommen (Leben auf Tour / Eins, Zwei, Drei, Vier! / Geisternoten bzw. Road Life / One-Two-Three-Four! / Ghost Notes)
	1.2 Anpassungen vorgenommen
		• fehlerhaftes Offering (Waffen der Yamaoka-Familie → "Wappen der Yamaoka-Familie)
		• fehlerhafte EN-Perknamen (Detectives Hunch → Detective's Hunch / Well Make It → We'll Make It / Were Gonna Live Forever → We're Gonna Live Forever)

2. SKRIPT
	2.1 Kopfzeile entfernt und im Changelog mit aufgenommen (hier werden nun DbD Version und Updatedatum genannt)

3. BATCHDATEI
	3.1 Batchdatei umbenannt und Versionierung entfernt

4. CHANGELOG
	4.1 Anleitung überarbeitet und bei den zukünftigen Ideen den Satz mit Git entfernt
	4.2 Git Link mit aufgenommen


# VERSION 2.2 - BATCH-PATCH #
SurvCore Editon Version 2.2 - Update vom 15.09.2025 - DbD Version 9.1.3 

• VBS Datei entfernt und stattdesssen eine Windows-Batchdatei erstellt, damit keine dubiosen Virus-Meldungen mehr auftreten.
• Skript-Header & README angepasst


# VERSION 2.1 #

1. GUI & SKRIPT
	1.1 Anpassung der Anordnung der Buttons
	1.2 Hinzufügen eines COPY-Buttons

2. DATEIEN
	2.1 Anpassen fehlerhafter Werte in CSV-Dateien (Umlaute)


# VERSION 2.0 #

1. FOG VIALS / NEBELFLÄSCHCHEN
	1.1 CSVs erstellt und befüllt:
		• _itemCategory_FV_Survivors
		• _addons_FV_Survivors
	1.2. Item-CSVs (_items_Survivors) angepasst:
		• Fog Vial Items hinzugefügt

2. MAPS / KARTEN
	2.1 Item-CSVs (_items_Survivors) angepasst
		○ DE
			• Regenbogenkarte → Kommentierte Karte
			• Karte → Gekritzelte Karte
			• Geheimnisvolle Karte hinzugefügt
		○ EN
			• Rainbow Map → Annotated Map
			• Map → Scribbled Map
			• Crypric Map hinzugefügt
	2.2 ItemCategory-CSVs angepasst (_itemCategory_M_Survivors) und die alten durch die neuen Item-Namen ersetzt
	2.3 ItemAddons-CSVs angepast (_addons_M_Survivors) und die alten durch die neuen Item-Namen ersetzt

3. MAPS / KARTEN
	3.1 Item-CSVs (_items_Survivors) und ItemCategory-CSVs (_itemCategory_K_Survivors) mussten NICHT angepasst werden
	3.2 ItemAddons-CSVs angepast (_addons_K_Survivors) und die alten durch die neuen Item-Namen ersetzt

4. PERKS
	4.1 Perk-CSVs (_perks_Survivors) vervollständigt auf 158 Perks und einzelne Anpassungen vorgenommen

5. SURVIVOR
	5.1 _chars_Survivors angepasst und die beiden Grimes Survs hinzugefügt

6. DATEIEN
	6.1 Alle Dateien in DE und EN wurden nochmal als "CSV UTF-8" anstatt als "CSV" gespeichert

7. SCRIPT-ANPASSUNGEN
	7.1 Allgemeine Änderungen
		• Versionierung & Branding hinzugefügt
		• Neue Kopfzeile mit Titel, Edition, Versionsnummer und Datum
		• Hinweis auf DbD-Version zur besseren Kompatibilitätsnachverfolgung
	7.2 Item-Erkennung & Add-on-System
		• Neuer Itemtyp hinzugefügt: "Nebel|Fog" wird nun als "FV" erkannt
		• Damit verbunden: neue Add-on-Datei ${prefix}_addons_FV_Survivors.csv wird geladen, falls vorhanden
		• Erweiterung der Add-on-Typen: FV wurde zur Liste der gültigen ItemCodes für Add-ons ergänzt


# WEITERE INFOS#
Es gibt bereits eine ungenutzte "Role"-Funktion, welche jedoch momentan nicht im Einsatz ist, da sich dieses Skript auf die Survivor-Rolle beschränkt.
Außerdem soll noch ein Feature integriert werden, dass auch die Chars randomisiert werden können. Außerdem noch eines, mit dem man per Checkbox auswählen kann, was alles zufällig generiert werden soll und was nicht. Am besten auch noch mit einer Config-Speicherung (dafür kann der "Sprache speichern" - Button zu einem "Config speichern" - Button werden.

Sollte es nochmals Probleme geben, dass Umlaute etc. falsch angezeigt werden, sind hier ein paar Beispiele für die Umkonvertierung, welche via Strg + H (Suchen + Ersetzen) durchgeführt werden kann.
Ã¼ → ü
Ã¶ → ö
Ã¤ → ä
Ã„ → Ä
Ã‰ → É
Ã© → é
Ã  → à (hier ist ein Leerzeichen hinter dem Ã)
Ãœ → Ü