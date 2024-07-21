fx_version "cerulean"
game "gta5"

author "StevoScripts | steve"
description "Citizenship Exam System for preventing trolls!"
version "1.2.0"

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'resource/client.lua',
    'resource/interactions/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/server.lua',
}

dependencies {
    'ox_lib',
    'oxmysql',
    'stevo_lib',
    '/server:4500',
}
   

lua54 "yes"





