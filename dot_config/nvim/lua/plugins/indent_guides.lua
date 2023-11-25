return
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  config = function(_, opts)
  require('ibl').setup(opts)
  end
}
