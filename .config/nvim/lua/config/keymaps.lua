-- not to use the discipline for the time being
-- local discipline = require("craftzdog.discipline")

-- discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
    vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
    require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
    require("craftzdog.lsp").toggleInlayHints()
end)

-- Press <C-b> to call specs!
vim.api.nvim_set_keymap("n", "<C-b>", ':lua require("specs").show_specs()', { noremap = true, silent = true })

-- You can even bind it to search jumping and more, example:
vim.api.nvim_set_keymap("n", "n", 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })

-- Or maybe you do a lot of screen-casts and want to call attention to a specific line of code:
vim.api.nvim_set_keymap(
    "n",
    "<leader>v",
    ':lua require("specs").show_specs({width = 97, winhl = "Search", delay_ms = 610, inc_ms = 21})<CR>',
    { noremap = true, silent = true }
)

-- for Gen
vim.keymap.set({ "n", "v" }, "<leader>oi", ":Gen<CR>")
vim.keymap.set("v", "<leader>oe", ":Gen Enhance_Grammar_Spelling<CR>")

-- for chatgpt
vim.keymap.set("n", "<leader>cgg", ":ChatGPT<CR>")
vim.keymap.set("n", "<leader>cgr", ":ChatGPTRun ")
vim.keymap.set("v", "<leader>cge", ":ChatGPTEditWithInstructions<CR>")

-- mapping ; to :
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("v", ";", ":", { noremap = true })
