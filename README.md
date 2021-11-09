i# KSPDevEnvironmentBuilder

Script to clone an install of KSP to a new location and automate the creation of a linked  Unity Dev Environment.  Allows Mod development using a centralized reference library, to support multiple mods.

Windows version, runs in a Dos window (batch file)

Menu driven, allows running individual steps of the process.

Uses text files for locating certain assets, so can be customized for individual or team use.

The basic structure is as follows:

1.  DevSetup folder contains the DevSetup.bat Script and necessary files for identifying the location of the mod development source code (the _LocalDev folder).  The location of this folder is not critical. Typically I place it in my Game folder. I usually create a shortcut to the script file for ease of use. 

2.  _LocalDev Folder contains the necessry linking files to locate the various resources needed for cloning the game, KSP and Unity libraries needed for development, and distribution.  This folder typically located the folder that contains the mod project/solution folders.  This makes adding references and creating distribution files for multiple mods easier.


Each folder contains a Readme.txt so you will know what is generally contained in them.

THe process runs as follows:

1.  at start, check the version in the Readme.txt file of the installed game against any existing version in the active dev game folder
2.  Display version data and prompt the user to continue or quit.
3.  Display the action menu for the script:
  
   Main Menu:

  1. - Perform all steps...
  2. - Backup existing game folder...
  3. - Remove existing game folder...
  4. - Create new game folder...
  5. - Copy retail game folder...
  6. - Copy new KSP / unity assemblies to LocalDev...
  7. - Copy Dev Debug files to Game folder...
  8. - Copy Game Save and Ships to Game folder...
  9. - Create linked folder...
  X. - Quit script  (Do nothing!)
  
---> Select option (1 - 9, X): 

If all actions are selected (menu option 1):
- the actions will be performed in the order shown above. 
- the batch process contains pauses built into each step so you can see what is happening between steps. 
- after completion, the script will prompt you to press a key to exit. 

If any option other than all is selected:
- only that action will occur.
- you will return to the main menu after that action is completed.
