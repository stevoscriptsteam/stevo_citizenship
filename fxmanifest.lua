fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

author 'StevoScripts | steve & s4t4n'
description 'Citizenship Exam System for preventing trolls!'
version '1.2.5'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'resource/client.lua',
}

server_scripts {
    'resource/server.lua',
    '@oxmysql/lib/MySQL.lua'
}

files {
    'locales/*.json'
}

dependencies {
    'ox_lib'
}





