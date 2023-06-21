fx_version 'cerulean'
game 'gta5'
author 'GFG'
description 'GFG Webhook'
version '1.0.0'
lua54 'yes'

client_scripts {
    'client/cl_**.lua',
    'locale/*.lua',
}

server_scripts {
    'server/sv_**.lua',
    'locale/*.lua',
}

shared_scripts {
    'shared/**.lua',
}

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
    'shared/*.lua',
    'locale/*.lua',
    'README.md',
    'EULA.md',
}
