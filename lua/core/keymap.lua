-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--Exit insert mode
vim.keymap.set('i', 'jj', '<C-c>', { desc = 'Me cool' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make window splitting easier

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Open the file explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move line up and down
vim.keymap.set('x', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected one line down', noremap = true, silent = true })
vim.keymap.set('x', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selected one line up', noremap = true, silent = true })

-- Usefull code snipets.
vim.keymap.set('v', '<leader>l', 'y<esc>oconsole.log("<c-r>0: ", <c-r>0);<esc>', { desc = '[L]og selected', silent = true })
vim.keymap.set('n', '<leader>sue', 'useEffect(() => {<CR>}, []);<Esc>O', { desc = '[S]nippet useEffect', silent = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    local init_bufnr = vim.fn.bufnr '#'
    vim.keymap.set('n', '<C-n>', function()
      if vim.fn.line '.' == vim.fn.line '$' then
        vim.notify('E553: No more items', vim.log.levels.ERROR)
        return
      end
      vim.cmd 'wincmd p' -- jump to current displayed file
      vim.cmd(
        (vim.fn.bufnr '%' ~= init_bufnr and vim.bo.filetype ~= 'qf')
            and ('bd | wincmd p | cn | res %d'):format(
              math.floor((vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 0 and 0 or 1) - (vim.o.tabline == '' and 0 or 1)) / 3 * 2 + 0.5) - 1
            )
          or 'cn'
      )
      vim.cmd 'normal! zz'
      if vim.bo.filetype ~= 'qf' then
        vim.cmd 'wincmd p'
      end
    end, opts)

    vim.keymap.set('n', '<C-p>', function()
      if vim.fn.line '.' == 1 then
        vim.notify('E553: No more items', vim.log.levels.ERROR)
        return
      end
      vim.cmd 'wincmd p' -- jump to current displayed file
      vim.cmd(
        (vim.fn.bufnr '%' ~= init_bufnr and vim.bo.filetype ~= 'qf')
            and ('bd | wincmd p | cN | res %d'):format(
              math.floor((vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 0 and 0 or 1) - (vim.o.tabline == '' and 0 or 1)) / 3 * 2 + 0.5) - 1
            )
          or 'cN'
      )
      vim.cmd 'normal! zz'
      if vim.bo.filetype ~= 'qf' then
        vim.cmd 'wincmd p'
      end
    end, opts)
  end,
})
