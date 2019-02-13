--query() - Queries information from the host; only returns info if state changed after last call
function query()
	currLevel = io.popen("xbacklight -get", "r")
	return(currLevel:read())
end

--change() - Changes behaviour on host according to the instructions of controller
function change(action)
	io.popen("xbacklight -set " .. action, "r");
end