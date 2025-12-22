-- lua/plugins/ai_buffer.lua: AI buffer management system

local M = {}

-- Function to detect which AI system should be used based on key prefix
function M.detect_ai_system(key_prefix)
  if key_prefix:match("^oa") then
    return "opencode"
  elseif key_prefix:match("^a") then
    return "ollama"
  else
    return "unknown"
  end
end

-- Function to create or switch to appropriate buffer for AI responses
function M.prepare_ai_buffer(ai_system, mode)
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(current_buf)
  
  -- Create buffer name based on AI system
  local target_buf_name = nil
  if ai_system == "opencode" then
    target_buf_name = "opencode_" .. os.time()
  elseif ai_system == "ollama" then
    target_buf_name = "ollama_" .. os.time()
  else
    return vim.notify("Unknown AI system: " .. ai_system, vim.log.levels.ERROR)
  end
  
  -- Check if we're already in an appropriate AI buffer
  if string.match(buf_name, "^opencode_") and ai_system == "opencode" then
    return vim.notify("Already in OpenCode buffer", vim.log.levels.INFO)
  elseif string.match(buf_name, "^ollama_") and ai_system == "ollama" then
    return vim.notify("Already in Ollama buffer", vim.log.levels.INFO)
  end
  
  -- Create new buffer for AI response
  local new_buf = vim.api.nvim_create_buf(false, true)
  if not new_buf then
    return vim.notify("Failed to create AI buffer", vim.log.levels.ERROR)
  end
  
  -- Set buffer as modifiable
  vim.api.nvim_set_option(new_buf, "modifiable", true)
  vim.api.nvim_set_option(new_buf, "readonly", false)
  
  -- Switch to new buffer
  vim.api.nvim_set_current_buf(new_buf)
  vim.api.nvim_buf_set_name(new_buf, target_buf_name)
  
  -- Set filetype
  vim.api.nvim_buf_set_option(new_buf, "filetype", "text")
  
  vim.notify("Created " .. ai_system:upper() .. " buffer", vim.log.levels.INFO)
  return new_buf
end

-- Function to check if buffer is AI-related
function M.is_ai_buffer(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(buf)
  return string.match(buf_name, "^(opencode|ollama)_") ~= nil
end

return M