min = nil
max = nil
minAbs = nil
maxAbs = nil
currBrigth = nil
--brightFile = nil
path = "/sys/class/backlight/intel_backlight/"

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

	-- Transforms max and min from percent to number
	max = max / 100
	min = min / 100

	-- Opens backlight file
	--brightFile = io.open(path .. "brightness", "r+")
	maxBrightFile = io.open(path .. "max_brightness", "r")
	local temp = maxBrightFile:read()
	maxBrightFile:close()
	maxAbs = temp * max
	minAbs = temp * min

	-- Good to go
	return 0
end

--query() - Queries information from the host; only returns info if state changed after last call
function query()
	local reader = io.open(path .. "brightness", "r")
	local newValue = reader:read() / maxAbs * 100
	reader:close()
	local changed = newValue ~= currBrigth
	currBrigth = newValue

	if changed then
		return(currBrigth)
	else
		return(nil)
	end
end

--change() - Changes behaviour on host according to the instructions of controller
function change(action)
	--local writer = io.popen("echo " .. tostring(action / 100 * maxAbs) ..  " > " .. path .. "brightness", "w")
	local writer = io.open(path .. "brightness", "w")
	writer:write(tostring(math.floor(action / 100 * maxAbs)))
	writer:close()
end