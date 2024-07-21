--[[
   _____ _                     _____           _       _       
  / ____| |                   / ____|         (_)     | |      
 | (___ | |_ _____   _____   | (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \| __/ _ \ \ / / _ \   \___ \ / __| '__| | '_ \| __/ __|
  ____) | ||  __/\ V / (_) |  ____) | (__| |  | | |_) | |_\__ \
 |_____/ \__\___| \_/ \___/  |_____/ \___|_|  |_| .__/ \__|___/
                                                | |            
                                                |_|             
	  StevoScripts | https://discord.gg/stevoscripts
]]--	

local Config = lib.require('config')
local stevo_lib = exports['stevo_lib']:import()

if Config.interaction.type ~= "target" then return end

function loadInteractions()


    local options = {
        options = {
            {
            name = 'penis',
            type = "client",
            action = beginExam,
            icon =  Config.interaction.targeticon,
            label = Config.interaction.targetlabel,
            }
        },
        distance = Config.interaction.targetdistance,
        rotation = 45
    }
    
    stevo_lib.target.AddBoxZone('stevo_citizenship:beginExam', Config.examCoords, Config.interaction.targetradius, options)


    
end