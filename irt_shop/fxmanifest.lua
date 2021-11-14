fx_version 'adamant'
game 'gta5'

client_scripts {
    "libs/RMenu.lua",
    "libs/menu/RageUI.lua",
    "libs/menu/Menu.lua",
    "libs/menu/MenuController.lua",
    "libs/components/*.lua",
    "libs/menu/elements/*.lua",
    "libs/menu/items/*.lua",
    "libs/menu/panels/*.lua",
    "libs/menu/panels/*.lua",
    "libs/menu/windows/*.lua"
}

client_scripts {
    "client/client.lua"
}

shared_script {
    "shared/*.lua"
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

dependencies {
	'es_extended'
}
