vim.g.mapleader = ','
vim.g.localmapleader = ','

vim.keymap.set('i', ',,', '<Esc>A,')
vim.keymap.set('i', ';;', '<Esc>A;')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- https://github.com/jessarcher/dotfiles/blob/master/nvim/lua/user/keymaps.lua

vim.keymap.set('n', 'q:', ':q')

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Move lines up and down
vim.keymap.set('i', '<C-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<C-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('x', '<C-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<C-k>', ":move '<-2<CR>gv-gv")
