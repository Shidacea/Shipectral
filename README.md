# Shipectral

Shipectral aims to be a Crystal variant of the Shidacea framework.

In the future, Shipectral will take the place of the previous Shidacea C++ backend, which will allow for easier bindings and simplify the process of converting a Shidacea project to much more performant code.

NOTE: Windows is currently not working properly, most likely due to https://github.com/crystal-lang/crystal/issues/9533 .

Windows support will resume once this issue is properly patched out.

## Features

(Mostly not implemented yet)

* Powerful scripting using mruby and Anyolite
* Fast Crystal core using crSFML
* Support for Dear ImGUI
* Modular design

## Structure

(Not finalized yet)

Shipectral (or Shidacea) is a game engine with different cooperating segments.

The very core of Shipectral is a compound of crSFML and Anyolite,
allowing for the direct usage of crSFML functions in Ruby scripts.

On top of this, the Shidacea library (SDClib) of the old Shidacea
project is available, which provides more advanced game functions and support
for more readable scripts, while still preserving the fast speed of
the core functions.

Another module on top is Launshi, a simple launcher application
written in Shidacea, able to launch other Shidacea-based games
without recompiling the core.

Overall, this engine allows different usage modes, ranging from fast
Crystal programming using the basic features up to simple script
usage, allowing for fast prototyping.

## Roadmap

### Version 0.1.0

#### Features

* [ ] Basic functionality
* [ ] Bytecode support
* [ ] Loading of bytecode using macros
* [ ] Ressource integration using macros
* [ ] Launshi integration
* [ ] Implementation of Shidacea functions in the Crystal-based SPTlib
* [ ] Connection of SPTlib and SDClib, if and where possible

## Installation

### Prerequisites

* Crystal
* Ruby
* Rake
* Bison
* Git
* Libraries needed for SFML (mostly Ubuntu, see the SFML documentation for more information)

All of these programs need to be in the path environment variable for Windows to work properly.

### Building

Note that this current version does only run on Windows 64bit and Ubuntu.
You need to run `rake` in either a terminal (Ubuntu) or the 64bit Visual Studio Command Prompt (Windows).
