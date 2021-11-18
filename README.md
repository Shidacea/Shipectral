# Shipectral

Shipectral aims to be a Crystal variant of the Shidacea framework.

In the future, Shipectral will take the place of the previous Shidacea C++ backend, which will allow for easier bindings and simplify the process of converting a Shidacea project to much more performant code.

## Features

(Mostly not implemented yet)

* Powerful scripting using mruby and Anyolite
* Fast Crystal core using crSFML
* Support for Dear ImGUI
* ERB methods for text substitution
* Support for project structures
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

### Todo list

* Implement all remaining functions from Shidacea 0.2.1
* Imgui support
* Add option for release builds
* Make Imgui optional
* Block Crystal GC in draw and update routines
* Port Shidacea to Crystal and bind with Anyolite
* Support multiple Shidacea implementations
* Test all test projects
* Add bytecode support
* Support multiple configurations for the executable
* Verify full compatibility to old Shidacea 0.2.1 projects

### Version 0.1.0

#### Features

* [ ] Basic functionality
* [ ] Full compatibility to Shidacea-CPP

### Version 0.2.0

#### Features

* [ ] Complete overhaul to support the new Shidacea 0.3 standard
* [ ] Ressource integration using macros

## Installation

### Prerequisites

* Crystal
* Ruby
* Rake
* Bison
* Git
* SFML (only on Ubuntu - on Windows it is installed automatically)

All of these programs need to be in the path environment variable for Windows to work properly.

### Building

Note that this current version is only guaranteed to run on Windows 64bit and Ubuntu.
You need to run `rake` in either a terminal (Ubuntu) or the 64bit Visual Studio Command Prompt (Windows).
