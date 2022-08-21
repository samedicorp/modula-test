# modula-test

A test of the [Modula Dual Universe scripting framework](https://github.com/samedicorp/modula).

This example shows how to create a modula module, and how to create and build a construct script using it.

## Introduction

To create a script with Modula, you need the following:

- Modula must be installed in the game folder at `Game/data/lua/samedicorp/modula`. You can do this by downloading a zip from github, or by cloning it with git. 
- A construct folder containing the code for your construct (like the one that this README file is in).
- A `configure.lua` file at the root level of the construct folder. This tells Modula which modules you want to use, and allows you to set parameters on them.
- (Optionally) one or more custom modules. These can live anywhere in your construct folder, but typically the root is fine.

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
### Modules

The `modules` property of the settings should be a table. The keys of this table are the names of the modules you want to use. These should be written as if you were passing them into a `require()` call (e.g: if your module is located at `lua/myconstruct/mymodule.lua`, the key would be `myconstruct.mymodule`). Each of the values of the table should be another table containing settings for that module. Precisely what you put in each of these depends on the module in question. 

### DU Lua Parameters

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
