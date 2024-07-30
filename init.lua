vim.cmd('colors nvimgelion')
require("remap")
require("set")
require("packer-config")

require 'nvim-treesitter.install'.prefer_git = false

require 'nvim-treesitter.install'.compilers = { "clang" }
