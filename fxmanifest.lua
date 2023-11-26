fx_version 'bodacious'
game { 'gta5' }

lua54 'yes'
description 'ox-methcar by Samuel, Edited by Griefa'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script "client.lua"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server.lua',
}
