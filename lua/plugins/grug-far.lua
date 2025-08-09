return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  keys = {
    { '<leader>sr', function() require('grug-far').open() end },
  },
  config = function()
    require('grug-far').setup({
      windowCreationCommand = 'botright split',
      showCompactInputs = true,
      showInputsTopPadding = false,
      showInputsBottomPadding = false,
    });
  end
}
