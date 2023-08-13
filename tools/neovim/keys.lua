local map = function(key, cmd)
    vim.api.nvim_set_keymap('n', '<Leader>d' .. key, cmd, {noremap = true, silent = true})
end

map('b', ":lua require'dap'.toggle_breakpoint()<cr>")
map('c', ":lua require'dap'.continue()<cr>")
map('s', ":lua require'dap'.step_over()<cr>")
map('i', ":lua require'dap'.step_into()<cr>")
map('o', ":lua require'dap'.step_out()<cr>")
map('r', ":lua require'dap'.repl.toggle()<cr>")
  