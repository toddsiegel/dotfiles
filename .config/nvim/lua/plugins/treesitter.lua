return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter").install({ "ruby", "html", "css", "javascript", "typescript", "sql", "lua", "json", "yaml" })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { "ruby", "eruby", "html", "css", "javascript", "typescript", "sql", "lua", "json", "yaml" },
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()

	-- folds
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
