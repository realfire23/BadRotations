if select(2, UnitClass("player")) == "DRUID" then
	local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
	local function createToggles()
    -- Rotation Button
        RotationModes = {
            [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = bb.player.spell.swipe },
            [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = bb.player.spell.swipe },
            [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = bb.player.spell.shred },
            [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = bb.player.spell.regrowth}
        };
        CreateButton("Rotation",1,0)
    -- Cooldown Button
        CooldownModes = {
            [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = bb.player.spell.berserk },
            [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = bb.player.spell.berserk },
            [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = bb.player.spell.berserk }
        };
       	CreateButton("Cooldown",2,0)
    -- Defensive Button
        DefensiveModes = {
            [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = bb.player.spell.survivalInstincts },
            [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = bb.player.spell.survivalInstincts }
        };
        CreateButton("Defensive",3,0)
    -- Interrupt Button
        InterruptModes = {
            [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = bb.player.spell.skullBash },
            [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = bb.player.spell.skullBash }
        };
        CreateButton("Interrupt",4,0)       
    -- Cleave Button
		CleaveModes = {
            [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.", highlight = 1, icon = bb.player.spell.thrash },
            [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets", highlight = 0, icon = bb.player.spell.thrash }
        };
        CreateButton("Cleave",5,0)
    -- Prowl Button
		ProwlModes = {
            [1] = { mode = "On", value = 1 , overlay = "Prowl Enabled", tip = "Rotation will use Prowl", highlight = 1, icon = bb.player.spell.prowl },
            [2] = { mode = "Off", value = 2 , overlay = "Prowl Disabled", tip = "Rotation will not use Prowl", highlight = 0, icon = bb.player.spell.prowl }
        };
        CreateButton("Prowl",6,0)
    end

---------------
--- OPTIONS ---
---------------
	local function createOptions()
        local optionTable

        local function rotationOptions()
            local section
        -- General Options
            section = bb.ui:createSection(bb.ui.window.profile, "General")
            -- APL
                bb.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFFSet APL Mode to use.")
            -- Death Cat
                bb.ui:createCheckbox(section,"Death Cat Mode","|cff15FF00Enable|cffFFFFFF/|cffD60000Disable |cffFFFFFFthis mode when running through low level content where you 1 hit kill mobs.")
            -- Fire Cat
                bb.ui:createCheckbox(section,"Perma Fire Cat","|cff15FF00Enable|cffFFFFFF/|cffD60000Disable |cffFFFFFFautomatic use of Fandrel's Seed Pouch or Burning Seeds.")
            -- Dummy DPS Test
                bb.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            -- Pre-Pull Timer
                bb.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Travel Shapeshifts
                bb.ui:createCheckbox(section,"Auto Shapeshifts","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to best form for situation.|cffFFBB00.")
            -- Break Crowd Control
                bb.ui:createCheckbox(section,"Break Crowd Control","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to break crowd control.|cffFFBB00.")
            -- Wild Charge
                bb.ui:createCheckbox(section,"Displacer Beast / Wild Charge","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Charge usage.|cffFFBB00.")
            -- Brutal Slash Targets
                bb.ui:createSpinner(section,"Brutal Slash Targets", 3, 1, 10, 1, "|cffFFFFFFSet to desired targets to use Brutal Slash on. Min: 1 / Max: 10 / Interval: 1")
            -- Artifact 
                bb.ui:createDropdownWithout(section,"Artifact", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Artifact Ability.")
            bb.ui:checkSectionState(section)
        -- Cooldown Options
            section = bb.ui:createSection(bb.ui.window.profile, "Cooldowns")
            -- Agi Pot
                bb.ui:createCheckbox(section,"Agi-Pot")
            -- Flask / Crystal
                bb.ui:createCheckbox(section,"Flask / Crystal")
            -- Berserk
                bb.ui:createCheckbox(section,"Berserk")
            -- Legendary Ring
                bb.ui:createCheckbox(section,"Legendary Ring")
            -- Racial
                bb.ui:createCheckbox(section,"Racial")
            -- Tiger's Fury
                bb.ui:createCheckbox(section,"Tiger's Fury")
            -- Incarnation: King of the Jungle
                bb.ui:createCheckbox(section,"Incarnation")
            -- Trinkets
                bb.ui:createCheckbox(section,"Trinkets")
            bb.ui:checkSectionState(section)
        -- Defensive Options
            section = bb.ui:createSection(bb.ui.window.profile, "Defensive")
            -- Rebirth
                bb.ui:createCheckbox(section,"Rebirth")
                bb.ui:createDropdownWithout(section, "Rebirth - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
            -- Revive
                bb.ui:createCheckbox(section,"Revive")
                bb.ui:createDropdownWithout(section, "Revive - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
            -- Remove Corruption
                bb.ui:createCheckbox(section,"Remove Corruption")
                bb.ui:createDropdownWithout(section, "Remove Corruption - Target", {"|cff00FF00Player","|cffFFFF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
            -- Renewal
                bb.ui:createSpinner(section, "Renewal",  75,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Healthstone
                bb.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Heirloom Neck
                bb.ui:createSpinner(section, "Heirloom Neck",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            -- Engineering: Shield-o-tronic
                bb.ui:createSpinner(section, "Shield-o-tronic",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Survival Instincts
                bb.ui:createSpinner(section, "Survival Instincts",  40,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Regrowth
                bb.ui:createSpinner(section, "Regrowth",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Dream of Cenarius Auto-Heal
                bb.ui:createDropdown(section, "Auto Heal", { "|cffFFDD11LowestHP", "|cffFFDD11Player"},  1,  "|cffFFFFFFSelect Target to Auto-Heal")
            bb.ui:checkSectionState(section)
        -- Interrupt Options
            section = bb.ui:createSection(bb.ui.window.profile, "Interrupts")
            -- Skull Bash
                bb.ui:createCheckbox(section,"Skull Bash")
            -- Mighty Bash
                bb.ui:createCheckbox(section,"Mighty Bash")
            -- Maim
                bb.ui:createCheckbox(section,"Maim")
            -- Interrupt Percentage
                bb.ui:createSpinner(section, "Interrupts",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
            bb.ui:checkSectionState(section)
        -- Toggle Key Options
            section = bb.ui:createSection(bb.ui.window.profile, "Toggle Keys")
            -- Single/Multi Toggle
                bb.ui:createDropdown(section, "Rotation Mode", bb.dropOptions.Toggle,  4)
            -- Cooldown Key Toggle
                bb.ui:createDropdown(section, "Cooldown Mode", bb.dropOptions.Toggle,  3)
            -- Defensive Key Toggle
                bb.ui:createDropdown(section, "Defensive Mode", bb.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
                bb.ui:createDropdown(section, "Interrupt Mode", bb.dropOptions.Toggle,  6)
            -- Cleave Toggle
                bb.ui:createDropdown(section, "Cleave Mode", bb.dropOptions.Toggle,  6)
            -- Prowl Toggle
                bb.ui:createDropdown(section, "Prowl Mode", bb.dropOptions.Toggle,  6)
            -- Pause Toggle
                bb.ui:createDropdown(section, "Pause Mode", bb.dropOptions.Toggle,  6)
            bb.ui:checkSectionState(section)
        end
        optionTable = {{
            [1] = "Rotation Options",
            [2] = rotationOptions,
        }}
        return optionTable
    end

----------------
--- ROTATION ---
----------------
	local function runRotation()
        if bb.timer:useTimer("debugFeral", math.random(0.15,0.3)) then
            --print("Running: "..rotationName)

    ---------------
	--- Toggles ---
	---------------
	        UpdateToggle("Rotation",0.25)
	        UpdateToggle("Cooldown",0.25)
	        UpdateToggle("Defensive",0.25)
	        UpdateToggle("Interrupt",0.25)
	        UpdateToggle("Cleave",0.25)
	        UpdateToggle("Prowl",0.25)

	--------------
	--- Locals ---
    --------------
            local addsExist                                     = false 
            local addsIn                                        = 999
            local animality                                     = false
            local artifact                                      = bb.player.artifact
            local buff                                          = bb.player.buff
            local canFlask                                      = canUse(bb.player.flask.wod.agilityBig)
            local cast                                          = bb.player.cast
            local clearcast                                     = bb.player.buff.clearcasting
            local combatTime                                    = getCombatTime()
            local combo                                         = bb.player.comboPoints
            local cd                                            = bb.player.cd
            local charges                                       = bb.player.charges
            local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
            local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or ObjectExists("target"), UnitIsPlayer("target")
            local debuff                                        = bb.player.debuff
            local enemies                                       = bb.player.enemies
            local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
            local fatality                                      = false
            local flaskBuff                                     = getBuffRemain("player",bb.player.flask.wod.buff.agilityBig)
            local friendly                                      = friendly or UnitIsFriend("target", "player")
            local gcd                                           = bb.player.gcd
            local hasMouse                                      = ObjectExists("mouseover")
            local healPot                                       = getHealthPot()
            local inCombat                                      = bb.player.inCombat
            local inInstance                                    = bb.player.instance=="party"
            local inRaid                                        = bb.player.instance=="raid"
            local level                                         = bb.player.level
            local lootDelay                                     = getOptionValue("LootDelay")
            local lowestHP                                      = bb.friend[1].unit
            local mfTick                                        = 20.0/(1+UnitSpellHaste("player")/100)/10
            local mode                                          = bb.player.mode
            local multidot                                      = (useCleave() or bb.player.mode.rotation ~= 3)
            local perk                                          = bb.player.perk        
            local php                                           = bb.player.health
            local playerMouse                                   = UnitIsPlayer("mouseover")
            local potion                                        = bb.player.potion
            local power, powmax, powgen                         = bb.player.power, bb.player.powerMax, bb.player.powerRegen
            local pullTimer                                     = bb.DBM:getPulltimer()
            local racial                                        = bb.player.getRacial()
            local recharge                                      = bb.player.recharge
            local rkTick                                        = 3
            local rpTick                                        = 2
            local solo                                          = bb.player.instance=="none"
            local spell                                         = bb.player.spell
            local stealth                                       = bb.player.stealth
            local t17_2pc                                       = TierScan("T17")>=2 --bb.player.eq.t17_2pc
            local t18_2pc                                       = TierScan("T18")>=2 --bb.player.eq.t18_2pc 
            local t18_4pc                                       = TierScan("T18")>=4 --bb.player.eq.t18_4pc
            local talent                                        = bb.player.talent
            local travel, flight, bear, noform                   = bb.player.buff.travelForm, bb.player.buff.flightForm, bb.player.buff.bearForm, GetShapeshiftForm()==0
            local trinketProc                                   = false
            local ttd                                           = getTTD
            local ttm                                           = bb.player.timeToMax
            local units                                         = bb.player.units
            
	   		if leftCombat == nil then leftCombat = GetTime() end
			if profileStop == nil then profileStop = false end
			if lastSpellCast == nil then lastSpellCast = spell.bearForm end
            if lastForm == nil then lastForm = 0 end

	--------------------
	--- Action Lists ---
	--------------------
		-- Action List - Extras
			local function actionList_Extras()
			-- Shapeshift Form Management
				if isChecked("Auto Shapeshifts") and not UnitBuffID("player",202477) then
				-- Flight Form
					if IsFlyableArea() and ((not (isInDraenor() or isInLegion())) or isKnown(191633)) and not swimming and falling > 1 and level>=58 then 
		                if cast.travelForm() then return end
			        end
				-- Aquatic Form
				    if swimming and not travel and not hastar and not deadtar then
					  	if cast.travelForm() then return end
					end
				-- -- Cat Form
				-- 	if not cat then
				--     	-- Cat Form when not swimming or flying or stag and not in combat
				--     	if not inCombat and moving and not swimming and not flying and not travel then
			 --        		if cast.catForm() then return end
			 --        	end
			 --        	-- Cat Form when not in combat and target selected and within 20yrds
			 --        	if not inCombat and hastar and attacktar and not deadtar and getDistance("target")<20 then
			 --        		if cast.catForm() then return end
			 --        	end
			 --        	--Cat Form when in combat and not flying
			 --        	if inCombat and not flying then
			 --        		if cast.catForm() then return end
			 --        	end
			 --        end
				end -- End Shapeshift Form Management 
			-- Dummy Test
				if isChecked("DPS Testing") then
					if ObjectExists("target") then
						if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
							StopAttack()
							ClearTarget()
							print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
							profileStop = true
						end
					end
				end -- End Dummy Test
			end -- End Action List - Extras
		-- Action List - Defensive
			local function actionList_Defensive()
				if useDefensive() and not stealth and not flight then
			--Revive/Rebirth
					if isChecked("Rebirth") then
						if buff.remain.predatorySwiftness>0 then
							if getOptionValue("Rebirth - Target")==1 then
								if cast.rebirth("target") then return end
							end
							if getOptionValue("Rebirth - Target")==2 then
								if cast.rebirth("mouseover") then return end
							end
						end
					end
					if isChecked("Revive") then
						if getOptionValue("Revive - Target")==1 then
							if cast.revive("target") then return end
						end
						if getOptionValue("Revive - Target")==2 then
							if cast.revive("mouseover") then return end
						end
					end
			-- Pot/Stoned
		            if isChecked("Pot/Stoned") and php <= getOptionValue("Pot/Stoned") 
		            	and inCombat and (hasHealthPot() or hasItem(5512)) 
		            then
	                    if canUse(5512) then
	                        useItem(5512)
	                    elseif canUse(healPot) then
	                        useItem(healPot)
	                    end
		            end
		    -- Heirloom Neck
		    		if isChecked("Heirloom Neck") and php <= getOptionValue("Heirloom Neck") then
		    			if hasEquiped(122668) then
		    				if GetItemCooldown(122668)==0 then
		    					useItem(122668)
		    				end
		    			end
		    		end
	    		end -- End Defensive Toggle
			end -- End Action List - Defensive
		-- Action List - Interrupts
			local function actionList_Interrupts()
				if useInterrupts() then

			 	end -- End useInterrupts check
			end -- End Action List - Interrupts
		-- Action List - Cooldowns
			local function actionList_Cooldowns()
				if getDistance(units.dyn5) < 5 then
			-- Trinkets
                    -- TODO: if=(buff.tigers_fury.up&(target.time_to_die>trinket.stat.any.cooldown|target.time_to_die<45))|buff.incarnation.remains>20
					if useCDs() and isChecked("Trinkets") and getDistance(units.dyn5) < 5 then
                        if (buff.tigersFury and (ttd(units.dyn5) > 60 or ttd(units.dyn5) < 45)) or buff.remain.incarnationKingOfTheJungle > 20 then 
    						if canUse(13) then
    							useItem(13)
    						end
    						if canUse(14) then
    							useItem(14)
    						end
                        end
					end
            -- Agi-Pot
                    -- if=((buff.berserk.remains>10|buff.incarnation.remains>20)&(target.time_to_die<180|(trinket.proc.all.react&target.health.pct<25)))|target.time_to_die<=40
                    if useCDs() and isChecked("Agi-Pot") and canUse(agiPot) and inRaid then
                        if ((buff.remain.berserk > 10 or buff.remain.incarnationKingOfTheJungle > 20) and (ttd(units.dyn5) < 180 or (trinketProc and thp(units.dyn5)<25))) or ttd(units.dyn5)<=40 then
                            useItem(agiPot);
                            return true
                        end
                    end
            -- Legendary Ring
                    -- use_item,slot=finger1
                    if useCDs() and isChecked("Legendary Ring") then
                        if hasEquiped(124636) and canUse(124636) then
                            useItem(124636)
                            return true
                        end
                    end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                    -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                    if useCDs() and isChecked("Racial") and (bb.player.race == "Orc" or bb.player.race == "Troll" or bb.player.race == "BloodElf") then
                        if buff.tigersFury then
                            if castSpell("player",racial,false,false,false) then return end
                        end
                    end
                end -- End useCooldowns check
            end -- End Action List - Cooldowns
        -- Action List - SBTOpener
            local function actionList_SBTOpener()

            end
        -- Action List - Finisher
            local function actionList_Finisher()

            end
        -- Action List - Generator
            local function actionList_Generator()

            end
        -- Action List - PreCombat
            local function actionList_PreCombat()
                if not inCombat and not (IsFlying() or IsMounted()) then
                    if not stealth then
            -- Flask / Crystal
                        -- flask,type=flask_of_the_seventh_demon
                        if isChecked("Flask / Crystal") and not stealth then
                            if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",188033) then
                                useItem(bb.player.flask.wod.agilityBig)
                                return true
                            end
                            if flaskBuff==0 then
                                if not UnitBuffID("player",188033) and canUse(118922) then --Draenor Insanity Crystal
                                    useItem(118922)
                                    return true
                                end
                            end
                        end
                    end -- End No Stealth
                end -- End No Combat
            end -- End Action List - PreCombat 
    ---------------------
    --- Begin Profile ---
    ---------------------
        -- Profile Stop | Pause
            if not inCombat and not hastar and profileStop==true then
                profileStop = false
            elseif (inCombat and profileStop==true) or pause() or mode.rotation==4 then
                return true
            else
    -----------------------
    --- Extras Rotation ---
    -----------------------
                if actionList_Extras() then return end
    --------------------------
    --- Defensive Rotation ---
    --------------------------
                if actionList_Defensive() then return end
    ------------------------------
    --- Out of Combat Rotation ---
    ------------------------------
                if actionList_PreCombat() then return end
    --------------------------
    --- In Combat Rotation ---
    --------------------------
            -- Cat is 4 fyte!
                if inCombat and not bear and not (flight or travel) then
                    -- if cast.catForm() then return end
                elseif inCombat and bear and profileStop==false and isValidUnit("target") then

        ------------------------------
        --- In Combat - Interrupts ---
        ------------------------------
                    if actionList_Interrupts() then return end
        -----------------------------
        --- In Combat - Cooldowns ---
        -----------------------------
                    if actionList_Cooldowns() then return end
        ---------------------------
        --- SimulationCraft APL ---
        ---------------------------
                    if getOptionValue("APL Mode") == 1 then

                    end -- End SimC APL
        ------------------------
        --- Ask Mr Robot APL ---
        ------------------------
                    if getOptionValue("APL Mode") == 2 then

                    end
				end --End In Combat
			end --End Rotation Logic
        end -- End Timer
    end -- End runRotation
    tinsert(cFeral.rotations, {
        name = rotationName,
        toggles = createToggles,
        options = createOptions,
        run = runRotation,
    })
end --End Class Check