# modula-test

A test of the [Modula Dual Universe scripting framework](https://github.com/samedicorp/modula).

This example shows how to create a modula module, and how to create and build a construct script using it.

## Introduction

To develop a script with Modula, you need the following:

- Modula must be installed in the game folder at `Game/data/lua/samedicorp/modula`. You can do this by downloading a zip from github, or by cloning it with git. 
- A construct folder containing the code for your construct (like the one that this README file is in).
- A `configure.lua` file at the root level of the construct folder. This tells Modula which modules you want to use, and allows you to set parameters on them.
- (Optionally) one or more custom modules. These can live anywhere in your construct folder, but typically the root is fine.
- You also need to meet [Modula's requirements](https://github.com/samedicorp/modula#requirements).

## Configuration

The module is configured in the `configure.lua` script.

This script must define a global table called modulaSettings. This is used by Modula to know which modules to load, and to set various other properties:

```lua
modulaSettings = { 
    name = "Test Construct",
    modules = {
        ["my.module"] = {}
    }
}
```
### Configuring Modules

Each module in Modula is a Lua object that provides some functionality to the overall script. See [the Modula docs](https://github.com/samedicorp/modula#modules) for more information.

The `modules` property of the settings should be a table. The keys of this table are the names of the modules you want to use. 

These key names should be written as if you were passing them into a `require()` call (e.g: if your module is located at `lua/myconstruct/mymodule.lua`, the key would be `myconstruct.mymodule`). Each of the values of the table should be another table containing settings for that module. Precisely what you put in each of these depends on the module in question. 

### Configuring Parameters

All the code in this file will be included in the `unit.onStart` handler. 

In general you shouldn't put extra code here - it's better to put it into a module instead.

One exception to this is that you can define lua parameters here. Because they will be added to `unit.onStart`, DU will pick them up and allow the user to edit them with the `Edit Lua parameters` menu command. You can then pass these parameters into your modules to configure them:

```lua
local myParameter = false --export: This is a parameter for one of my modules.

modulaSettings = { 
    name = "Test Construct",
    logging = logging, 
    logElements = logElements, 
    useLocal = useLocal,
    modules = {
        ["my.module"] = { myParameter = myParameter }
    }
}
```

## Building

If you are using Visual Studio Code, you should just be able to hit Ctrl-Shift-B. 

This will run the pack script, and will write `.conf` and `.json` versions of the script into the game folder at `Game/lua/autoconf/custom/`. It will also copy the `.json` content into the clipboard. 

You can then install the script in the game, either with the `Run custom autoconfigure`, or `Paste Lua configuration from Clipboard` menu commands.

## Development

Having to pack and re-install scripts after every change is a massive pain in the arse.

Modula was designed to avoid this. 

The packed script can be configured in a way that makes it standalone (so that other people can just use it, and it works on Geforce Now), but where it will automatically load a local version of the code and all modules at runtime (using `require`). 

If you turn this mode on, then in most situations you will simply be able to edit module source code and re-run the script in game; no re-packing necessary. 

## Distribution 

Once you are ready to release your script, you can simply pack it and distribute the `.conf` and/or `.json` versions. Users of these versions don't need to install anything on their machine.