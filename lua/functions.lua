local M = {}

M.root_patterns = {".git"}

-- Print the string representation of a Lua table
function M.P(v)
  print(vim.inspect(v))
  return v
end

function M.OS()
  if os.getenv("HOMEBREW_PREFIX") == "/opt/homebrew" then
    return "mac"
  else
    return "linux"
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

function M.fzf(builtin, opts)
  return function()
    opts = opts or {}
    opts.cwd = M.get_root()
    require("fzf-lua")[builtin](opts)
  end
end

function M.fzf_dirs(opts)
  local fzf_lua = require('fzf-lua')
  local root = M.get_root()

  opts = opts or {}
  opts.cwd = root
  opts.prompt = "Dir> "
  opts.actions = {
    ['default'] = function(selected)
      vim.cmd("cd " .. root .. "/" .. selected[1])
      _G.titlestring()
    end
  }
  fzf_lua.fzf_exec("fd --type d", opts)
end

return M
