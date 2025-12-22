-- lua/config/opencode_fix.lua: Global fix for extmark errors affecting opencode

-- This file should be loaded before opencode to prevent the end_col out of range error
local M = {}

function M.setup()
  -- Patch nvim_buf_set_extmark to handle out of range end_col values
  local set_extmark = vim.api.nvim_buf_set_extmark
  
  vim.api.nvim_buf_set_extmark = function(bufnr, ns_id, line, col, opts)
    -- Validate buffer exists
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return -1
    end
    
    -- Fix end_col parameter if present
    if opts and opts.end_col then
      local line_content = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1]
      if line_content then
        local max_col = #line_content
        if opts.end_col > max_col then
          opts.end_col = max_col
        elseif opts.end_col < 0 then
          opts.end_col = 0
        end
      else
        -- Line doesn't exist, set end_col to 0
        opts.end_col = 0
      end
    end
    
    -- Call original function with error handling
    local ok, result = pcall(set_extmark, bufnr, ns_id, line, col, opts)
    if not ok then
      -- Log error but don't crash
      vim.schedule(function()
        vim.notify("Extmark error (handled): " .. tostring(result), vim.log.levels.WARN)
      end)
      return -1
    end
    
    return result
  end
end

return M