vim.cmd([[ colorscheme neofusion ]])

require("remap")
require("set")
require("packer-config")
require("dirfunc")

require 'nvim-treesitter.install'.prefer_git = false

require 'nvim-treesitter.install'.compilers = { "clang" }

vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
