lgi = require 'lgi'
gtk = lgi.require('Gtk', '3.0')
lfs = require 'lfs'

builder = gtk.Builder()

path = ...
assert(builder:add_from_file(path), "Non existing file!")
window = builder.objects.brightctrl_configWindow

-- Retrieve fields
min = builder.objects.min
max = builder.objects.max
changeAll = builder.objects.changeAllDevices
treeView = builder.objects.treeView
devices = builder.objects.devices
enableBoxes = builder.objects.enableBoxes

-- Query existing devices
for device in lfs.dir("/sys/class/backlight") do
	if device ~= "." and device ~= ".." then
		devices:append({false, device})
	end
end

function min:on_value_changed()
	max.lower = min.value
end

function max:on_value_changed()
	min.upper = max.value
end

local function enableAllDevices()
	for k, v in devices:pairs() do
		v[1] = true
	end
end

function changeAll:on_toggled()
	treeView.sensitive = not changeAll.active
	if not treeView.sensitive then
		enableAllDevices()
	end
end

function enableBoxes:on_toggled(path_str)
	local path = gtk.TreePath.new_from_string(path_str)
	devices[path][1] = not devices[path][1]
end

window:show_all()
return window._native