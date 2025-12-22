-- Sidekick AI Assistant Configuration for LazyVim
-- Integrated with opencode prompts and keymaps for a unified experience

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
      { "<leader>s", nil, desc = "+sidekick", mode = { "n", "v" } },
      { "<leader>st", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle", mode = { "n", "t", "i", "x" } },
      { "<leader>sa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },

      -- CLI management
      { "<leader>ss", function() require("sidekick.cli").select() end, desc = "Select AI Tool" },
      { "<leader>sd", function() require("sidekick.cli").close() end, desc = "Detach CLI Session" },

      -- ### Integrated OpenCode Keymaps ###
      { "<leader>o", nil, desc = "+opencode (migrated)", mode = { "n", "v" } },
      { "<leader>oe", send_prompt("explain"), desc = "Explain Code (Sidekick)", mode = { "n", "v" } },
      { "<leader>or", send_prompt("review"), desc = "Review Code (Sidekick)", mode = { "n", "v" } },
      { "<leader>od", send_prompt("debug"), desc = "Debug Code (Sidekick)", mode = { "n", "v" } },
      { "<leader>of", send_prompt("refactor"), desc = "Refactor Code (Sidekick)", mode = { "n", "v" } },
      { "<leader>ot", send_prompt("test"), desc = "Write Tests (Sidekick)", mode = { "n", "v" } },

      -- Original Send actions
      { "<leader>sc", function() require("sidekick.cli").send({ msg = "{this}" }) end, desc = "Send This", mode = { "x", "n" } },
      { "<leader>sf", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
      { "<leader>sv", function() require("sidekick.cli").send({ msg = "{selection}" }) end, desc = "Send Selection", mode = { "x" } },
      { "<leader>sp", function() require("sidekick.cli").prompt() end, desc = "Select Prompt", mode = { "n", "x" } },

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
      -- ### Integrated OpenCode Prompts ###
      prompts = {
        explain = "Explain this selected code in detail: {selection}",
        review = "Review this code for bugs and improvements: {selection}",
        refactor = "Refactor this code for better readability and performance: {selection}",
        debug = "Debug this code - find issues and suggest fixes: {selection}",
        test = "Write tests for this code: {selection}",
        -- Original sidekick prompts
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
    }):map("<leader>sn")

    vim.notify("✅ Sidekick AI assistant loaded with OpenCode integration", vim.log.levels.INFO)
  end,
}