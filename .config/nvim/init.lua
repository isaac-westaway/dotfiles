local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  	if vim.v.shell_error ~= 0 then
    		vim.api.nvim_echo({
      			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      			{ out, "WarningMsg" },
      			{ "\nPress any key to exit..." },
    			}, true, {})
    		vim.fn.getchar()
    		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  	spec = {
		{
			"nvim-tree/nvim-tree.lua",
			version = "*",
			lazy = false,
			dependencies = {
    				"nvim-tree/nvim-web-devicons",
  			},
  			config = function()
    				require("nvim-tree").setup {}
  			end,
		},
		{
  			'rmagatti/auto-session',
  			lazy = false,
  			
  			opts = {
    				suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    				-- log_level = 'debug',
				enabled = true,
  			}
		},
		{

  			'nvimdev/dashboard-nvim',
  			event = 'VimEnter',
  			config = function()
    				require('dashboard').setup {}
  			end,
  			dependencies = { {'nvim-tree/nvim-web-devicons'}}
		},
		{
    			'nvim-telescope/telescope.nvim', 
			tag = '0.1.8',
      			dependencies = { 'nvim-lua/plenary.nvim' }
    		},
		{
    			"nvim-treesitter/nvim-treesitter",
    			build = ":TSUpdate",
    			config = function ()
      				local configs = require("nvim-treesitter.configs")	
      				configs.setup({
          				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          				sync_install = false,
          				highlight = { enable = true },
          				indent = { enable = true },
        			})
    			end
		},
		{
    			'nvim-lualine/lualine.nvim',
    			dependencies = { 'nvim-tree/nvim-web-devicons' }
		},
		{
			'akinsho/bufferline.nvim', 
			version = "*", 
			dependencies = 'nvim-tree/nvim-web-devicons'
		},
		{ 
			"ellisonleao/gruvbox.nvim", 
			priority = 1000 , 
			config = true 
		},
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{
    			"zaldih/themery.nvim",
    			lazy = false,
    			config = function()
      				require("themery").setup({
        				themes = {
						{
							name = "gruvbox",
    							colorscheme = "gruvbox",
    							before = [[
      								-- All this block will be executed before apply "set colorscheme"
      								vim.opt.background = "dark"
    							]],
						},
						{
							name = "catppuccin",
							colorscheme = "catppuccin",
							before = [[
							]],
						},
					},
      				})
    			end
  		},
		{
    			"lukas-reineke/indent-blankline.nvim",
    			main = "ibl",
			---@module "ibl"
    			---@type ibl.config
    			opts = {},
		},
		{
 			"neovim/nvim-lspconfig",   			
			lazy = false,
  			dependencies = {
    				-- main one
    				{ "ms-jpq/coq_nvim", branch = "coq" },

    				-- 9000+ Snippets
    				{ "ms-jpq/coq.artifacts", branch = "artifacts" },

    				-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    				-- Need to **configure separately**
    				{ 'ms-jpq/coq.thirdparty', branch = "3p" }
  			},
  			
			init = function()
    				vim.g.coq_settings = {
        				auto_start = true, -- if you want to start COQ at startup
        				-- Your COQ settings here
    				}
  			end,
  			
			config = function()
    				-- Your LSP settings here
  			end,
}
  	},
  	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})

local lsp = require 'lspconfig'
local coq = require 'coq'

vim.o.number = true

lsp.zls.setup{coq.lsp_ensure_capabilities()}

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.termguicolors = true
require("bufferline").setup{}
require('lualine').setup{}
require("ibl").setup{
	indent = { char ="┊"},
}

local telescope = require('telescope.builtin')
local themery = require('themery')

vim.keymap.set( {'n', 'i', 'v'}, '<C-b>', function() require("nvim-tree.api").tree.toggle({
										path = nil,
										current_window = false,
										find_file = false,
										update_root = false,
									}) end)

-- todo: set initial theme on startup

vim.keymap.set( {'n', 'i', 'v'}, '<C-t>', '<esc><cmd>tabnew<cr>', { silent = true })
vim.keymap.set( {'n', 'v'}, '<C-f>', telescope.live_grep, { desc = 'Telescope find files' } )
vim.keymap.set( {'n', 'v'}, '<C-p>', '<esc><cmd>Themery<cr>', { desc = 'Open theme table' } )
