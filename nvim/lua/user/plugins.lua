-- Install packer
local ensure_packer = function ()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Initialize packer
require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

use('wbthomason/packer.nvim') -- Let packer manage itself

use('tpope/vim-commentary')

use('tpope/vim-surround')

use('tpope/vim-eunuch')

use('tpope/vim-sleuth')

use('tpope/vim-repeat')

-- Project Configuration.
use({
  'tpope/vim-projectionist',
  requires = 'tpope/vim-dispatch',
  config = function()
    require('user.plugin.projectionist')
  end,
})

use('sheerun/vim-polyglot')

use('farmergreg/vim-lastplace')

use('jessarcher/vim-heritage')

use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})

use({
    'AndrewRadev/splitjoin.vim',
    config = function()
        vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
    end,
})

use('mattn/emmet-vim')

use('sickill/vim-pasta')

-- use({
--     'shaunsingh/nord.nvim',
    -- config = function()
    --     vim.cmd('colorscheme nord')
    -- end
-- })

use({
    'folke/tokyonight.nvim',
    config = function()
        vim.cmd('colorscheme tokyonight-storm')
    end
})

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    require('user.plugin.telescope')
  end,
})

use({
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("nvim-tree").setup({
      hijack_netrw = false,
      hijack_unnamed_buffer_when_opening = true,
      view = {
        side = 'right',
        width = 50,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })

    vim.keymap.set('n', '<Leader>ef', ':NvimTreeFindFile<CR>')
    vim.keymap.set('n', '<Leader>ee', ':NvimTreeToggle<CR>')
  end,
})

use({
    'neovim/nvim-lspconfig',
    requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jayp0521/mason-null-ls.nvim',
    },
    config = function()
        require('user.plugin.lsp')
    end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('user.plugin.completion')
  end,
})

use({
    'vim-test/vim-test',
    requires = {
      'tpope/vim-dispatch',
      'neomake/neomake',
    },
    config = function()
        vim.cmd('let test#strategy = "floaterm"')
        -- vim.cmd('let test#strategy = "neomake"')

        -- vim.cmd('let test#php#phpunit#strategy = "make"')
        vim.cmd('let test#php#phpunit#runner = "sail"')

        vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>')
        vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>')
        vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>')
        vim.keymap.set('n', '<Leader>ta', ':TestSuite<CR>')
        vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>')
    end,
})

use({
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.keymap.set('n', '<Leader>tt', ':FloatermToggle<CR>')
    vim.keymap.set('t', '<Leader>tt', '<C-\\><C-n>:FloatermToggle<CR>')
  end
})

use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugin.lualine')
  end,
})

use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('user.plugin.treesitter')
    end,
})

use({
    'MunifTanjim/prettier.nvim',
    requires = {
        { 'jose-elias-alvarez/null-ls.nvim' }
    },
    config = function()
        require('user.plugin.prettier')
    end,
})

-- PHP Refactoring Tools
use({
  'phpactor/phpactor',
  ft = 'php',
  run = 'composer install --no-dev --optimize-autoloader',
  config = function()
    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
    vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
  end,
})

use({
  'akinsho/git-conflict.nvim',
  tag = "*",
  config = function()
    require('git-conflict').setup()

    vim.keymap.set('n', '<Leader>cl', ':GitConflictListQf<CR>')
    -- co — choose ours
    -- ct — choose theirs
    -- cb — choose both
    -- c0 — choose none
    -- ]x — move to previous conflict
    -- [x — move to next conflict
  end
})

use({
  'svermeulen/text-to-colorscheme',
  config = function()
    require('text-to-colorscheme').setup {
      ai = {
        openai_api_key = os.getenv("OPEN_AI_KEY"),
        gpt_model = "babbage",
      },
    }
  end
})

if packer_bootstrap then
    require('packer').sync()
end
