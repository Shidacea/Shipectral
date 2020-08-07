# Shipectral

Shipectral aims to be a Crystal variant of the Shidacea framework.

In the future, Shipectral will take the place of the previous Shidacea C++ backend, which will allow for easier bindings and simplify the process of converting a Shidacea project to much more performant code.

# Roadmap

## Structure

* [ ] Include submodules properly
* [ ] Linux support
* [ ] Consider Rake as build system
* [ ] Port of Collishi library as one shard
* [ ] CI and automatically generated binaries

## Features

* [ ] Reproduce Shidacea bindings
* [ ] Reproduce SDCLib as good as possible in Crystal

# Differences from Shidacea

* TODO

# Installation

Note that this current version does only run on Windows 64bit.
You need to provide a folder third_party with the subfolders crystal, crSFML, anyolite and SFML.

crystal needs to contain the crystal source code and a working Windows executable.

crSFML needs to contain the crSFML source code.

SFML needs to contain a recent Visual Studio 64bit SFML release with folders bin, lib and include in it.

anyolite needs to contain the full anyolite shard including submodules.

Then run cmake using Visual Studio.
