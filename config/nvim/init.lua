-- Small configs

vim.cmd([[
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set fillchars=eob:\ 
]])

--


-- Make neovim use vim configs


vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

-- End 



-- Lazy nvim setup


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

-- End setup

-- List of plugins

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  ---
  -- List of plugins...
  ---
  { "folke/neodev.nvim", opts = {} },
  {
      "rcarriga/nvim-dap-ui"
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "rose-pine/neovim", name = "rose-pine" },
  {"b0o/mapx.nvim"},
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {'m4xshen/autoclose.nvim'},
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  { 
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('poimandres').setup {
            bold_vert_split = false, -- use bold vertical separators
            dim_nc_background = false, -- dim 'non-current' window backgrounds
            disable_background = true, -- disable background
            disable_float_background = false, -- disable background for floats
            disable_italics = false, -- disable italics      
        }
    end,
    init = function()
    vim.cmd("colorscheme poimandres")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
      'mfussenegger/nvim-dap'
  },
  { "hinell/duplicate.nvim" },
  {'leoluz/nvim-dap-go'},
})



-- End list 

--
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
--

-- LSP-Zero configs
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').gopls.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').lua_ls.setup({})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})


-- End 

-- UI
require("dressing").setup({})
vim.opt.termguicolors = true
require("bufferline").setup({})
--

-- Color Scheme
require("tokyonight").setup({
    transparent = true,
})
require("rose-pine").setup({
    styles = {
        transparency = false
    }
})
vim.cmd('colorscheme tokyonight')

-- End

-- Lua Line
require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
})
--

-- auto close 
require("autoclose").setup({})
--

-- mapping
require'mapx'.setup{ global = true}
nnoremap("<C-s>",":w <Cr>","silent")
nnoremap("<C-x>",":q <Cr>","silent")
nnoremap("<C-d>",":lua require'dap'.toggle_breakpoint() <Cr>","silent")
nnoremap("<A-v>",":vertical split <Cr>","silent")
nnoremap("<A-k>",":vertical resize +5 <Cr>","silent")
nnoremap("<A-j>",":vertical resize -5 <Cr>","silent")
nnoremap("<C-A-k>",":resize +5 <Cr>","silent")
nnoremap("<C-A-j>",":resize -5 <Cr>","silent")
nnoremap("<F5>",":DapUiToggle <Cr>","silent")
--

--
require('go').setup()
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = true,
  }
)
require('dap-go').setup()
nnoremap("<C-n>",":lua require'dap'.step_over() <Cr>","silent")
-- duplicate line 
-- local config  = require("duplicate.config")
-- local editor  = require("duplicate.editor")
-- local duplicatedRange = editor:duplicateByOffset(5, config)
      -- editor:selectVisual(duplicatedRange)
vim.keymap.set({ "n" }, "<C-S-A-Up>"   ,"<CMD>LineDuplicate -1<CR>")
vim.keymap.set({ "n" }, "<C-S-A-Down>" ,"<CMD>LineDuplicate +1<CR>")
--
require("dapui").setup()
