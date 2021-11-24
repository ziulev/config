local nvim_set_keymap = vim.api.nvim_set_keymap
local default_opt = {noremap = true, silent = true}

-- Navigate splits
nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", default_opt)
nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", default_opt)
nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", default_opt)
nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", default_opt)

-- Go over wrapped lines
nvim_set_keymap("n", "j", "gj", default_opt)
nvim_set_keymap("n", "k", "gk", default_opt)

-- Keep selection in visual mode when indenting
nvim_set_keymap("v", "<", "<gv", default_opt)
nvim_set_keymap("v", ">", ">gv", default_opt)

-- Move lines in visual mode
nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", default_opt)
nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", default_opt)

-- Edit
nvim_set_keymap("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", default_opt)
nvim_set_keymap("v", "<leader>rs", ":'<,'>sort<CR>", default_opt)
nvim_set_keymap("n", "<leader>.", ":lua vim.lsp.buf.code_action()<CR>", default_opt)
nvim_set_keymap("n", "<leader>rf", ":lua vim.lsp.buf.formatting()<CR>", default_opt)


-- Search (Telescope, defined as Lua strings)
-- nvim_set_keymap("n", "<leader>p", ':lua require"telescope.builtin".find_files()<CR>', default_opt)
nvim_set_keymap("n", "<leader>p", ':lua require"telescope.builtin".git_files()<CR>', default_opt)
nvim_set_keymap("n", "<leader>f", ':lua require"telescope.builtin".current_buffer_fuzzy_find({ previewer = false, sorting_strategy="ascending" })<CR>', default_opt)
nvim_set_keymap("n", "<leader>P", ':lua require"telescope.builtin".buffers()<CR>', default_opt)


-- GoTo
nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", default_opt)
nvim_set_keymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", default_opt)
nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", default_opt)
nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", default_opt)
nvim_set_keymap("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", default_opt)
nvim_set_keymap("n", "gh", ":lua vim.lsp.buf.hover()<CR>", default_opt)
nvim_set_keymap("n", "gf", "gf", default_opt)

-- Tree
nvim_set_keymap("n", "<leader>b", ":NvimTreeToggle<CR>", default_opt)
nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", default_opt)
-- nvim_set_keymap("n", "<leader>E", ":NvimTreeFocus<CR>", default_opt)


-- Tabs
nvim_set_keymap("n", "H", ":BufferPrevious<CR>", default_opt)
nvim_set_keymap("n", "L", ":BufferNext<CR>", default_opt)
nvim_set_keymap("n", "<leader>H", ":BufferMovePrevious<CR>", default_opt)
nvim_set_keymap("n", "<leader>L", ":BufferMoveNext<CR>", default_opt)
nvim_set_keymap("n", "<leader>w", ":BufferClose<CR>", default_opt)


-- Neogit
nvim_set_keymap("n", "<leader>g", ":Neogit<CR>", default_opt)

