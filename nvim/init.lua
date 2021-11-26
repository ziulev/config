require "plugins"
require "vim"
require "keybindings"


-- PLUGINS SETUP

require("github-theme").setup({
    theme_style = "dimmed",
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "tsserver" then
        opts.capabilities = capabilities
    end

    if server.name == "sumneko_lua" then
        opts.capabilities = capabilities
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'use' } -- Fix warning "Undefined global vim, ..."
                }
            }
        }
    end

    server:setup(opts)
end)


-- TREE
vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
}
vim.g.nvim_tree_icons = {
    git = {
        unstaged = "◌",
        staged = "○",
        unmerged = "",
        renamed = "➜",
        untracked = "◌",
        deleted = "-",
    },
    folder = {
        default = "▸",
        open = "▾",
        empty = "▸",
        empty_open = "▾",
        symlink = "",
        symlink_open = "",
    }
}
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
    auto_close = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        hide_root_folder = true,
        width = 40,
        height = 30,
        side = 'right',
        mappings = {
            list = {
                { key = {"h", "l"}, cb = tree_cb("edit") },
            }
        }
    },
    filters = {
        custom = {
            ".git",
            ".DS_Store",
        }
    },
}
-- vim.api.nvim_command("highlight! link NvimTreeIndentMarker Comment")
vim.api.nvim_command("highlight! link NvimTreeGitDirty GitSignsChange")
vim.api.nvim_command("highlight! link NvimTreeGitStaged GitSignsAdd")
vim.api.nvim_command("highlight! link NvimTreeGitNew GitSignsAdd")
vim.api.nvim_command("highlight! link NvimTreeGitDeleted GitSignsDelete")


-- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
    extensions = {
        frecency = {
            default_workspace = 'CWD',
        },
    },
    sorting_strategy = "ascending",
    defaults = {
        preview = false,
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
        -- border = false,
        layout_config = {
            horizontal = {
                height = 0.4,
                preview_cutoff = 120,
                prompt_position = "top",
                width = 0.92
            },
        },
        file_ignore_patterns = {
            "node_modules",
            "dist"
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
}
require"telescope".load_extension("frecency")


-- Delete buffers
require('close_buffers').setup({})


-- Treesitter
require'nvim-treesitter.configs'.setup {
    defaults = {
        layout_config = {
            vertical = { width = 0.5 },
        },
    },
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "php",
        "json",
        "yaml",
        "swift",
        "html",
        "scss"
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }


-- Autopairs
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" },
})


-- Setup nvim-cmp.
local cmp = require'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


-- Icons
require'nvim-web-devicons'.setup {}


-- Popui
vim.ui.select = require"popui.ui-overrider"
vim.g.popui_border_style = "rounded"


-- LSP signature
require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
    },
    floating_window = false,
    hint_enable = true,
    hint_prefix = "",
    transparency = 50,
})


-- LSP lint
local null_ls = require("null-ls")

local eslint = require("null-ls.helpers").conditional(function(utils)
    local project_local_bin = "node_modules/.bin/eslint"

    return null_ls.builtins.diagnostics.eslint.with({
        command = utils.root_has_file(project_local_bin) and project_local_bin or "eslint",
    })
end)
null_ls.config({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
	eslint,
    },
})
require("lspconfig")["null-ls"].setup({})


-- Surround
require"surround".setup {
    mappings_style = "surround",
}


-- Commented
require("commented").setup({
    keybindings = {n = "gc", v = "gc", nl = "gcc"},
})


-- Auto Session
-- local function restore_nvim_tree()
    -- local nvim_tree = require('nvim-tree')
    -- nvim_tree.change_dir(vim.fn.getcwd())
    -- nvim_tree.refresh()
    -- nvim_tree.toggle()
-- end
-- require('auto-session').setup {
    -- post_restore_cmds = {restore_nvim_tree, "wincmd h"},
    -- pre_save_cmds = {"NvimTreeClose"}
-- }


-- Indent
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
require("indent_blankline").setup {
    show_end_of_line = false,
    space_char_blankline = " ",
}


-- Autotag
require('nvim-ts-autotag').setup()


-- Context
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    -- TODO: check JSON support
    -- patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- default = {
            -- 'class',
            -- 'function',
            -- 'method',
            -- -- 'for', -- These won't appear in the context
            -- -- 'while',
            -- -- 'if',
            -- -- 'switch',
            -- -- 'case',
        -- },
        -- -- Example for a specific filetype.
        -- -- If a pattern is missing, *open a PR* so everyone can benefit.
        -- --   rust = {
        -- --       'impl_item',
        -- --   },
    -- },
}


-- Select line
require('numb').setup()


-- Git signs
require('gitsigns').setup()


-- Neogit
require('neogit').setup({})


-- Git diff
local cb = require'diffview.config'.diffview_callback
require'diffview'.setup{
  file_panel = {
    position = "right",            -- One of 'left', 'right', 'top', 'bottom'
    width = 40,                   -- Only applies when position is 'left' or 'right'
    height = 10,                  -- Only applies when position is 'top' or 'bottom'
  },
  key_bindings = {
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["s"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}


-- Barbar
vim.g.bufferline = {
  auto_hide = false,
  closable = false,
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  maximum_padding = 2,
  maximum_length = 30,
  no_name_title = nil,
}


-- Spectre
require('spectre').setup()


