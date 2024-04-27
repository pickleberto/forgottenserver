function spellCallback(cid, position, count)
	-- for every tile, we may or may not spawn a tornado
	-- in the first call (count == 0) we use the random to define if we should spawn or not
	-- for count == 1 and beyond we dont need that as we are already adding a random time between these calls
	if count > 0 or math.random(0, 1) == 1 then
		position:sendMagicEffect(CONST_ME_ICETORNADO)
	end

	-- we will repeat this function for count = 1 and 2 adding a bit of randominess between each call
	if count < 3 then
		count = count + 1
		 -- this random value is what makes only the small tornadoes flash in and out as they have a smaller duration
		addEvent(spellCallback, math.random(650, 1100), cid, position, count) 
	end
end

-- we will do the 'spellCallback' for every tile
function onTargetTile(creature, position)
	spellCallback(creature:getId(), position, 0)
end

local combat = Combat()
-- setting the area for the spell as defined in 'spells.lua'
combat:setArea(createCombatArea(AREA_FRIGO))
-- and setting the callback
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

-- now we just need to execute our 'combat' whenever we cast the spell
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
