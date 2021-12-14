# Shipectral

Shipectral (accompanied by Shidacea) is a 2D game engine with different cooperating segments.

Its goal is to provide a simple entry into game development, which works out of the box, but
can also be used for more complicated ideas.

## Features

* Powerful scripting using mruby and Anyolite
* Fast Crystal core using crSFML
* Support for Dear ImGUI
* ERB methods for text substitution
* Support for project structures
* Game development library for easier development
* Modular design

## Structure

The very core of Shipectral is a compound of crSFML, Dear ImGUI and Anyolite,
allowing for the direct usage of crSFML and ImGUI functions in Ruby scripts.

On top of this, the Shidacea library is available,
which provides more advanced game functions and support
for more readable scripts, while still preserving the fast speed of
the core functions.

Another module on top is Launshi, a simple launcher application
written in Shidacea, able to launch other Shidacea-based games
without recompiling the core.

Overall, this engine allows different usage modes, ranging from fast
Crystal programming using the basic features up to simple script
usage, allowing for fast prototyping.

## Roadmap

### Version 0.3.0

This version number was chosen in order to avoid confusions with legacy versions.

#### Features

* [X] Basic functionality
* [X] Working examples
* [X] Separated SDC and SF module
* [X] Updated Shidacea library to new standard
* [X] Strictly separate SF modules from SDC modules
* [ ] Wrap other SF classes
* [ ] Encourage keyword usage where useful (and stay faithful to SFML)
* [ ] Add ImGui helper classes for inputs
* [ ] Wrap ImGui classes
* [ ] Add more SDC methods as alternative to directly using SFML methods

### Version 0.4.0

#### Features

* [ ] Port Shidacea to Crystal and bind with Anyolite
* [ ] Find a way to load different shards on Linux
* [ ] Networking routines
* [ ] Block Crystal GC in draw and update routines

### Future versions

#### Features

* [ ] Add virtual file system for executable and connect it with SFML
* [ ] Ressource integration using macros
* [ ] Add way and flag to put frontend resources directly into executable
* [ ] Make Imgui optional

## Installation

### Prerequisites

* Crystal
* Ruby
* Rake
* Bison
* Git
* SFML (only on Ubuntu - on Windows it will be installed automatically)

All of these programs need to be in the path environment variable for Windows to work properly.

### Building

Note that this current version is only guaranteed to run on Windows 64bit and Ubuntu.
You need to run `rake` in either a terminal (Ubuntu) or the 64bit Visual Studio Command Prompt (Windows).

If you want to use another config file, set the environment variable `SHIPECTRAL_CONFIG_FILE`
to the path of the respective config file (default is `configs/launshi.json`).

The final program is under the `build` (can be changed using the environment variable `SHIPECTRAL_BUILD_PATH`)
path, in the `shipectral` directory.

For now, the best way to run it is using the `rake test` command.
