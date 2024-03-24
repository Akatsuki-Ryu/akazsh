-- ~/.config/nvim/lua/plugins/copilot.lua
-- copilot configuration
return {
    "zbirenbaum/copilot.lua",

    opts = {
        suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<leader><Tab>" } },
        panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>",
            },
            layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4,
            },
        },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}
-- For additional configurations for the copilot panel, suggestions, filetypes supported, etc
-- see https://github.com/zbirenbaum/copilot.lua
