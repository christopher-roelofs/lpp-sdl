
-- Init the lpp-vita sound engine
Sound.init();

March22.ACTIVEMUSICTRACK_NAME = "";

-- Plays the specified music track
function March22.PlayTrack(_name)
	if LOADEDMUSIC[_name] == nil then
		return;
	else
		if March22.ACTIVEMUSICTRACK == nil then
		
		else
			Sound.pause(March22.ACTIVEMUSICTRACK);
		end
		March22.ACTIVEMUSICTRACK = LOADEDMUSIC[_name];
		March22.ACTIVEMUSICTRACK_NAME = _name;
		Sound.play(March22.ACTIVEMUSICTRACK,LOOP);
	end
end
