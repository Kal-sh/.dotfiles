-- Sidekick AI Assistant Configuration for LazyVim

return {
  "folke/sidekick.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  cmd = { "Sidekick" },
  keys = function()
    -- Helper function to send prompts to Sidekick, using selection or cursor context
    local function send_prompt(prompt)
      return function()
        local mode = vim.fn.mode()
        local term = (mode == "v" or mode == "V") and "{selection}" or "{cursor}"
        require("sidekick.cli").send({
          prompt = prompt,
          term = term,
        })
      end
    end

    return {
      -- Sidekick toggle (main command)
      { "<leader>o", nil, desc = "+sidekick", mode = { "n", "v" } },
      { "<leader>ot", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle", mode = { "n", "t", "i", "x" } },
      { "<leader>oa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },

      -- CLI management
      { "<leader>os", function() require("sidekick.cli").select() end, desc = "Select AI Tool" },
      { "<leader>od", function() require("sidekick.cli").close() end, desc = "Detach CLI Session" },

      -- Original Send actions
      { "<leader>oc", function() require("sidekick.cli").send({ msg = "{this}" }) end, desc = "Send This", mode = { "x", "n" } },
      { "<leader>of", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
      { "<leader>ov", function() require("sidekick.cli").send({ msg = "{selection}" }) end, desc = "Send Selection", mode = { "x" } },
      { "<leader>op", function() require("sidekick.cli").prompt() end, desc = "Select Prompt", mode = { "n", "x" } },

      -- NES (Next Edit Suggestions) - AI inline suggestions
      { "<Tab>", function()
        local Nes = require("sidekick.nes")
        if not Nes.have() then
          return false
        end
        if Nes.jump() then
          return true
        end
        return Nes.apply()
      end, desc = "AI Next Edit", mode = { "n" }, expr = true },
    }
  end,
  opts = function()
    -- Enable NES for inline AI suggestions
    return {
      -- add tools
      tools = {
        -- Gemini CLI; requires google-generativeai client
        gemini = {
          -- make sure you have the gemini cli installed
          -- pip install google-generativeai
          cmd = "gemini",
          -- The prompt will be piped to stdin
        },
        -- OpenCode CLI
        opencode = {
          cmd = "opencode",
          args = { "-a" }, -- -a for ask, prompt will be piped to stdin
        },
      },
      -- Enable NES (Next Edit Suggestions)
      nes = {
        enabled = true,
        auto_jump = false,
        auto_apply = false,
      },
      -- Configure sidekick window
      window = {
        width = 80,
        height = 20,
        border = "rounded",
      },
      -- Prompts
      prompts = {
        explain = "Explain this selected code in detail: {selection}",
        review = "Review this code for bugs and improvements: {selection}",
        refactor = "Refactor this code for better readability and performance: {selection}",
        debug = "Debug this code - find issues and suggest fixes: {selection}",
        test = "Write tests for this code: {selection}",
        optimize = "Optimize this code for performance: {selection}",
        comment = "Add comments to this code: {selection}",
        complete = "Complete this code: {this}",
        fix = "Fix any issues in this code: {selection}",
      },
    }
  end,
  config = function(_, opts)
    require("sidekick").setup(opts)

    -- Add snacks.nvim integration for better picker support
    if package.loaded["snacks"] then
      require("snacks").setup({
        picker = {
          actions = {
            sidekick_send = function(...)
              return require("sidekick.cli.picker.snacks").send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<cr>"] = { "sidekick_send", mode = { "n", "i" } },
              },
            },
          },
        },
      })
    end

    -- Toggle for NES
    require("snacks").toggle({
      name = "Sidekick NES",
      get = function()
        return require("sidekick.nes").enabled
      end,
      set = function(state)
        require("sidekick.nes").enable(state)
      end,
    }):map("<leader>on")

    vim.notify("✅ Sidekick AI assistant loaded", vim.log.levels.INFO)
  end,
}