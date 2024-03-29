require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'
  -- use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
  use { 'natecraddock/sessions.nvim' }
  -- use { 'github/copilot.vim' }
  use { 'gpanders/editorconfig.nvim' }

  use { 'Exafunction/codeium.vim' }
end)

-- require('tabnine').setup({
  -- disable_auto_comment=true, 
  -- accept_keymap="<A-i>",
  -- dismiss_keymap = "<C-]>",
  -- debounce_ms = 800,
  -- suggestion_color = {gui = "#808080", cterm = 244},
  -- execlude_filetypes = {"TelescopePrompt"}
-- })

--- Check if a file or directory exists in this path
function exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

-- Sessions
local sessions = require("sessions")
sessions.setup({
  events = { "VimLeavePre" },
})

local session_path = vim.fn.expand('$HOME/.config/nvim/sessions') .. vim.fn['getcwd']()
vim.keymap.set('n', '<Leader>ss', ':SessionsSave! ' .. session_path .. '<CR>', { noremap = true })
if exists(session_path) then
  sessions.load(session_path)
end
-- End sessions

-- vim.keymap.set('i', 'C-j', 'copilot#Accept("<CR>")', { silent = true })
vim.keymap.set('n', '<Leader>rc', ':terminal cargo run<CR>', { noremap = true })
