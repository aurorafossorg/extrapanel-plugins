currTime = nil
format = nil

--setup() - Sets the plugin up for running. Receives it's configuration and returns whether is good to go or an error ocurred
function setup(config)
	-- Parses configuration
	for k, v in string.gmatch(config, "(%w+): (.+)") do
		io.write(k..'\n'..v)
		if k == "format" then
			format = v
		end
	end

	-- Good to go
	return 0
end

--query() - Queries information from the host; only returns info if state changed after last call
function query()
	currLevel = io.popen("date +\"" .. tostring(format) .. "\"", "r")
	newValue = currLevel:read()
	changed = newValue ~= currTime
	currTime = newValue

	currLevel:close()
	
	if changed then
		return(currTime)
	else
		return(nil)
	end
end

--change() - Changes behaviour on host according to the instructions of controller
function change(action)
end