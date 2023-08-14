-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    }
})

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {},
    },
}

require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer" },
    automatic_installation = true,
})

require("rust-tools").setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})

-- LSP Diagnostics Options Setup 
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end
  
  sign({name = 'DiagnosticSignError', text = '❗'})
  sign({name = 'DiagnosticSignWarn', text = '⚠️'})
  sign({name = 'DiagnosticSignHint', text = '❔'})
  sign({name = 'DiagnosticSignInfo', text = '🔍'})
  
  vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      underline = true,
      severity_sort = false,
      float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
      },
  })
  
  vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  ]])

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

vim.opt.runtimepath:append("~/.config/nvim/parsers")

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
    parser_install_dir = "~/.config/nvim/parsers",
    ensure_installed = { "lua", "rust", "toml" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true }, 
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
let g:termdebugger="rust-gdb"
]])

-- Treesitter folding 
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.lsp.set_log_level("debug")

-- /////////////////////////////////////////////////////

-- CodeLLDB dir i found... possible??
-- /home/martini/.local/share/nvim/mason/bin/codelldb

-- local dap = require('dap')

-- dap.adapters.lldb = {
--   type = 'executable',
--   command = 'lldb-vscode',  -- Adjust the command if it is not in your PATH
--   name = 'lldb'
-- }

-- dap.configurations.rust = {
--   {
--     type = 'lldb',
--     request = 'launch',
--     name = "Launch",
--     program = function()
--       vim.fn.jobstart('cargo build')
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},
--     runInTerminal = false,
--   },
-- }

-- local mapk = function(key, cmd)
--     vim.api.nvim_set_keymap('n', '<Leader>z' .. key, cmd, {noremap = true, silent = true})
-- end

-- mapk('b', ":lua require'dap'.toggle_breakpoint()<cr>")
-- mapk('z', ":lua require'dap'.continue()<cr>")
-- mapk('s', ":lua require'dap'.step_over()<cr>")
-- mapk('i', ":lua require'dap'.step_into()<cr>")
-- mapk('o', ":lua require'dap'.step_out()<cr>")
-- mapk('r', ":lua require'dap'.repl.toggle()<cr>")
  