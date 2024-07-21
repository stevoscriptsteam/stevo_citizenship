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

if Config.interaction.type ~= "marker" then return end


function loadInteractions()

    local point = lib.points.new({
        coords = Config.examCoords,
        distance = 8,
    })

    function point:nearby()
    
        DrawMarker(Config.interaction.markertype, Config.examCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.interaction.markersize.x, Config.interaction.markersize.y, Config.interaction.markersize.z,  Config.interaction.markercolor.r, Config.interaction.markercolor.g, Config.interaction.markercolor.b, 200, false, true, 2.0, false, false, false, false)
        
        local onScreen, _x, _y = World3dToScreen2d(Config.examCoords.x, Config.examCoords.y, Config.examCoords.z+1)
    
        if onScreen then
            SetTextScale(0.4, 0.4)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString("[~b~E~w~] "..Config.interaction.markerlabel.."")
            DrawText(_x, _y)
        end
    
        if self.currentDistance < 3 and IsControlJustReleased(0, 38) then
            beginExam()
        end
    end
end
