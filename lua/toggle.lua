local defaults = {
  sets = {
    { 'true', 'false' },
    { 'on', 'off' },
    { 'enable', 'disable' },
    { 'enabled', 'disabled' },
    { 'manual', 'auto' },
    { 'always', 'never' },
  },
  variants = true
}

-- Convert to title case
local function title(str)
  str = str:lower()
  return (str:gsub("^%l", string.upper))
end

-- Insert Title, UPPER, lower and original
local function insert_with_variants(t, a, b)
  t[a] = b
  t[title(a)] = title(b)
  t[a:lower()] = b:lower()
  t[a:upper()] = b:upper()
end

local function generate_sets(config)
  local t = {}

  local insert = function(t, a, b) t[a] = b end
  if config.variants then
    insert = insert_with_variants
  end
  for _,v in ipairs(config.sets) do
    insert(t, v[1], v[2])
    insert(t, v[2], v[1])
  end

  return t
end

-- Generate the search string to jump to nearest set
local function generate_search_str(sets)
  -- Concat a search string
  local t = {}
  for k,_ in pairs(sets) do
    t[#t+1] = k
  end

  return '\\<\\('.. table.concat(t, '\\|') ..  '\\)\\>'
end

local M = {}

function M.setup(config)
  config = config or {}
  config = vim.tbl_extend("force", defaults, config)
  M.sets = generate_sets(config)
  M.search_str = generate_search_str(M.sets)

  vim.cmd(vim.api.nvim_replace_termcodes("silent! command Toggle :lua require'toggle'.toggle()", true, true, true))
end

-- Toggles the values
function M.toggle()
  -- Save cursor position
  local pos = vim.fn.getpos('.')

  -- Go to beginning  of word
  vim.cmd 'normal! b'

  -- Search for the closest in pair
  vim.fn.search(M.search_str, 'c', vim.fn.line('.') + 1)

  local word = vim.fn.expand('<cword>')

  local other = M.sets[word]

  -- No match found, restore cursor position
  if not other then
    print "No matching set found"
    vim.fn.setpos('.', pos)
    return
  end

  vim.cmd ('normal! "_ciw' .. other)
  vim.cmd ('normal! b')
end

return M
