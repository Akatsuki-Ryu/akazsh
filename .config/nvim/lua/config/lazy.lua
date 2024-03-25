local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                colorscheme = "tokyonight-night",
                news = {
                    lazyvim = true,
                    neovim = true,
                },
            },
        },
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },
        {
            "edluffy/specs.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },

        -- Minimal configuration for local ai plugins , but we will use both for now
        -- { "David-Kunz/gen.nvim" },

        -- Custom Parameters (with defaults)
        {
            "David-Kunz/gen.nvim",
            opts = {
                -- model = "deepseek-coder:6.7b-instruct",
                host = "akaboxpc",
                display_mode = "split", -- The display mode. Can be "float" or "split".
                -- show_prompt = true, -- Shows the prompt submitted to Ollama.
                show_model = true, -- Displays which model you are using at the beginning of your chat session.
                -- no_auto_close = true, -- Never closes the window automatically.
            },
            -- opts = {
            --     model = "mistral", -- The default model to use.
            --     host = "localhost", -- The host running the Ollama service.
            --     -- host = "akaboxpc", -- The host running the Ollama service.
            --     port = "11434", -- The port on which the Ollama service is listening.
            --     quit_map = "q", -- set keymap for close the response window
            --     retry_map = "<c-r>", -- set keymap to re-send the current prompt
            --     init = function(options)
            --         pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
            --     end,
            --     -- Function to initialize Ollama
            --     command = function(options)
            --         local body = { model = opts.model, stream = true }
            --         return "curl --silent --no-buffer -X POST http://"
            --             .. options.host
            --             .. ":"
            --             .. options.port
            --             .. "/api/chat -d $body"
            --     end,
            --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            --     -- This can also be a command string.
            --     -- The executed command must return a JSON object with { response, context }
            --     -- (context property is optional).
            --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            --     display_mode = "float", -- The display mode. Can be "float" or "split".
            --     show_prompt = false, -- Shows the prompt submitted to Ollama.
            --     show_model = false, -- Displays which model you are using at the beginning of your chat session.
            --     no_auto_close = false, -- Never closes the window automatically.
            --     debug = false, -- Prints errors and the command which is run.
            -- },
        },
        -- import any extras modules here
        -- { import = "lazyvim.plugins.extras.linting.eslint" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.json" },
        -- { import = "lazyvim.plugins.extras.lang.markdown" },
        -- { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.tailwind" },
        -- { import = "lazyvim.plugins.extras.coding.copilot" },
        -- { import = "lazyvim.plugins.extras.dap.core" },
        -- { import = "lazyvim.plugins.extras.vscode" },
        { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        -- { import = "lazyvim.plugins.extras.test.core" },
        -- { import = "lazyvim.plugins.extras.coding.yanky" },
        -- { import = "lazyvim.plugins.extras.editor.mini-files" },
        -- { import = "lazyvim.plugins.extras.util.project" },
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    dev = {
        path = "~/.ghq/github.com",
    },
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        cache = {
            enabled = true,
            -- disable_events = {},
        },
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        custom_keys = {
            ["<localleader>d"] = function(plugin)
                dd(plugin)
            end,
        },
    },
    debug = false,
})
