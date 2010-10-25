-- Put the function make_current_clientwin_fn(detach_topmost_transient)
-- in e.g. ionframe_bindings to use this.

function detach_topmost_transient(cwin)
    local l=cwin:managed_list()
    local trs=l[table.getn(l)]
    if trs then
        cwin:manager():attach(trs)
    end
end

