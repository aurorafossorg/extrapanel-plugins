# Contributing

This page contains general guidelines and instructions on how to develop a new plugin/pack

## Plugins

# Structure

```
pluginName
│
├── assets
│   └── icon.png
│
├── mobile
│
├── pc
│   ├── configMenu.glade
│   ├── default.cfg
│   └── main.lua
│
├── meta.json
└── README.md
```

* Please note the `mobile` component is yet to be developed on Extra Panel.

All of your plugin's files will be stored in a folder, called `pluginName`, which is your plugin name.

### 