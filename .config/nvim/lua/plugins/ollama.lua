-- lua/plugins/ollama.lua: Ollama.nvim for local AI with Podman container

return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  keys = {
    -- Ollama keymaps - all start with <leader>a (for local AI)
    {
      "<leader>aa",
      function()
        vim.bo.modifiable = true
        local success, err = pcall(function()
          require('ollama').prompt()
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Prompt menu",
      mode = { "n", "v" },
    },
    -- Explain code
    {
      "<leader>ae",
      function()
        local success, err = pcall(function()
          require('ollama').prompt('Explain this code in detail: What does it do, how does it work, and what are the key concepts?')
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Explain Code",
      mode = { "n", "v" },
    },
    -- Review code
    {
      "<leader>ar",
      function()
        local success, err = pcall(function()
          require('ollama').prompt('Review this code for: 1) Potential bugs or issues 2) Performance improvements 3) Code style and best practices 4) Security considerations')
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Review Code",
      mode = { "n", "v" },
    },
    -- Debug code
    {
      "<leader>ad",
      function()
        local success, err = pcall(function()
          require('ollama').prompt('Help me debug this code. What could be wrong and how can I fix it?')
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Debug Code",
      mode = { "n", "v" },
    },
    -- Generate code
    {
      "<leader>ag",
      function()
        local success, err = pcall(function()
          require('ollama').prompt('Generate code for the following request. Make it clean, efficient, and follow best practices:')
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Generate Code",
      mode = { "n", "v" },
    },
    -- Refactor code
    {
      "<leader>af",
      function()
        local success, err = pcall(function()
          require('ollama').prompt('Refactor this code to be more readable, maintainable, and follow best practices:')
        end)
        if not success then
          vim.notify("Ollama error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Ollama - Refactor Code",
      mode = { "n", "v" },
    },
  },
  opts = {
    -- Configure Ollama to use your Podman container
    url = "http://localhost:11434",
    model = "qwen2.5-Coder:0.5b",
  },
  config = function(_, opts)
    -- Setup ollama with default configuration
    local success, error = pcall(function()
      require("ollama").setup(opts)
    end)
    
    if not success then
      vim.notify("Ollama setup error: " .. tostring(error), vim.log.levels.ERROR)
      return
    end
    
    -- Verify connection to Podman Ollama container
    local function check_ollama()
      local handle = io.popen("curl -s http://localhost:11434/api/tags > /dev/null 2>&1 && echo 'OK' || echo 'FAIL'")
      local result = handle:read("*a")
      handle:close()
      
      if string.match(result, "OK") then
        vim.notify("✅ Ollama connected (qwen2.5-Coder:0.5b)", vim.log.levels.INFO)
      else
        vim.notify("⚠️ Ollama not running at localhost:11434", vim.log.levels.WARN)
      end
    end
    
    -- Check connection on startup
    vim.defer_fn(check_ollama, 2000)
    
    vim.notify("Ollama.nvim configured successfully", vim.log.levels.INFO)
  end,
}