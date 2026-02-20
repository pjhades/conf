plugins = {
    { 'projekt0n/github-nvim-theme' },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate'
    },
    { 
        'ibhagwan/fzf-lua',
        lazy = false,
        opts = {
            winopts = {
                row = 0, col = 0,
                height = 1, width = 1,
                border = 'none',
                preview = { layout = 'vertical', vertical = "down:70%", border = 'border-top', title = false }
            },
        }
    },
    {
        'pjhades/nvim-repolink',
        lazy = false,
        build = './build.py build || .\\build.py build',
        opts = {},
        config = function()
            require('nvim-repolink')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            vim.lsp.config('rust_analyzer', {
                on_attach = function(_client, bufnr)
                    -- See https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                    vim.keymap.set('n', '<C-\\>d', vim.lsp.buf.definition)
                    vim.keymap.set('n', '<C-\\>r', vim.lsp.buf.references)
                    -- List trait impls
                    vim.keymap.set('n', '<C-\\>i', vim.lsp.buf.implementation)
                    -- List callers
                    vim.keymap.set('n', '<C-\\>c', vim.lsp.buf.incoming_calls)

                    -- Format code on save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                        checkOnSave = {
                            enable = false,
                        },
                        diagnostics = {
                            enable = false,
                        },
                    }
                }
            })
            vim.lsp.enable('rust_analyzer')

            vim.lsp.config('clangd', {
                on_attach = function(_client, bufnr)
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    vim.keymap.set('n', '<C-\\>d', vim.lsp.buf.definition)
                    vim.keymap.set('n', '<C-\\>r', vim.lsp.buf.references)
                    vim.keymap.set('n', '<C-\\>i', vim.lsp.buf.implementation)
                    vim.keymap.set('n', '<C-\\>c', vim.lsp.buf.incoming_calls)
                    vim.diagnostic.enable(false, { bufnr = bufnr })
                end,
                cmd = {'clangd', '--background-index', '--clang-tidy'},
                settings = {
                    ['clangd'] = {
                        diagnostics = {
                            enable = false,
                        }
                    }
                }
            })
            vim.lsp.enable('clangd')
        end,
    }
}

-- Check if lazy.nvim is bootstrapped and load it, taken from
-- https://lazy.folke.io/installation
function setup_lazy()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
        local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
                { out, 'WarningMsg' },
                { '\nPress any key to exit...' },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end

    vim.opt.rtp:prepend(lazypath)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = '\\'

    require('lazy').setup({
        spec = plugins,
        install = { colorscheme = { 'habamax' } },
        checker = { enabled = false },
    })
end

setup_lazy()

vim.o.number = true
vim.o.ruler = true
vim.o.showcmd = true
vim.o.hlsearch = true 
vim.o.incsearch = true 
vim.o.wrapscan = false 
vim.o.backup = false 
vim.o.wrap = false 
vim.o.autoindent = true 
vim.o.smartindent = true 
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.mouse = ""
vim.o.termguicolors= true
vim.opt.laststatus = 3

-- Always list files in long format
vim.g.netrw_liststyle = 1
-- Open netrw if no CLI argument is given
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Explore")
    end
  end,
})

vim.cmd.colorscheme('github_dark_colorblind')

-- Shortcuts for fzf, see https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#buffers-and-files
-- Start file searching
vim.keymap.set('n', '<C-\\>f', ':FzfLua files<CR>')
-- Start live grep
vim.keymap.set('n', '<C-\\>g', ':FzfLua live_grep_native<CR>')
-- Search for the word under cursor 
vim.keymap.set('n', '<C-\\>w', ':FzfLua grep_cword<CR>')
-- Start grep
vim.keymap.set('n', '<C-\\>s', ':FzfLua grep<CR>')

vim.keymap.set('n', 'tn', ':tabn<CR>')
vim.keymap.set('n', 'tp', ':tabp<CR>')
