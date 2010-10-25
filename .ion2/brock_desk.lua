
-- Goes to the frame in the specified direction. If there is no frame in the
-- given direction, it goes to the next workspace in the direction, being:
-- 	left  = previous workspace
-- 	right = next workspace
--
-- By 2004, Rene van Bevern <rvb@pro-linux.de>
-- 	Public Domain
--
-- If you are about to go to a frame that would be left to the leftmost frame,
-- the function switches to a previous workspace and goes to its rightmost frame.
-- If you are about to go to a frame that would be right of the rightmost frame,
-- the function switches to the next workspace and goes to its leftmost frame.
--
-- To use this function you need to bind keys in the ionws_bindings
--
-- ionws_bindings {
--    kpress(DEFAULT_MOD.."Down", function(f) go_frame_or_desk(f, "down") end),
--    kpress(DEFAULT_MOD.."Up", function(f) go_frame_or_desk(f, "up") end),
--    kpress(DEFAULT_MOD.."Right", function(f) go_frame_or_desk(f, "right") end),
--    kpress(DEFAULT_MOD.."Left", function(f) go_frame_or_desk(f, "left") end)
-- }

function go_frame_or_desk(ws, dir)
	local reg = ws:current()
	local scr = ws:screen_of()
	if ws:next_to(reg,dir)	then ws:goto_dir(dir)
	elseif dir == "left"	then
		scr:switch_prev()
		WRegion.goto(scr:current():rightmost())
	elseif dir == "up"	then
		scr:switch_prev()
		scr:switch_prev()
		scr:switch_prev()
		WRegion.goto(scr:current():lowest())
	elseif dir == "right"	then
		scr:switch_next()
		WRegion.goto(scr:current():leftmost())
	elseif dir == "down"	then
		scr:switch_next()
		scr:switch_next()
		scr:switch_next()
		WRegion.goto(scr:current():highest())
	end
end

