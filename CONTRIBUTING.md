# Contributing

This page contains general guidelines and instructions on how to develop a new plugin/pack

## Plugins

### File Structure

*items with \* are opcional*

```
pluginName
│
├── assets
│   ├── icon.png
│   └── (more assets for mobile) (*)
│
├── mobile
│
├── pc
│   ├── configMenu.ui (*)
│   ├── default.cfg
│   ├── main.lua
│   └── ui.lua (*)
│
├── meta.json
└── README.md (*)
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
        - `url` - URL of the plugin's repository, the developer's page or something else but related to the plugin.
    - **Special** *(these values are still opcional but important for specific actions needed for your plugin)*
        - `install-steps` - Special install instructions your plugin requires. If your plugin needs more actions other than just being copied to the user's PC, you specify them here:
            - `lua-deps` - Dependencies your Lua script requires. Extra Panel will use `luarocks` to install them, so specify the exact name you would supply to luarocks *(for example, if you need to do `luarocks install lfs`, just write `lfs`*) **Note: You do not need to put this under the `root` key.**
            - `command` - Custom command to run. This field should be an array with three keys, `windows`, `darwin` and `linux`, corresponding to the commands you need to run in each platform.
            - `root` - Any actions that require root/admin access should be put inside this array. Extra Panel will inform the user that it's about to perform super operations.
        - `uninstall-steps` - Special uninstall instructions your plugin requires. If your plugin needs more actions other than just being removed from the user's PC, you specify them here:
            - `comand`
            - `root`

#### `assets` folder

In this folder you place any assets you use for the plugin. Most notably, you should include a 48x48 `icon.png` file to represent your plugin's logo.

#### `mobile` folder

This folder will contain every file nedded for the `mobile` version of the plugin.
WIP

#### `pc` folder

This folder will contain every file needed for the `pc` version of the plugin. You can put any file you need here, but these 3 are **mandatory**:

- `configMenu.ui` - This is your plugin's configuration menu that will appear inside Extra Panel's Config tab. Here you should make a nice UI to allow the user to edit several configs related to your plugin.
- `default.cfg` - This is your plugin's configuration file. Here you save the custom configs needed for your plugin in .CFG format.
- `ui.lua` - This is your plugin's configuration menu functionality. If your plugin requires custom actions, you can implement them. More info below.
- `main.lua` - This is your plugin's main script. This is your plugin's entrypoint: you can do any functionality your plugin requires, but you need to implement these 3 **methods**
    - `setup(argument)` - This is your setup method. It's called once when the daemon loads your plugin. It's argument contains the plugin's configurations separated by `;`. You should return 0 if the plugin loaded fine or other error code if there was an error.
    
    *For example, if your plugins has the following config file:*

    ```
    min: 0
    max: 100
    ```
    your `argument` will be: `min: 0;max: 100;`
    - `query()` - This method will be called by the daemon when it's time to collect information. Here you return info to be sent to mobile's plugin version. You should only return info **if it has changed since the last call**; this means keeping an internal state in your script to account for that.
    - `change(data)` - This method will be called when the daemon received commands from the mobile's plugin version. Here you should change the PC's state to the given info. You shouldn't return anything.

### Creating a configuration menu

#### PC

There are two options to create the UI for you to choose. If you don't need custom functionality, you can create a quick UI without any coding needs by creating an UI in Glade. This UI is later embedded in the configuration panel under your plugin section.

The app also saves/loads configuration values for each UI element with the same ID. *(so for example, if you have a config* `max: 65` *in your file, the app will save/load that value on any element of your UI with id **max***)

The other way requires you to define your UI by using Lua, either manually or by using an `.ui` file or your UI. This way, you can easily control every element of the UI through a Lua script, allowing more custom functionality.

### Packagin plugins

When you are ready to package your plugin for usage, youshould compress the folder structure, as well as leaving some files out for easier CDN fetching.

You have two ways: using the [Extra Panel SDK](https://gitlab.com/aurorafossorg/p/extra-panel/sdk/) to package a plugin:

`extrapanel-sdk -p <pluginRootFolder> <outputFolder>`

Inside `outputFolder` you'll get three files: the compressed `tar.gz` plugin and your `meta.json` and logo. The plugin is ready to be installed on Extra Panel.

You can also do the packaging by hand. Firstly create a folder to hold your compressed plugin. We will call it `outputFolder`.

This step is required if you plan to ship your plugin using a CDN, either yours or ours. If you're going to distribute the plugin by local means, you can skip this.
Copy your logo and `meta.json` to the `outputFolder`.

Now you'll need to compress your plugin in `tar.gz` format. Your file structure is the following:

```
pluginName
│
├── assets
│   ├── icon.png
│   └── (more assets for mobile) (*)
│
├── mobile
│
├── pc
│   ├── configMenu.ui (*)
│   ├── default.cfg
│   ├── main.lua
│   └── ui.lua (*)
│
├── meta.json
└── README.md (*)
```

After packaging, your `pluginName.tar.gz` *must* have the following structure:

```
<pluginName.tar.gz>
│
└──pluginName
    │
    ├── assets
    │   └── icon.png
    │
    ├── configMenu.ui (*)
    ├── default.cfg
    ├── config.cfg
    ├── main.lua
    ├── ui.lua (*)
    └── meta.json
```

Note the new `config.cfg`: this is just a copy of your `default.cfg`.

Either way you used, your `outputFolder` structure should be the following:

```
outputFolder
│
├── pluginName.tar.gz
├── icon.png (*)
└── meta.json (*)
```

Your plugin is now packaged. If you have the two opcional files, you can use a CDN for the app to fetch the plugin, either yours or ours.

If you wish to your plugin to be part of the **Community** plugins, you need to contact us to begin the process. We'll only check your source code for security concerns, and if your plugin is accepted, you can distribute it either way, closed or open-source.

## Packs

*WIP...*