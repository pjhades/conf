plugins = {
    {
        'nvim-tree/nvim-tree.lua',
        lazy = false
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
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            require('lspconfig').rust_analyzer.setup({
                on_attach = function(client, bufnr)
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
                            enable = true
                        },
                    }
	    	}
            })
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
        checker = { enabled = true },
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

vim.cmd.colorscheme('lunaperche')

-- Shortcuts for fzf, see https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#buffers-and-files
-- Start file searching
vim.keymap.set('n', '<C-\\>f', ':FzfLua files<CR>')
-- Start live grep
vim.keymap.set('n', '<C-\\>g', ':FzfLua live_grep_native<CR>')
-- Search for the word under cursor 
vim.keymap.set('n', '<C-\\>w', ':FzfLua grep_cword<CR>')
-- Start grep
vim.keymap.set('n', '<C-\\>s', ':FzfLua grep<CR>')


------------- experimental -------------
function setup_pckr()
    local pckr_path = vim.fn.stdpath('data') .. '/pckr/pckr.nvim'

    if not (vim.uv or vim.loop).fs_stat(pckr_path) then
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/lewis6991/pckr.nvim',
            pckr_path
        })
    end

    vim.opt.rtp:prepend(pckr_path)

    require('pckr').add({
        {
            'pjhades/nvim-repolink',
            run = function()
                --vim.fn.system('./build.py build || .\\build.py build')
                local out = vim.fn.system('pwd')
                print(out)
                print('SHIT')
                --require('nvim_repolink')
            end,
        }
    })
end

--setup_pckr()
