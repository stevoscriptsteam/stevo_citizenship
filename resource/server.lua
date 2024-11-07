local stevo_lib = exports['stevo_lib']:import()

lib.callback.register('stevo_citizenship:checkCitizenship', function(source)

    local identifier = stevo_lib.GetIdentifier(source)
    local row = MySQL.single.await('SELECT * FROM `stevo_citizenship` WHERE `citizen` = ? LIMIT 1', {
        identifier
    })
     
    if row then 
        return true 
    end

    return false
end)


lib.callback.register('stevo_citizenship:addCitizenship', function(source)

    local identifier = stevo_lib.GetIdentifier(source)
    
    
    MySQL.insert.await('INSERT INTO `stevo_citizenship` (citizen) VALUES (?)', {
        identifier
    })
    
    return true
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end

    
    local tableExists, _ = pcall(MySQL.scalar.await, 'SELECT 1 FROM stevo_citizenship')

    if not tableExists then
        MySQL.query([[CREATE TABLE IF NOT EXISTS `stevo_citizenship` (
        `id` INT NOT NULL AUTO_INCREMENT,
        `citizen` VARCHAR(50) NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `citizen` (`citizen`)
        )]])

        lib.print.info('[Stevo Scripts] Deployed database table for stevo_citizenship')
    end
end)











