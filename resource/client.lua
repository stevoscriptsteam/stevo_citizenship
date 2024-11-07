local config = lib.require('config')
local stevo_lib = exports['stevo_lib']:import()
local examCompleted = false
lib.locale()

function shuffleQuestions(t)
    local shuffled = {}
    for i = #t, 1, -1 do
        local rand = math.random(i)
        t[i], t[rand] = t[rand], t[i]
        table.insert(shuffled, t[i])
    end
    return shuffled
end

function beginExam()
    local ped = PlayerPedId()	
    if ped then
        local alert = lib.alertDialog({
            header = locale('alertdialog.startExamHeader'),
            content = locale('alertdialog.startExamContent'),
            centered = true,
            cancel = true,
            labels = {
                confirm = locale('text.beginExam'),
                cancel = locale('text.cancelExam'),
            }
        })
        if alert == 'cancel' then
            return
        end

        local score = 0
        local questions = shuffleQuestions(config.Questions)
        for _, question in ipairs(questions) do
            :: StartQuestion ::
            local options = {}
            for _, option in ipairs(question.options) do
                table.insert(options, {type = 'checkbox', label = option.label})
            end
            local input = lib.inputDialog(question.title, options)
            if not input then 
                stevo_lib.Notify(locale('notify.cancelNotify'), 'error')
                return
            end
            local answers = 0
            for i, answer in ipairs(input) do
                if answer then
                    answers = answers + 1
                end
            end
            if answers == #input then 
                stevo_lib.Notify(locale('notify.selectAll'), 'error') 
                goto StartQuestion 
            end
            for i, answer in ipairs(input) do
                if answer and question.options[i].correct then
                    score = score + 1
                end
            end
        end

        if score >= config.PassingScore then
            lib.alertDialog({
                header = locale('alertdialog.successHeader'),
                content = locale('alertdialog.successContent'),
                centered = true,
                cancel = false,
                labels = {
                    confirm = locale('text.passPlay'),
                    cancel = locale('text.passCancel'),
                }
            })
            lib.callback.await('stevo_citizenship:addCitizenship', false)
            examCompleted = true
            DoScreenFadeOut(800)
            Wait(800)
            SetEntityCoords(ped, config.completionCoords, 1, 0, 0, 1)
            SetEntityHeading(ped, config.completionCoords.h)
            Wait(500)
            DoScreenFadeIn(1000)
        else
            lib.alertDialog({
                header = locale('alertdialog.failedHeader'),
                content = locale('alertdialog.failedContent'),
                centered = true,
                cancel = false,
                labels = {
                    confirm = locale('text.failedConfirm'),
                    cancel = locale('text.failedCancel'),
                }
            })
        end
    end
end

function escapeCitizenship()
    if examCompleted then return end
    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)

    SetEntityCoords(cache.ped, config.spawnCoords.x, config.spawnCoords.y, config.spawnCoords.z)
    SetEntityHeading(cache.ped, config.spawnCoords.h)
    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000) 
    stevo_lib.Notify(locale('notify.escaped'), 'error', 3000)
end

function loadCitizenship()
    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)
    
    SetEntityCoords(cache.ped, config.spawnCoords.x, config.spawnCoords.y, config.spawnCoords.z)
    SetEntityHeading(cache.ped, config.spawnCoords.h)

    local citizenZone = lib.zones.box({
        name = "citizenZone",
        coords = config.citizenZone.coords,
        size = config.citizenZone.size,
        rotation = config.citizenZone.rotation,
    })

    function citizenZone:onExit(self)
        if examCompleted then 
            citizenZone:remove() 
            return 
        end
        escapeCitizenship()
    end

    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000) 

    stevo_lib.Notify(locale('notify.loaded'), 'info', 3000)
end

local function playerLoaded()
    local isCitizen = lib.callback.await('stevo_citizenship:checkCitizenship', false)

    if not isCitizen then
        loadCitizenship()
    end
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end
    playerLoaded()
end)

RegisterNetEvent('stevo_lib:playerLoaded', function()
    if not config.autoCheck then return end

    playerLoaded()
end)

exports('playerLoaded', playerLoaded)

CreateThread(function()
    if config.interaction.type == "marker" then
        local point = lib.points.new({
            coords = config.examCoords,
            distance = 8,
        })  
    function point:nearby()
        DrawMarker(config.interaction.markertype, config.examCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, config.interaction.markersize.x, config.interaction.markersize.y, config.interaction.markersize.z,  config.interaction.markercolor.r, config.interaction.markercolor.g, config.interaction.markercolor.b, 200, false, true, 2.0, false, false, false, false)
        local onScreen, _x, _y = World3dToScreen2d(config.examCoords.x, config.examCoords.y, config.examCoords.z+1)
        if onScreen then
            SetTextScale(0.4, 0.4)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString("[~b~E~w~] "..config.interaction.markerlabel.."")
            DrawText(_x, _y)
        end
        if self.currentDistance < 3 and IsControlJustReleased(0, 38) then
            beginExam()
        end
    end
end
    if config.interaction.type == "target" then 
        local options = {
            options = {
                {
                name = 'citizenship',
                type = "client",
                action = beginExam,
                icon =  config.interaction.targeticon,
                label = config.interaction.targetlabel,
                }
            },
            distance = config.interaction.targetdistance,
            rotation = 45
        }
        stevo_lib.target.AddBoxZone('stevo_citizenship:beginExam', config.examCoords, config.interaction.targetradius, options)    
    end
    if config.interaction.type == "3dtext" then 
        local point = lib.points.new({
            coords = config.examCoords,
            distance = 8,
        })
    function point:nearby()
        local onScreen, _x, _y = World3dToScreen2d(config.examCoords.x, config.examCoords.y, config.examCoords.z+1)
        if onScreen then
            SetTextScale(0.4, 0.4)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString("[~b~E~w~] "..config.interaction.markerlabel.."")
            DrawText(_x, _y)
        end
        if self.currentDistance < 3 and IsControlJustReleased(0, 38) then
            beginExam()
        end
    end
end
end)


