vim.g.projectionist_heuristics = {
  artisan = {
    ['app/*.php'] = {
      type = 'source',
      alternate = {
        'tests/Unit/{}Test.php',
        'tests/Feature/{}Test.php',
      },
    },
    ['tests/Feature/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
    },
    ['tests/Feature/Livewire/*Test.php'] = {
      type = 'test',
      alternate = 'app/Http/Livewire/{}.php',
    },
    ['tests/Unit/*Test.php'] = {
      type = 'test',
      alternate = 'app/{}.php',
    },
    ['app/Http/Livewire/*.php'] = {
      type = 'livewire',
      alternate = {
        'resources/views/livewire/{snakecase|hyphenate}.blade.php',
        'tests/Feature/Livewire/{}Test.php',
        'tests/Unit/Livewire/{}Test.php',
      }
    },
    ['resources/views/livewire/*.blade.php'] = {
      type = 'blade',
      alternate = 'app/Http/Livewire/{camelcase|uppercase}.php',
    },
  },
}

vim.keymap.set('n', '<Leader>aa', ':A<CR>')
vim.keymap.set('n', '<Leader>as', ':AS<CR>')
vim.keymap.set('n', '<Leader>av', ':AV<CR>')
vim.keymap.set('n', '<Leader>att', ':Etest<CR>')
vim.keymap.set('n', '<Leader>ats', ':Stest<CR>')
vim.keymap.set('n', '<Leader>atv', ':Vtest<CR>')
