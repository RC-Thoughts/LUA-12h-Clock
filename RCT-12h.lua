--[[
	---------------------------------------------------------
    RCT Clock is a clock to display time in 12-hour format
	
	Both big and small window available for main screen.
	
	For DC/DS-16/24. No settings required.
	---------------------------------------------------------
	RCT Clock is part of RC-Thoughts Jeti Tools.
	---------------------------------------------------------
	Released under MIT-license by Tero @ RC-Thoughts.com 2016
	---------------------------------------------------------
--]]
collectgarbage()
----------------------------------------------------------------------
-- Locals for the application
local timeOrg, timeHour, timeSym
----------------------------------------------------------------------
-- Draw the telemetry windows
local function printClock(width, height)
	if(timeDisp) then
		if(height > 25) then
			lcd.drawText((150 - lcd.getTextWidth(FONT_BIG,timeDisp))/2,22,timeDisp,FONT_BIG)
			else
			lcd.drawText(147 - lcd.getTextWidth(FONT_BOLD,timeDisp),2,timeDisp,FONT_BOLD)
		end
	end
end
----------------------------------------------------------------------
local function loop()
	local timeOrg = system.getDateTime()
	local timeHour = tonumber(timeOrg.hour)
	if(timeHour == 12) then
		timeSym = "pm"
	end
	if(timeHour < 12) then
		timeSym = "am"
	end
	if(timeHour == 0) then
		timeHour  = 12
		timeSym = "am"
	end
	if(timeHour >= 13) then
		timeHour = timeHour - 12
		timeSym = "pm"
	end
	timeDisp = ((string.format("%d:%02d:%02d", timeHour, timeOrg.min, timeOrg.sec, timeSym)).. " " .. timeSym)
end
----------------------------------------------------------------------
-- Application initialization
local function init()
	system.registerTelemetry(1,"Clock",0,printClock)
end
----------------------------------------------------------------------
ampmVersion = "1.1"
collectgarbage()
return {init=init, loop=loop, author="RC-Thoughts", version=ampmVersion, name="RCT Clock"}