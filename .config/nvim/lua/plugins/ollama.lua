return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
        -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oo",
            ":<c-u>lua require('ollama').prompt()<cr>",
            desc = "ollama prompt",
            mode = { "n", "v" },
        },

        -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oG",
            ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
            desc = "ollama Generate Code",
            mode = { "n", "v" },
        },
    },

    ---@type Ollama.Config
    opts = {
        model = "deepseek-llm",
        -- model = "mistral",
        -- url = "http://127.0.0.1:11434",
        url = "http://localhost:11434", -- this is my own setup , change to your endpoint
        serve = {
            on_start = false,
            command = "ollama",
            args = { "serve" },
            stop_command = "pkill",
            stop_args = { "-SIGTERM", "ollama" },
        },
        -- View the actual default prompts in ./lua/ollama/prompts.lua
        prompts = {
            Sample_Prompt = {
                prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
                input_label = "> ",
                model = "deepseek-coder:6.7b-instruct",
                action = "display",
            },
            enhance_code_akabox = {
                prompt = "Enhance the following $ftype code so that it is both easier to read and understand. Optimise the code for performance and maintainability. here is the code snippet:$sel(ection),response_format:\n\n```$ftype\n$sel```",
                -- .. response_format
                -- .. "\n\n```$ftype\n$sel```",
                model = "deepseek-coder:6.7b-instruct",
                action = "replace",
            },
        }, -- your configuration overrides
    },
}
