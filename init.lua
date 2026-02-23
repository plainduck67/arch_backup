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
  vim.opt.expandtab = true
  vim.opt.cindent = true

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
  --
  require("lazy").setup({
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        integrations = { treesitter = true, nvimtree = true, lualine = true },
      })
      vim.cmd.colorscheme("catppuccin-frappe")
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
      config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "gd", function()
        vim.cmd("tab split")
        vim.lsp.buf.definition()
        end, { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float)
        end,
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
  })
