local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set


-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Colemak layout:
-- `12345 67890-=     Move around:
--  qwfpp jluy;[]\         e
--  arstg MNEIo'         h   i
--  zxcvd kh,./            n
local nx = { "n", "x" }


-- map hjkl to mnei
--- navigation
keymap(nx, "m", "h", opts)
keymap(nx, "n", "j", opts)
keymap(nx, "e", "k", opts)
keymap(nx, "i", "l", opts)
keymap(nx, "M", "H", opts)
-- keymap(nx, "N", "J", opts)
-- remember cursor on N
keymap(nx, "N", "mzJ`z", opts)
keymap(nx, "E", "K", opts)
keymap(nx, "I", "L", opts)

--- change
keymap(nx, "cm", "ch", { noremap = true, silent = true, desc = "Left" })
keymap(nx, "cn", "cj", { noremap = true, silent = true, desc = "Down" })
keymap(nx, "ce", "ck", { noremap = true, silent = true, desc = "Up" })
-- do not change ci- as it is prefix for <change inside>
--
keymap(nx, "cj", "ce", { noremap = true, silent = true, desc = "Next end of word" })
keymap(nx, "cJ", "cE", { noremap = true, silent = true, desc = "Next end of word" })

-- visual mode move
keymap("v", "N", ":m '>+1<CR>gv=gv", opts)
keymap("v", "E", ":m '<-2<CR>gv=gv", opts)


keymap(nx, "<C-w>m", "<C-w>h", opts)
keymap(nx, "<C-w>n", "<C-w>j", opts)
keymap(nx, "<C-w>e", "<C-w>k", opts)
keymap(nx, "<C-w>i", "<C-w>l", opts)

--- forward
keymap(nx, "j", "e", opts)
keymap(nx, "J", "E", opts)

--- insert
keymap(nx, "l", "i", opts)
keymap(nx, "L", "I", opts)

--- search
keymap(nx, "k", "n", opts)
keymap(nx, "K", "N", opts)

--- mark
keymap(nx, "h", "m", opts)
keymap(nx, "H", "M", opts)

-- ensure default due to csi-u
keymap({ "n", "x", "t" }, "<Enter>", "<Enter>", opts)
keymap({ "n", "x", "t" }, "<Tab>", "<Tab>", opts)

-- terminal custom mapping to workaround tmux bug
keymap({ "n", "x", "t" }, "<F12><C-m>", "<C-m>", { remap = true, silent = true })
keymap({ "n", "x", "t" }, "<F12><C-i>", "<C-i>", { remap = true, silent = true })

--- Ctrl + arrow to resize window
keymap(nx, "<C-Up>", ":resize -2<CR>", opts)
keymap(nx, "<C-Down>", ":resize +2<CR>", opts)
keymap(nx, "<C-Left>", ":vertical resize -2<CR>", opts)
keymap(nx, "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<leader>q", ":qa<CR>")
keymap("n", "<leader>s", ":w<CR>")

keymap("n", "<ESC>", "<ESC>", opts)
keymap("n", "<C-[>", "<C-o>", opts)
keymap({ "n", "i" }, "<C-c>", "<ESC>", opts)

keymap({ "c" }, "<C-e>", "<C-p>", opts)
keymap({ "c" }, "<C-p>", "<C-e>", opts)

keymap(nx, "[b", "<CMD>bprev<CR>", opts)
keymap(nx, "]b", "<CMD>bnext<CR>", opts)

keymap(nx, "[t", "<CMD>tabprevious<CR>", opts)
keymap(nx, "]t", "<CMD>tabnext<CR>", opts)
