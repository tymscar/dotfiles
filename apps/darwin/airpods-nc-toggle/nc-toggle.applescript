tell application "System Events"
	tell application process "ControlCenter"
		click menu bar item 3 of menu bar 1
		delay 0.02
		set allElements to entire contents of window 1
		if value of item 16 of allElements is 1 then
			click item 14 of allElements
		else
			click item 16 of allElements
		end if
		key code 53
	end tell
end tell
