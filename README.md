# IoT Portfolio

This repository contains evidence of the tasks completed during each scheduled workshop for the final year Internet of Things unit at the University of Portsmouth.

## Overview

- [ESP8266](https://en.wikipedia.org/wiki/ESP8266) used for hardware device.
- [NodeMCU firmware](https://nodemcu.readthedocs.io/en/master/) flashed onto ESP8266 using [NodeMCU pyFlasher (v4.0)](https://github.com/marcelstoer/nodemcu-pyflasher).
- All code for the ESP8266 is written in Lua.
- Code saved to ESP8266 using [ESPlorer](https://esp8266.ru/esplorer/).

## Credentials required

As some of the tasks required various credentials to provide end-to-end functionality, those credentials have been removed from the repository.

Instead the [`env.sample.lua`](env.sample.lua) file contains the same code that was used to complete workshop tasks, with all of the credentials replaced with empty strings.
The `env` module is then required in the exercises that used the credentials.
