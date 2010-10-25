-- A version of WIonWS.goto_dir that may be useful on multihead setups

function goto_multihead(ws, dir)
    if dir=="up" or dir=="down" then
        ws:goto_dir(dir)
        return
    end
    
    local nxt, nxtscr
    
    nxt=ws:next_to(ws:current(), dir)
    
    if not nxt then
        local otherdir
        local fid=find_screen_id
        if dir=="right" then
            otherdir="left"
            nxtscr=fid(ws:screen_of():id()+1) or fid(0)
        else
            otherdir="right"
            nxtscr=fid(ws:screen_of():id()-1) or fid(-1)
        end
        nxt=nxtscr:current()
        if obj_is(nxt, "WIonWS") then
            nxt=nxt:farthest(otherdir)
        end
    end
    
    nxt:goto()
end
