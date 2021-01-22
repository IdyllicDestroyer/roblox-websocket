# RSocket

RSocket is a Roblox library for dealing with websockets via Roblox.
Made by Agent#9895 <3

## Initialization

Place WebSocket.lua in your games **WORKSPACE** as a *ModuleScript*

Place the example, or make your own, in **game.ServerScriptService** as a *Script*

*MAKE SURE YOU ENABLED HTTP REQUESTS*

## Usage

```lua
local ws = require(workspace.WebSocket)
ws.Setup("http://your.ip.here", 2030);

ws.onopen = function()
   print("connected")
end
ws.onclose = function()
   print("closed")
end

ws.onmessage = function(...)
	local Decoded = game:GetService('HttpService'):JSONDecode(...);
end
ws.StartListen(1);
ws.Connect("wss://example.com")
ws.Send(game:GetService('HttpService'):JSONEncode({foo = "bar"}))


```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[APACHE](https://choosealicense.com/licenses/apache-2.0/)
