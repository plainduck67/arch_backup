local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cindent = true
vim.g.mapleader = " "

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("n", "H", "gT", { noremap = true, silent = true })
vim.keymap.set("n", "L", "gt", { noremap = true, silent = true })

vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-q>", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })

require("lazy").setup({
  --   {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
      --       require("catppuccin").setup({
        --         flavour = "frappe",
        --         integrations = { treesitter = true, nvimtree = true, lualine = true },
        --       })
        --       vim.cmd.colorscheme("catppuccin-frappe")
        --     end,
        --   },
        {
          "sainnhe/everforest",
          lazy = false,
          priority = 1000,
          config = function()
            vim.g.everforest_background = 'medium'
            vim.g.everforest_better_performance = 1
            vim.cmd([[colorscheme everforest]])
          end,
        },

        { "nvim-tree/nvim-web-devicons", lazy = false },

        {
          "windwp/nvim-autopairs",
          event = "InsertEnter",
          config = function()
            require("nvim-autopairs").setup({})
          end,
        },

        {
          "nvim-tree/nvim-tree.lua",
          dependencies = { "nvim-tree/nvim-web-devicons" },
          lazy = false,
          config = function()
            require("nvim-tree").setup({
              sort_by = "case_sensitive",

              view = {
                width = 30,
                side = "left",
              },

              renderer = {
                icons = {
                  show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                  },
                },
              },

              actions = {
                open_file = {
                  quit_on_open = false,
                  window_picker = {
                    enable = false,
                  },
                },
              },

              on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                  return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                  }
                end

                vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open: New Tab"))

                vim.keymap.set("n", "o", api.node.open.tab, opts("Open: New Tab"))
              end,
            })
          end,
        },

        {
          "nvim-telescope/telescope.nvim",
          tag = '0.1.8',
          dependencies = { 'nvim-lua/plenary.nvim' },
          config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
          end
        },
        {
          "neovim/nvim-lspconfig",
          dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
          },
          config = function()
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
              ensure_installed = { "clangd" },
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('clangd', {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gd", function()
                  vim.lsp.buf.definition({
                    on_list = function(options)
                      if options and options.items and #options.items > 0 then
                        vim.fn.setqflist({}, ' ', options)
                        vim.cmd("tabedit " .. options.items[1].filename)
                        vim.fn.cursor(options.items[1].lnum, options.items[1].col)
                      end
                    end
                  })
                end, opts)

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              end,
            })

            vim.lsp.enable('clangd')
          end,
        },

        {
          "hrsh7th/nvim-cmp",
          dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
          },
          config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
              }, {
                { name = 'buffer' },
                { name = 'path' },
              })
            })
          end,
        },

        {
          "nvim-lualine/lualine.nvim",
          dependencies = { "nvim-tree/nvim-web-devicons" },
          lazy = false,
          config = function()
            require("lualine").setup({
              options = { theme = "catppuccin", section_separators = "", component_separators = "" },
            })
          end,
        },
        cla})
        vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, { noremap = true, silent = true })
