function _G.statusline_diagnostic()
  if not vim.diagnostic.is_disabled() then
    local diagnostics_counts = {}

    for prefix, severity in pairs({
      e = vim.diagnostic.severity.ERROR,
      w = vim.diagnostic.severity.WARN,
      i = vim.diagnostic.severity.INFO,
      h = vim.diagnostic.severity.HINT,
    }) do
    local count = #vim.diagnostic.get(0, { severity = severity })

    if count > 0 then
      table.insert(diagnostics_counts, prefix .. count)
    end
  end

  if #diagnostics_counts > 0 then
    return "{" .. table.concat(diagnostics_counts, ",") .. "} "
  end

  return ""
end

return ""
end

function _G.statusline_search()
  if vim.v.hlsearch == 1 then
    -- searchcount can fail e.g. if unbalanced braces in search pattern
    local ok, count = pcall(vim.fn.searchcount)

    if ok and count["total"] > 0 then
      return "(" .. count["current"] .. "∕" .. count["total"] .. ") "
    end
  end

  return ""
end

function _G.statusline_macro_recording()
    local recording_register = vim.fn.reg_recording()

    if recording_register == "" then
        return ""
    else
        return "[@" .. recording_register .. "] "
    end
end

local statusline = '%q'
statusline = statusline .. [[%{&paste?'[PASTE] ':''}]]
statusline = statusline .. '%<%f ' -- filename
statusline = statusline .. '%m' -- modified status
statusline = statusline .. '%r' -- readonly
statusline = statusline .. '%w' -- preview
statusline = statusline .. '%=' -- align
statusline = statusline .. '%{v:lua.statusline_diagnostic()}' -- diagnostic count
statusline = statusline .. '%{v:lua.statusline_search()}' -- search count
statusline = statusline .. '%{v:lua.statusline_macro_recording()}' -- recording macro
statusline = statusline .. [[%{&spell?'[S] ':''}]] -- spell
statusline = statusline .. '<%c> ' -- column
statusline = statusline .. '%y' -- file type
statusline = statusline .. [[%{&fileformat!='unix'?[&fileformat]:''}]] -- not unix warn

vim.o.statusline = statusline
