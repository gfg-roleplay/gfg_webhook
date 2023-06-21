Locale = {}
local serverName = GetConvar('sv_projectName', 'No Server Project Name Found')

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      exports['gfg_webhook']:sendToDiscord(
         {
            username = "GFG Webhook",
            avatar = "https://i.imgur.com/Y4nltZW.png",
            title = Lang('webhookOnline'),
         }
      )
   end
end)

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then
      exports['gfg_webhook']:sendToDiscord(
         {
            username = "GFG Webhook",
            avatar = "https://i.imgur.com/Y4nltZW.png",
            title = Lang('webhookOffline'),
         }
      )
   end
end)

RegisterNetEvent("gfg_webhook:server:sendToDiscord")
AddEventHandler('gfg_webhook:server:sendToDiscord', function(data)
   data.invokingResource = GetInvokingResource() 
   sendToDiscord(data) 
end)

function sendToDiscord(data)
   debug_print("Sending Message to discord", 1)
   debug_print("Data: "..json.encode(data, {indent = true}), 1)
   local webhook = data.webhook or Config.Defaults.defaultWebhook
   debug_print("Using webhook: "..webhook, 1)

   local hour = os.date("%H", os.time()) + Config.utcOffset
   if hour < 10 then
      hour = "0"..hour
   end

   local embed = {
       {
         ["title"] = data.title or Config.Defaults.defaultTitle,
         ["description"] = nil,
         ["color"] = data.color or Config.Defaults.defaultColor,
         ["timestamp"] = os.date("%Y-%m-%dT"..hour..":%M:%S.000Z", os.time()),
         ["thumbnail"] = {},
         ["image"] = {},
         ["fields"] = {},
         ["author"] = {
            ["name"] = data.invokingResource or GetInvokingResource() or GetCurrentResourceName(),
            ["icon_url"] = data.avatar or Config.Defaults.defaultAvatar,
         },
         ["footer"] = {
            ["text"] = serverName,
            ["icon_url"] = "https://i.imgur.com/Y4nltZW.png"
         },
       }
   }

   if data.description ~= nil then
      debug_print("Adding description to embed", 1)
      embed[1].description = data.description
   end

   if data.image ~= nil then
      debug_print("Adding image to embed", 1)
      embed[1].image.url = data.image or Config.Defaults.defaultImage
   end

   if data.fields ~= nil then
      debug_print("Adding fields to embed", 1)
      embed[1].fields = data.fields
   end

   if data.thumbnail ~= nil then
      debug_print("Adding thumbnail to embed", 1)
      embed[1].thumbnail.url = data.thumbnail or Config.Defaults.defaultThumbnail
   end

   local messageToSend = {
      username = data.username or Config.Defaults.defaultUsername, 
      embeds = embed, 
      avatar_url = data.avatar or Config.Defaults.defaultAvatar, 
   }

   if data.mention ~= nil and data.mention ~= false then
      local mention = data.mention or Config.Defaults.defaultMention
      debug_print("Adding mention: "..mention.." to message", 1)
      messageToSend.content = mention
   end

   debug_print("Message: "..json.encode(messageToSend, {indent = true}), 1)

   PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(messageToSend), { ['Content-Type'] = 'application/json' })
end
exports('sendToDiscord', sendToDiscord) -- 


--[[

   EXAMPLE USAGE BELOW

]]

-- exports['gfg_webhook']:sendToDiscord(
--    {
--       webhook = "https://discord.com/api/webhooks/1120011382952300554/19KCBunGo1saG-o_UcqgkLhK6-d3UQeSglISNN9jy5Tr_lIFzDLhmVAt2X-6MolBMKGR",
--       username = "Borat",
--       color = 16776960,
--       avatar = "https://i.imgur.com/lqKlotB.png",
--       thumbnail = "https://i.imgur.com/lqKlotB.png",
--       image = "https://i.imgur.com/i8PFAwg.jpeg",
--       mention = "@borat",
--       title = "Hello Discord",
--       description = "This is a message!",
--       fields = {
--          {
--             name = "First Name",
--             value = "Borat",
--             inline = true
--          },
--          {
--             name = "First Name",
--             value = "Sagdiyev",
--             inline = true
--          },
--          {
--             name = "Country of Origin",
--             value = "Kazakhstan",
--          },
--       }
--    }
-- )


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