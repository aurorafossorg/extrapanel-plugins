lgi = require 'lgi'
gtk = lgi.require('Gtk', '3.0')

builder = gtk.Builder()

path = ...
assert(builder:add_from_file(path), "Non existing file!")
window = builder.objects.tunaaddon_configWindow

-- Retrieve fields
minTunas = builder.objects.minTunas
maxTunas = builder.objects.maxTunas
allowTunaTuning = builder.objects.allowTunaTuning


function minTunas:on_value_changed()
	print("This tuna is ", minTunas.value, " years old.")
end

function maxTunas:on_value_changed()
	print("This tuna weighs ", maxTunas.value, " pounds.")
end

function allowTunaTuning:on_toggled()
	print("Tuning on tunas tuned to your tune!")
end

window:show_all()
return window._native