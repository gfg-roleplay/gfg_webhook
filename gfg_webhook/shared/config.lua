Config = {
    language = "en",                                            -- Language sets which Locale to use, you can find available locales in [gfg_webhook/locale/], we will add more as they become available but feel free to add your own.
    debug = true,                                               -- Determines whether to send debug print statements to the client and server when using the script (Debug should only used in a development environment)
    utcOffset = 4,                                              -- Determines your timezone offset from UTC (e.x: EST would be 4 (without daylight savings))
}

Config.Defaults = {
    defaultWebhook = "https://discord.com/api/webhooks/1120011382952300554/19KCBunGo1saG-o_UcqgkLhK6-d3UQeSglISNN9jy5Tr_lIFzDLhmVAt2X-6MolBMKGR",   -- Determines the default channel webhook to send messages to if omitted.
    defaultUsername = "GFG Webhook",                            -- Determines the default username to use if omitted.
    defaultAvatar = "https://i.imgur.com/Y4nltZW.png",          -- Determines the default profile picture if omitted.
    defaultTitle = "Saucy Title",                               -- Determines the default title of the embed if omitted.
    defaultThumbnail = "https://i.imgur.com/Y4nltZW.png",       -- Determines the default thumbnail of embed if omitted.
    defaultColor = 15658734,                                    -- Determines the default color of the embed if omitted.
    defaultMention = "@everyone",                               -- Determines the default mention if mention is only set to "true".
}