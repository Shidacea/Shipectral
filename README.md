# Shipectral

Shipectral is planned to be a port of the Shidacea core library SDCLib to the Crystal language.
This project is highly experimental and might not be completed at all.

# Roadmap

## Structure

* [ ] Literally split this repository into shards
* [ ] Port of Collishi library as one shard
* [ ] SPTLib as one shard
* [ ] Launcher as separate project, maybe still with CMake?

## Features

* [ ] CrystalCollishi as port of Collishi
* [ ] SPTLib as port of SDCLib
* [ ] Port all Shidacea engine and core methods
* [ ] Port entity-component system of Shidacea
* [ ] Port demo projects
* [ ] Try to implement ImGui

# Differences from Shidacea

* TODO

# Installation

Note that this current version does only run on Windows 64bit.
You need to provide a folder third_party with the subfolders crystal, crSFML and SFML.

crystal needs to contain the crystal source code and a working Windows executable.

crSFML needs to contain the crSFML source code.

SFML needs to contain a recent Visual Studio 64bit SFML release with folders bin, lib and include in it.

Then run cmake using Visual Studio.
