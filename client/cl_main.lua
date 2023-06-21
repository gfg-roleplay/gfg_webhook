Locale = {}

function sendToDiscord(data)
   debug_print("Sending data to discord", 1)
   TriggerServerEvent('gfg_webhook:server:sendToDiscord', data)
end
exports('sendToDiscord', sendToDiscord)

-- Library Functions [NO TOUCH]

function Lang(what)
	local Dict = Locale[Config.language]
	if not Dict[what] then return Locale["en"][what] end -- If we cant find a translation, use the english one.
	return Dict[what]
end

function debug_print(data, level)
   if level == 1 and Config.debug then
      print(data)
   elseif level == nil and Config.debug then
      print("The data below has no defined level")
      print(data)
   end
end