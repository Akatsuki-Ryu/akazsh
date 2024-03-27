return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#65D1FF",
            green = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            red = "#FF4A4A",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive_bg = "#2c3043",
        }

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.semilightgray },
                c = { bg = colors.inactive_bg, fg = colors.semilightgray },
            },
        }

        -- configure lualine with modified theme
        lualine.setup({
            options = {
                theme = my_lualine_theme,
                -- section_separators = { "", "" },
                -- component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                icons_enabled = true,
                -- theme = "gruvbox",
                -- theme = "tokyonight",
                -- theme = "nord",
                -- theme = "onedark",
                -- theme = "gruvbox",
                -- theme = "gruvbox_material",
                -- theme = "gruvbox_light
            },
            sections = {
                -- lualine_a = {'mode'},
                -- lualine_x = {'encoding', 'fileformat', 'filetype'},
                -- lualine_y = { "progress" },
                -- lualine_z = { "location" },
                lualine_a = {
                    { "mode", upper = true },
                },
                -- lualine_b = { "branch", "diff", "diagnostics" },
                lualine_b = {
                    { "branch", icon = "" },
                    { "diff", colored = true },
                    -- { "diagnostics", sources = { "nvim_lsp" } },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        color_error = "#ff4a4a",
                        color_warn = "#ffda7b",
                        color_info = "#3effdc",
                        color_hint = "#ff61ef",
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    },
                    { "gitsigns", padding = { left = 0, right = 0 } },
                    { "filename", file_status = true, path = 1 },
                    -- { "os.date('%a')", "data", "require'lsp-status'.status()" },
                },
                lualine_x = {
                    { "copilot", show_colors = true },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding" },
                    -- { "fileformat" },
                },
                lualine_y = {
                    { "filetype", icon = "" },
                    -- { "progress", color = { fg = "#ff9e64" } },
                    -- { "location", color = { fg = "#ff9e64" } },
                },
                lualine_z = {
                    { "progress" },
                    { "location", icon = "" },
                },
            },
        })
    end,
}
