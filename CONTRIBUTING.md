# Contributing

This page contains general guidelines and instructions on how to develop a new plugin/pack

## Plugins

### File Structure

```
pluginName
│
├── assets
│   └── icon.png
│
├── mobile
│
├── pc
│   ├── configMenu.ui
│   ├── default.cfg
│   └── main.lua
│
├── meta.json
└── README.md
```

*\* Please note the `mobile` component is yet to be developed on Extra Panel.*

All of your plugin's files will be stored in a folder, called `pluginName`, which is your plugin name.

You have two ways to create this tree structure. The [Extra Panel SDK](https://gitlab.com/aurorafossorg/p/extra-panel/sdk/), can be used to easily bootstrap a plugin by running:

`extrapanel-sdk -b <pluginName>`

All your files will be inside the `pluginName`. Now you need to edit the `meta.json` to define your plugin and you're good to go.

The other wat is manually. You'll need to create all the files under the instructions below.

The root must contain **two** files:

- `meta.json` - This is your plugin's metadata. Here you describe various aspects of your plugin:
    - **Mandatory**
        - `id` - Unique ID of your app.
        - `name` - Name of your plugin (title)
        - `description` - Short description of your plugin
        - `icon` - Icon location *(typically `assets/icon.png`)*
        - `authors` - List of authors
        - `version` - Version
    - **Opcional**
        - *WIP*

#### `assets` folder

In this folder you place any assets you use for the plugin. Most notably, you should include a 48x48 `icon.png` file to represent your plugin's logo.

#### `mobile` folder

This folder will contain every file nedded for the `mobile` version of the plugin.
WIP

#### `pc` folder

This folder will contain every file needed for the `pc` version of the plugin. You can put any file you need here, but these 3 are **mandatory**:

- `configMenu.ui` - This is your plugin's configuration menu that will appear inside Extra Panel's Config tab. Here you should make a nice UI to allow the user to edit several configs related to your plugin.
- `default.cfg` - This is your plugin's configuration file. Here you save the custom configs needed for your plugin in .CFG format.
- `main.lua` - This is your plugin's main script. This is your plugin's entrypoint: you can do any functionality your plugin requires, but you need to implement these 3 **methods**
    - `setup(argument)` - This is your setup method. It's called once when the daemon loads your plugin. It's argument contains the plugin's configurations separated by `;`. You should return 0 if the plugin loaded fine or other code if there was an error.
    - `query()` - This method will be called by the daemon when it's time to collect information. Here you return info to be sent to mobile's plugin version. You should only return info **if it has changed since the last call**; this means keeping an internal state in your script to account for that.
    - `change(data)` - This method will be called when the daemon received commands from the mobile's plugin version. Here you should change the PC's state to the given info. You shouldn't return anything.

### Creating a configuration menu

#### PC

There are two options to create the UI for you to choose. If you don't need custom functionality, you can create a quick UI without any coding needs by creating an UI in Glade. This UI is later embedded in the configuration panel under your plugin section.

The app also saves/loads configuration values for each UI element with the same ID. *(so for example, if you have a config* `max: 65` *in your file, the app will save/load that value on any element of your UI with id **max***)

The other way requires you to define your UI by using Lua, either manually or by using an `.ui` file or your UI. This way, you can easily control every element of the UI through a Lua script, allowing more custom functionality.

## Packs

*WIP...*