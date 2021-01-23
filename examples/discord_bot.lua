local botToken = ""; -- https://discord.com/developers/applications/
local status = "discord bot hosted on roblox";
--|| put me in serverscriptservice (DO NOT MAKE ME A LOCALSCRIPT)
local WS = require(workspace.WebSocket);
WS.Setup("http://your.ip.here", 2030); -- port forward it you dumby. netgear users go to routerlogin.net
local Heartbeat = 0;
local packets = {
	["1"] = function() 
		WS.Send('{"op": 1, "d": null}');
	end,
	["2"] = function() 
		WS.Send(game:GetService('HttpService'):JSONEncode({
			op = 2,
			d = {
				token = "Bot " .. botToken,
				properties = {
					["$os"] = "windows",
					["$browser"] = "roblox",
					["$device"] = "roblox"
				},
				
				presence = {
					status = "online",
					game = {
						name = status,
						type = 0
					}
				}
			}
		}))
	end,
}
WS.onopen = function()
	print('Discord Bot started.')
end
WS.onclose = function()
	print('Closed')
end
WS.onmessage = function(...)
	local Decoded = game:GetService('HttpService'):JSONDecode(...);
	local Event = Decoded.t;
	local Data = Decoded.d;
	if (Decoded.op == 10) then 
		Heartbeat = Decoded.d.heartbeat_interval / 1000;
	elseif (Decoded.op == 1) then 
		packets["1"]();	
	elseif (Event == "MESSAGE_CREATE") then
		print(Data.author.username .. "#" .. Data.author.discriminator .. ": " .. Data.content);
	end
end
if (WS.IsConnected()) then
	WS.Disconnect();
end
WS.StartListen(1);
WS.Connect("wss://gateway.discord.gg");
packets['2']();
spawn(function()
   while wait() do
	if (Heartbeat == 0) then
	    wait(.1);
	else
	    wait(Heartbeat);
	    packets["1"]();
	end
    end
end)
