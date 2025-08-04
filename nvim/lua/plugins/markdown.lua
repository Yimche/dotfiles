return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = true,
      width = "block",
      right_pad = 1,
      render_modes = false,
      style = 'full',
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbox = {
      enabled = false,
    },
    bullet = {
        enabled = true,
        render_modes = false,
        icons = { '●', '○', '◆', '◇' },
        ordered_icons = function(ctx)
            local value = vim.trim(ctx.value)
            local index = tonumber(value:sub(1, #value - 1))
            return ('%d.'):format(index > 1 and index or ctx.index)
        end,
        left_pad = 0,
        right_pad = 1,
        highlight = 'RenderMarkdownBullet',
        scope_highlight = {},
    }
  },
  ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
}
