min = nil
max = nil
currVolume = nil
currMuted = nil

--setup() - Sets the plugin up for running. Receives it's configuration and returns whether is good to go or an error ocurred
function setup(config)
	-- Parses configuration
	for k, v in string.gmatch(config, "(%w+): (%w+)") do
		if k == "min" then
			min = tonumber(v)
		elseif k == "max" then
			max = tonumber(v)
		end
	end

	-- Checks if config isn't illegal
	if min >= max or max <= min then
		error("Illegal state: min >= max or max <= min")
	end

	-- Good to go
	return 0
end

--query() - Queries information from the host; only returns info if state changed after last call
function query()
	-- Get current volume
	output = io.popen("pulseaudio-ctl full-status", "r")
	for vol, outMuted, inMuted in string.gmatch(output:read(), "(%w+) (%w+) (%w+)") do
		newVolume = vol
		newMuted = outMuted
	end
	changed = (newVolume ~= currVolume) or (newMuted ~= currMuted)
	currVolume = newVolume
	currMuted = newMuted

	output:close()
	
	if changed then
		return(currVolume .. ";" .. currMuted)
	else
		return(nil)
	end
	
end

--change() - Changes behaviour on host according to the instructions of controller
function change(action)
	for vol, muted in string.gmatch(action, "(%w+);(%w+)") do
		io.popen("pulseaudio-ctl set " .. vol, "w");
		io.popen("pulseaudio-ctl mute " .. muted, "w");
	end
end