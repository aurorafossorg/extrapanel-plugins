--setup() - Sets the plugin up for running. Receives it's configuration and returns whether is good to go or an error ocurred
function setup(config)
	-- Parses configuration
	for k, v in string.gmatch(config, "(%w+): (%w+)") do
	end

	-- Good to go
	return 0
end

--query() - Queries information from the host; only returns info if state changed after last call
function query()
	return
end

--change() - Changes behaviour on host according to the instructions of controller
function change(action)
	io.popen(action .. " &", "r");
end