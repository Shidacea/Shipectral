# Shipectral

Shipectral aims to be a Crystal variant of the Shidacea framework.

In the future, Shipectral will take the place of the previous Shidacea C++ backend, which will allow for easier bindings and simplify the process of converting a Shidacea project to much more performant code.

# Features

* Full mruby interpreter included
* Anyolite support allowing simple mruby bindings of Crystal and C methods
* Support for Windows and Ubuntu with easy build routine

# Roadmap

## Structure

* [ ] Port of Collishi library as one shard
* [ ] CI and automatically generated binaries

## Features

* [ ] Reproduce Shidacea bindings
* [ ] Reproduce SDCLib as good as possible in Crystal

# Differences from Shidacea

* TODO

# Installation

## Prerequisites

* Crystal
* Ruby
* Rake
* Bison
* Git
* Libraries needed for SFML (mostly Ubuntu, see the SFML documentation for more information)

All of these programs need to be in the path environment variable for Windows to work properly.

## Building

Note that this current version does only run on Windows 64bit and Ubuntu.
You need to run `rake` in either a terminal (Ubuntu) or the 64bit Visual Studio Command Prompt (Windows).
