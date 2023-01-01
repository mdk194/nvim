-- Print the string representation of a Lua table
P = function(v)
  print(vim.inspect(v))
  return v
end

OS = function()
  if os.getenv('BREW_PREFIX') == '/opt/homebrew' then
    return 'mac'
  else 
    return 'linux'
  end
end
