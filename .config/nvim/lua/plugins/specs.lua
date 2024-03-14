return {
    {
        "edluffy/specs.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            show_jumps = true,
            min_jump = 1,
            popup = {
                delay_ms = 0, -- delay before popup displays
                inc_ms = 6, -- time increments used for fade/resize effects
                blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
                width = 100,
                winhl = "PMenu",
                --winhl = "Search",
                fader = require("specs").linear_fader,
                resizer = require("specs").shrink_resizer,
            },
            --popup = {
            --  -- Simple constant blend effect

            --  fader = function(blend, cnt)
            --    if cnt > 100 then
            --      return 80
            --    else return nil end
            --  end,
            --  -- Growing effect from left to right
            --  resizer = function(width, ccol, cnt)
            --    if width-cnt > 0 then
            --      return {width+cnt, ccol}
            --    else return nil end
            --  end,
            --},
            ignore_filetypes = {},
            ignore_buftypes = {
                nofile = true,
            },
        },
    },
}
