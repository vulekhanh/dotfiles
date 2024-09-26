local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end
bufferline.setup({
  options = {
    themable = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
        separator = true,
      },
    },
    indicator = {
      icon = "  ",
      style = "icon",
    },
    buffer_close_icon = "",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
    local icon = level:match("error") and " " or ""
    return " " .. icon .. count
    end,
  },
    highlights = {
      indicator_selected = {
        fg = "#e5c890",
        bg = "#303446",
      },
    },
})
