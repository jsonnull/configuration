-- Startify configuration
vim.g.startify_change_to_dir = 0
vim.g.startify_custom_header = {
  "",
  "",
  "      _                     _ _ ",
  "     |_|___ ___ ___ ___ _ _| | |",
  "     | |_ -| . |   |   | | | | |",
  "    _| |___|___|_|_|_|_|___|_|_|",
  "   |___|                        ",
  "",
  "",
}
vim.g.startify_lists = {
  { type = "dir", header = { "   MRU " .. vim.fn.getcwd() } },
}
