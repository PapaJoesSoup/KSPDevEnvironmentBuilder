# KSPDevEnvironment
Script to clone an install of KSP to a new location and automate the creation of a linked  Unity Dev Environment.  Allows Mod development using a centralized reference library, to support multiple mods.

Windows version, runs in a Dos window (batch file)

Menu driven, allows running individual steps of the process.

Uses text files for locating certain assets, so can be customized for individual or team use.

The basic structure is as follows:

1 DevSetup folder contains the necessary files for identifying the location of the mod development source code.  The location of this file is not critical. Typically I place it in my Game folder.  

2.  _LocalDev Folder contains the necessry linking files to locate the various resources needed for cloning the game, libraries needed for development, and distribution.  This folder typically located the folder that contains the mod project/solution folders.  This makes adding references and creating distribution files for multiple mods easier.


Each folder contains a Readme.txt so you will know what is generally contained in them.
