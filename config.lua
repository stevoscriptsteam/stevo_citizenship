return {


    autoCheck = true, -- Set to false to use the export
    PassingScore = 4, -- Amount of correct questions required to get citizenship.

    -- DO NOT MODIFY UNLESS YOU ARE GOING TO MODIFY citizenZone.
    spawnCoords = vec4(-1371.2579, -471.2089, 72.0422, 6.8564),
    examCoords = vec3(-1372.2820, -465.5251, 71.8305),
    completionCoords = vec4(-1034.9070, -2733.7327, 20.1693, 331.5052),
    
    citizenZone = { -- Can be created through /zone box
        coords = vec3(-1372.0, -468.0, 72.0),
        size = vec3(6.5, 29.0, 6.5),
        rotation = 5.0
    },

    interaction = { 
        type = 'target', -- Supports 'marker' and 'target' and '3dtext'
        --MARKER
        markerlabel = 'Begin Citizenship Exam',
        markertype = 27, -- https://docs.fivem.net/docs/game-references/markers/
        markercolor = { r = 26, g = 115, b = 179}, -- RGB Color picker: https://g.co/kgs/npUqed1
        markersize = { x = 1.0, y = 1.0, z = 1.0},
        --TARGET
        targeticon = 'fas fa-passport', -- https://fontawesome.com/icons
        targetlabel = 'Begin Citizenship Exam',
        targetradius = vector3(4, 4, 4), 
        targetdistance = 2.0,
    },
    
    Questions = {
        {
            title = 'What is Metagaming?',
            allowCancel = false,
            options = {
                {label = 'Metagaming is the usage of any information your character has not learned within roleplay in the city.', correct = true},
                {label = 'Metagaming is when you try to sell people chicken feet and you don\'t have any chicken feet.', correct = false},
                {label = 'I don\'t know.', correct = false},
                {label = 'Metagaming is when you fail to fear for your life.', correct = false}
            }
        },
        {
            title = 'What is Powergaming?',
            options = {
                {label = 'Powergaming is the usage of your mum\'s credit card to purchase Founders Supporter ;)', correct = false},
                {label = 'Powergaming is the usage of unrealistic forms of roleplay or the outright refusal to roleplay in order to give yourself an unfair advantage.', correct = true},
                {label = 'Powergaming is when you break into someone\'s clubhouse using exploits.', correct = false},
                {label = 'I don\'t know.', correct = false}
            }
        },
        {
            title = 'Are you allowed to use third-party cheating software?',
            options = {
                {label = 'Yes of course, I love eulen!', correct = false},
                {label = 'This is not permitted under any circumstance.', correct = true},
                {label = 'Only if you asked your mum for permission.', correct = false},
                {label = 'I don\'t know.', correct = false}
            }
        },
        {
            title = 'Which one of the below examples is a Green Zone?',
            options = {
                {label = 'Hospitals.', correct = true},
                {label = 'Park Benches.', correct = false},
                {label = 'Everywhere.', correct = false},
                {label = 'All of the above', correct = false}
            }
        },
        {
            title = 'What does breaking character mean?',
            options = {
                {label = 'When you talk out of character within the city.', correct = true},
                {label = 'When you break another player\'s character.', correct = false},
                {label = 'When your uncle isn\'t coming to pick you up from school.', correct = false},
                {label = 'I don\'t know.', correct = false}
            }
        },
        {
            title = 'Which one of these examples is from the Random Death Match rule?',
            options = {
                {label = 'You may not attack another player randomly without first engaging in some form of verbal RP.', correct = true},
                {label = 'You may kill other players for no reason.', correct = false},
                {label = 'You may not purchase water unless you\'re a server supporter.', correct = false},
                {label = 'I don\'t know.', correct = false}
            }
        }
    },
    
}