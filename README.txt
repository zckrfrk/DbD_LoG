DbD_LoG
Dead by Daylight Loadout Generator
by Zckrfrk

Copyright © 2025-2026 Zckrfrk
Licensed under the MIT License. See the LICENSE file for details.

README
German version: LIESMICH.txt

## README ZUR VERSION 5.0 - SURVCORE LEAGUE + RENAMING UPDATE ##

►►► HOW TO DOWNLOAD THE TOOL: Click on the green button labeled '<> Code' and then select 'Download ZIP.' After downloading, extract the tool to a folder of your choice (Little tip: set the folder as a 'Quick Access' in your Windows Explorer).

HUHW! Here’s my tool that lets you randomly choose characters, perks, items, addons, and offerings for Dead by Daylight. Have fun with it!

It’s far from perfect yet, so please feel free to report any issues (bugs, problems, suggestions, and improvement ideas) to me on Discord or via email: zckrfrk.business@t-online.de. Thanks a lot!

All updates for the tool will be announced first in this Discord channel: https://discord.gg/xAs6VRExbF

To start the tool, just double-click the BAT file in the extracted folder: 'DeadbyDaylight_LoadoutGenerator.bat'.

To create a shortcut on the desktop, you can right-click on the respective batch file ('DeadbyDaylight_LoadoutGenerator.bat') and select Send To > Desktop (create shortcut).

If you use the tool, feel free to mention/give my name '@zckrfrk', I always appreciate it! :DD

More links:
Git: https://github.com/zckrfrk/DbD_LoG
YouTube: https://www.youtube.com/@zckrfrk
Streams: https://zfstream.de
more: https://linktr.ee/zckrfrk

Thanks for using my tool!

Best regards,
Mari aka Zckrfrk

►► TOOL EXPLANATION ◄◄
Since the tool might look a bit overwhelming at first glance, here's a little guide where I go over each element of the tool in more detail.
► Tool as a window: When opening the .BAT file, two windows appear (one with a black logo and one with a blue logo). The one with the black logo is for automatically opening the other window and can be ignored. To access the tool window once it has already been opened via the .BAT file, you need the window with the blue logo (Powershell). If the tool (window with blue logo) is closed, the other window (black logo) closes immediately as well.
► Role: In the dropdown menu, you can choose between Survivor and Killer. If you click on the dropdown menu and then select the other role, the options for the role will change.
► Language: Here you can adjust the language for the output. Are you playing DbD in English? - Then select 'English,' if you play it in German, then of course 'Deutsch.' 
► Save Config: This button saves the current language, the current role as the tool's starting role, and the current options for the respective role ('Survivor Options' or 'Killer Options').
► Survivor Options: In this section, you can check what you want to generate for your survivor. Only visible when the mode is set to 'Survivor.' 
► Killer Options: In this section, you can check what you want to generate for your killer. Only visible when the mode is set to 'Killer.'
► Survivor: This checkbox makes sure that a survivor name is also generated when checked.
► Killer: This checkbox makes sure that a killer name is also generated when checked.
► Slider next to Survivor or Killer: This slider is used to select the number of survivors to generate.
► all: Mit Klick auf diesen Button wird die Anzahl aller momentan im Spiel existierenden Survivor bzw. Killer gesetzt.
► Perks: Diese Checkbox sorgt dafür, dass angehakt auch vier Perks für die jeweilig aktive Rolle generiert wird.
► Slider to the right of Perks: This slider is used to select the number of perks to be generated for Killers (1-4) or Survivors (1-16).
► extra Aura/Alert: This checkbox, when checked, guarantees the generation of a Killer perk from the Aura/Alert category (see 'perks_Killer_AuraAlert.csv' in the 'data' subfolder).
► extra Generator: This checkbox, when checked, guarantees the generation of a Killer perk from the Generator category (see 'perks_Killer_Generator.csv' in the 'data' subfolder).
► Item: Checking this box ensures that an item is generated for your Survivor.
► Slider to the right of Item: Here you can spend on addon colors for multiple items. This slider is only visible when you are on the Survivor side and have 'Addon-Colours' checked.
► Add-ons: Checking this box ensures that add-ons for the item for your Survivor or add-ons for the Killer are generated.
► Addon Colors: Checking this box ensures that an addon combination of two colors is generated for your Killer or Survivor. This is primarily intended for tournaments to prevent the use of overly powerful add-ons.
► Offering: Checking this box ensures that an offering is generated for the currently active role.
► GO: This button generates a loadout based on the role specified in Mode, the checkboxes selected in Options (Survivor Options or Killer Options), and the language specified in Language.
► switch: This button can be used if you have generated a loadout but want to display it in the other language.
► both: This button can be used if you have generated a loadout but want to display it in both the currently selected language and the other language.
► COPY: This button saves your generated loadout to the clipboard, allowing you to paste it manually into a chat or other format.
► APPEND: This button adds another loadout below the last generated one.
► EXPORT: This button saves your generated loadout to the TXT file 'export'. Located in the same folder as the .BAT file.
► COINFLIP: This button makes the decision for you if you're unsure whether to play as Killer or Survivor in the next round. The tool also switches to the generated role.
► CLEAR: This button removes your generated loadout from the tool's output window and completely clears the export TXT file.
► OBS Integration: The tool can be integrated into OBS (and similar software). This is done using the 'export' TXT file. Once in OBS, you can add a new 'Text (GDI+)' source using the plus (+) icon, for example, named 'export'. In the OBS source properties, you need to check the 'Read from file' box and use the 'Browse' button to navigate to the script's path and select the 'export' TXT file. You can now experiment with the settings to determine how you want the TXT file to be displayed. I recommend the following settings: 1. Font size: 60 | 2. Vertical alignment: Bottom | 3. Use custom text area: check (Width: 1920, Height: 1080) | 4. Line wrapping: check. Additionally, a hotkey can be assigned to the OBS source (Settings > Hotkeys). However, you can also use the CLEAR button in my tool; then the loadout will no longer be displayed until the next one is generated.
► GitHub: This link leads to the GitHub page for the tool.
► Discord (Updates/Feedback/Bug Report): This link leads to the Discord server of the "SurvCore League," for which the tool was originally intended. There is a "DbD_LoG" section where you can find information about new updates, leave feedback/suggestions for improvement, and report errors or bugs in the tool so they can be fixed soon.
► Zckrfrk: This link leads to my Linktree with all my links, which also lead to my other Linktrees.
► README: This link leads directly to the README on the GitHub page, which refers to the file "README.txt".
► data: This subfolder contains the CSV files from which the loadouts are generated. These can be modified at any time. However, it is important that when making changes, the entire line of the CSV is deleted or added to avoid problems.
► If you have any further questions, please feel free to contact me via the links above!


