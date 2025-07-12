-- format *.templ files on save using the templ CLI
vim.api.nvim_create_augroup('TemplFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'TemplFormat',
  pattern = '*.templ',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, '\n')

    -- Run 'templ fmt' with no filename, feed buffer content via stdin
    local formatted = vim.fn.system('templ fmt', content)
    if vim.v.shell_error ~= 0 then
      error('templ fmt failed:\n' .. formatted)
    end

    local formatted_lines = vim.split(formatted, '\n')
    -- Only replace buffer if formatted output differs
    if formatted ~= content then
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted_lines)
    end
  end,
})

return {}
