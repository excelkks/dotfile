return {
  {
    "airblade/vim-rooter",
    init = function()
      vim.g.rooter_patterns = { '__vim_project_root', '.git/' }
      vim.g.rooter_silent_chdir = true
    end
  },
}
