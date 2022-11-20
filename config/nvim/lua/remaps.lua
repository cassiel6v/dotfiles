--------------------
--   REMAPS
--------------------
-- WIP

local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- •• Normal Mode

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'Y', 'y$')
map('n', 'L', '$')
map('n', 'H', '^')
map('n', 'dL', 'd$')
map('n', 'dH', 'd^')
map('n', 'x', '"_x')

map('n', '<J>', '<CMD>move .+1<CR>')
map('n', '<K>', '<CMD>move .-2<CR>')

-- •• Visual Mode

map('x', '<J>', ":move '>+1<CR>gv=gv")
map('x', '<K>', ":move '<-2<CR>gv=gv")
map('x', 'L', '$')
map('x', 'H', '^')