########################
### current version: ###
########################

 ────────────────────────────────────┐
  VERSION 5.0 - SURVCORE LEAGUE + RENAMING UPDATE
└────────────────────────────────────

→ Version 5.0 - Update from 13.11.2026 - DbD Version 10.2.2 ←

EXCITING SUMMARY
○ Multiple outputs are now possible! The new 'APPEND' button does just that!
○ 'switch' & 'both' now also work with 'APPEND'!
○ Selecting the quantity for perks, characters, and more is now possible!
○ Exciting new checkboxes for Survivor and Killer!
○ Cool new sliders added!
○ Additional settings for tournament situations added!
○ Changes also on GitHub!
○ A dedicated Discord section with multiple channels was created for the tool and linked in the README, among other places.
○ All further information can be found above in the tool's explanation or below in the additional changelog points!

1. New Features
• Added a new 'APPEND' button to allow multiple generated loadouts to be displayed one after the other
• Adjusted the logic so that the 'switch' and 'both' buttons now also work with 'APPEND'
• You can now select how many perks should be displayed at once (Survivor: 1-16 / Killer: 1-4)
• Added a 'Addon Colors' checkbox for Survivors (this will now display two colors according to tournament rules for the addons)
• Additional output of up to four items with two addon colors
• All characters (Killer or Survivor) can now be displayed in random order (slider + 'All' button added next to the 'Survivor' and 'Killer' checkboxes)
• On the Killer side, you can now check whether an Aura and/or a Generator perk should be guaranteed to be generated (new 'extra Aura' and 'Extra Aura' buttons) 'Extra Generator')
• On the Killer side, in addition to the addon colors, addons can now also be generated (since each Killer has the same number of red (2), purple (4), blue (5), green (5), and brown (4) addons, the color and a corresponding number are displayed).
• CSVs created: perks_Killer_Aura & perks_Killer_Generator & addons_Killer
• Configuration extended for the above-mentioned new features

2. Adjustments/Renaming
• GitHub page & folder: 'DeadByDaylight_Randomizer-SurvCoreEdition' → 'DbD_LoG'
• GitHub name: 'zockerfreak' → 'zckrfrk'
• Link updated: https://github.com/zckrfrk/DbD_LoG
• CSV filename 'addonsColours_Killer' → 'addonsColours_Both'
• Tool renamed throughout to 'DbD_LoG' (BAT file now: 'DeadbyDaylight_LoadoutGenerator.bat')
• A new release for version 5.0 has been created on GitHub (older versions are available under old branches).

3. README
• Added short download instructions on how to download the tool
• Adjusted introductory text (including adding a link to a dedicated Discord channel for the tool)
• Updated the general section '# MORE INFO #'
• Corrected formatting and spelling errors and other minor issues
• Adjusted the tool's description and added new sections
• Added a Vibe Coding Disclaimer at the end of the document
• Starting with DbD_LoG version 5.0, the README is now available in both German and English (A new README has been created: The former main README has been renamed "LIESMICH" and the new English README has become the main README)

4. Bugfix
• perks_Survivors: 'Call of Salvation' & 'Fruits of Your Labor' regarding the Umlauts adjusted (were not displayed correctly in the tool)


#########################################################################################
### for older version changelogs check (and translate) the German document: DE_README ###
#########################################################################################

# MORE INFO #
Should there be further problems with umlauts etc. being displayed incorrectly, here are a few examples of the conversion, which can be done via Ctrl + H (search + replace).
Ãœ → Ü
Ã– → Ö
Ã„ → Ä
Ã¼ → ü
Ã¶ → ö
Ã¤ → ä
Ã‰ → É
Ã© → é
Ã€ → À
Ã  → à (There is a space after the Ã here.)
áºž → ẞ (← capital sharp s)
ÃŸ → ß

# DISCLAIMER #
The script was written using Microsoft Copilot Chat (Vibe Coding), also the LICENSE file. However, I personally handle all testing, verification, and adjustments of all outputs. The CSV structure and the README are entirely my own work.