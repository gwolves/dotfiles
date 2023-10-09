local options = {
  -- line numbers
  number = true,
  relativenumber = true,

  -- tabs & indentation
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  smartindent = true,

  -- line wrapping
  wrap = true,

  -- search
  ignorecase = true,
  smartcase = true,

  -- cursor line
  cursorline = true,

  -- appearance
  termguicolors = true,
  -- background = "dark",
  signcolumn = "yes",

  -- backspace
  backspace = "indent,eol,start",

  -- clipboard
  -- use system clipboard
  clipboard = "unnamedplus",

  -- split windows
  splitright = true,
  splitbelow = true,


  backup = false,
  numberwidth = 4,
  showtabline = 2,
  swapfile = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- disable intro
vim.opt.shortmess:append("I")

-- disable written message
vim.opt.shortmess:append("w")
vim.opt.shortmess:append("W")
-- TODO: why F option do not work?
vim.opt.shortmess:append("F")

-- disable search option message
vim.opt.shortmess:append("s")
