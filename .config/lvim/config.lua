-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
-- Esc to jk
vim.keymap.set("i", "jk", "<esc>")
vim.opt.relativenumber = true


lvim.builtin.which_key.setup.plugins.presets.z = true

lvim.keys.normal_mode["[b"]                    = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["]b"]                    = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<leader>twc"]           = ":TailwindColorsAttach<CR>"

local formatters                               = require "lvim.lsp.null-ls.formatters"
local code_actions                             = require "lvim.lsp.null-ls.code_actions"
local diagnostic                               = require "lvim.lsp.null-ls.linters"
code_actions.setup {
  {
    name = "eslint_d",
  }
}

diagnostic.setup {
  {
    name = "eslint_d",
    args = { "--cache" }
  },
  {
    name = "mypy",
  },
}

formatters.setup {
  {
    name = "blade_formatter",
    filetypes = { "php", "blade" },
  },
  {
    name = "black",
    filetypes = { "python" },
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact" },
  },
}

lvim.plugins = {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require('rainbow-delimiters.setup').setup()
    end
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "meatballs/notebook.nvim",
    config = function()
      require('notebook').setup()
    end
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    config = function()
      require("tailwindcss-colors").setup()
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end
  },
}

lvim.colorscheme = "catppuccin"


local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
  require("tailwindcss-colors").buf_attach(bufnr)
end

nvim_lsp["tailwindcss"].setup({
  -- other settings --
  on_attach = on_attach,
})


lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 10000 }
  end,
  "Format",
}
lvim.format_on_save.enabled               = true
lvim.format_on_save.timeout               = 10000

vim.opt.foldmethod                        = 'manual'
-- vim.opt.foldexpr                          = 'nvim_treesitter#foldexpr()'

--[[ local M                                   = {}

function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autoCommands = {
  -- other autocommands
  open_folds = {
    { "BufReadPost,FileReadPost", "*", "normal zR" }
  }
}

M.nvim_create_augroups(autoCommands) ]]
