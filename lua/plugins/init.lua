return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "eslint_d",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "lua-language-server",
        "stylua",
        "gopls",
        "solidity_ls",
        "jsonls",
        "dockerls",
        "bashls",
        "terraform-ls",
        "helm-ls",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "rust",
        "markdown",
        "yaml",
        "html",
        "css",
        "bash",
        "dockerfile",
        "solidity",
        "gitignore",
        "toml",
        "terraform",
        "hcl",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- uncomment for format on save
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          go = { "goimports", "gofmt" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          lsp_format = "fallback",
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local todo_comments = require "todo-comments"
      todo_comments.setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "folke/todo-comments.nvim",
    },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    opts = {
      focus = true,
    },
    cmd = "Trouble",
    keys = {
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Open trouble workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>",                 desc = "Open trouble quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Open trouble location list" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>",                     desc = "Open todos in trouble" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local conf = require "nvchad.configs.gitsigns"

      conf.on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end
        local map = vim.keymap.set

        map("n", "<leader>gr", gs.reset_hunk, opts "Reset Hunk")
        map("n", "<leader>gR", gs.reset_buffer, opts "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, opts "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line { full = true } end, opts "Blame Line")
        map("n", "<leader>gs", gs.stage_hunk, opts "Stage Hunk")
        map("n", "<leader>gS", gs.stage_buffer, opts "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, opts "Undo Stage Hunk")
        map("n", "<leader>gf", function() gs.diffthis('~1') end, opts "Diff This")
        map("n", "<leader>gn", "<cmd>lua require('gitsigns').next_hunk()<cr>zz", opts "Next Hunk")
        map("n", "<leader>tb", gs.toggle_current_line_blame, opts "Toggle Blame Line")
      end
      return conf
    end
  },
  {
    "towolf/vim-helm",
    lazy = false,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      -- If you are on Linux, replace the line above with the line below:
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" } }
      })
    end
  },
}
