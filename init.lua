require('plugins')
require('settings')
require('keymap')

-- Color scheme
vim.cmd [[
  syntax enable
  colorscheme one
  set background=light

  " When writing a buffer (no delay).
  " call neomake#configure#automake('w')
  " When writing a buffer (no delay), and on normal mode changes (after 750ms).
  " call neomake#configure#automake('nw', 750)
  " When reading a buffer (after 1s), and when writing (no delay).
  " call neomake#configure#automake('rw', 1000)
  " Full config: when writing or reading a buffer, and on changes in insert and
  " normal mode (after 500ms; no delay when writing).
  call neomake#configure#automake('nrwi', 500)
]]

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "powershell_es", "bashls", "lemminx", "marksman", "ltex" }
})

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

require'lspconfig'.powershell_es.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.lemminx.setup{}
require'lspconfig'.ltex.setup{}
require'lspconfig'.sumneko_lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end

-- nvim-tree
require("nvim-tree").setup()

-- lualine
require('lualine').setup {
  options = { theme = 'onelight' }
}

-- tabline
require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
  -- If lualine is installed tabline will use separators configured in lualine by default.
  -- These options can be used to override those settings.
    section_separators = {'', ''},
    component_separators = {'', ''},
    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
    show_devicons = true, -- this shows devicons in buffer section
    show_bufnr = false, -- this appends [bufnr] to buffer section,
    show_filename_only = false, -- shows base filename only instead of relative path in filename
    modified_icon = "+ ", -- change the default modified icon
    modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
    show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
  }
}

