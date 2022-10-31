# Shipectral

Shipectral (accompanied by Shidacea) is a 2D game engine with different cooperating segments.

Its goal is to provide a simple entry into game development, which works out of the box, but
can also be used for more complicated ideas.

## Features

* Powerful scripting using mruby and Anyolite
* Fast Crystal core using SDL (other libraries are also possible)
* Support for Dear ImGUI
* ERB methods for text substitution
* Support for project structures
* Game development library for easier development
* Modular design

## Structure

The very core of Shipectral is a compound of SDL, Dear ImGUI and Anyolite,
allowing for the direct usage of SDL and ImGUI functions in Ruby scripts.

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

Currently, SFML is the main media library used for Shidacea.
However, SDL is planned to serve as the new main library for
version 0.3.0 and higher, with SFML support remaining as an option.

As a consequence, the Shidacea library will have two different
variants, SDC/SFML and SDC/SDL, which are incompatible to each other.
In the future, Shidacea will mainly refer to SDC/SDL.

## Roadmap

### Version 0.3.0

This version number was chosen in order to avoid confusion with legacy versions.

It will be the first proper release since the legacy versions. Most of the work
is already done, but many features are still missing or not functioning.

The major goal is to support Launshi and custom SDL- or SFML-based frontends fully,
allowing for a solid Ruby-based game development experience.

#### Features

##### Shipectral

* [X] Ability to compile frontend and engine library into executable
* [X] Higher stability due to several bugfixes
* [X] Feature checks
* [ ] CI scripts and automatic builds

##### Shidacea/SFML

* [X] All features of previous Shidacea versions
* [X] Working examples
* [X] Shidacea library updated to new standard
* [X] Simple map parser
* [X] Ellipse shapes

##### Shidacea/SDL

* [X] Coordinates and colors
* [X] Window class
* [X] Textures
* [X] Keyboard support
* [X] Render queue with z-order
* [X] Framerate limiter
* [X] Scenes
* [X] Sprites
* [X] Sounds and music
* [X] Mouse support
* [X] Fonts and texts
* [X] Views
* [X] Collision Shapes
* [X] Entity class
* [ ] Entity parameters
* [ ] Scripting utility for entities
* [ ] Consistent property system
* [ ] Resource manager
* [ ] Marshalling support
* [ ] Game state class
* [ ] Game controller state
* [ ] Full event support
* [ ] Shapes
* [ ] Dedicated tile and map classes
* [ ] Full SDL support on Windows and Linux
* [ ] ImGui support

#### Todo

* [ ] Add remaining ImGui functions and classes
* [ ] Fix debug routines
* [ ] More optimization routines

### Future versions

#### Features

* [ ] Find a way to load different shards
* [ ] Better way to update to newer SDL versions
* [ ] Make ImGui optional
* [ ] Support for data marshalling (Crystal and Ruby)
* [ ] Add virtual file system for executable and connect it with SFML
* [ ] Ressource integration using macros
* [ ] Add a way and flags to put frontend resources directly into executable
* [ ] Particle system
* [ ] Wrappers for vertex arrays
* [ ] Shader support
* [ ] Optimized render queue (if possible)
* [ ] Quadrangle shapes
* [ ] Highly customizable text boxes (including sprites)

#### Wishlist

* [ ] Other targets like MacOS, WASM, Mobile, Console, ...

## Installation

### Prerequisites

* Crystal (Version 1.6.0 or higher)
* Ruby
* Rake
* Git
* SDL or SFML (only on Ubuntu - on Windows they will be installed automatically)

All of these programs need to be in the path environment variable for Windows to work properly.

Make also sure to set `CRYSTAL_PATH` to the appropriate crystal source path, especially on Windows.

### Building

WARNING: Linux builds will most like not work currently.

Note that this current version is only guaranteed to run on Windows 64bit and Ubuntu.
You need to run `rake` in either a terminal (Ubuntu) or the 64bit Visual Studio Command Prompt (Windows).

If you want to use another config file, set the environment variable `SHIPECTRAL_CONFIG_FILE`
to the path of the respective config file (default is `configs/launshi_sfml.json`).

The final program is under the `build` (can be changed using the environment variable `SHIPECTRAL_BUILD_PATH`)
path, in the respective directory.

You can run it using the `rake test` command or by directly executing it from the build directory (on Windows).
