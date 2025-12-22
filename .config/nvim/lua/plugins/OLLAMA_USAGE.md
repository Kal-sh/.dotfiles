# Ollama.nvim Usage Guide

## Model Updated ✅
- Changed to **qwen2.5-Coder:0.5b** (lighter and faster than 1.5b)

## How to Select Code for AI Analysis

### Method 1: Visual Selection (Recommended)
1. **Select code** using any visual mode:
   - `V` - Line-wise visual mode (select entire lines)
   - `v` - Character-wise visual mode (select specific characters)
   - `<C-v>` - Block-wise visual mode (select rectangular blocks)

2. **Use keybinds** while text is selected:
   - `<leader>oe` - Explain selected code
   - `<leader>or` - Review selected code  
   - `<leader>od` - Debug selected code
   - `<leader>of` - Refactor selected code
   - `<leader>og` - Generate code (with selection as context)

### Method 2: Current Line/Context
- **Place cursor** on the line/section you want to analyze
- Use the same keybinds (`<leader>oe`, `<leader>or`, etc.)
- Ollama will analyze the current code context

### Method 3: Prompt Menu
- `<leader>oo` - Opens Ollama prompt menu
- Select from available prompts manually
- Any selected text will be included automatically

## Visual Selection Examples

### To Explain a Function:
```lua
-- Place cursor on function line, press V to select entire function
local function greet(name)
  print("Hello, " .. name)
end
-- Press <leader>oe while selected
```

### To Review a Block:
```lua
-- Select multiple lines with V or line numbers with V[line count]
if user and user authenticated then
  return access_granted()
else
  return access_denied()
end
-- Press <leader>or while selected
```

### To Debug a Specific Line:
```lua
-- Use character-wise selection (v) to select specific parts
local result = calculate_total(items * tax_rate) -- select this expression
-- Press <leader>od while selected
```

## Key Benefits of qwen2.5-Coder:0.5b
- **Faster response time** (smaller model)
- **Lower memory usage** 
- **Better for quick explanations** and code reviews
- **Still good coding capabilities** for most tasks

## Pro Tips
1. **Selection size matters** - Larger selections = more context but slower responses
2. **Be specific** - Select just the relevant code, not entire files
3. **Combine methods** - Select code, then use `<leader>oo` for custom prompts
4. **Use visual mode** - More reliable than cursor position for context

## Troubleshooting
- **Selection not working?** Make sure you're in visual mode (should see highlighted text)
- **No response?** Check Ollama container: `podman ps | grep ollama`
- **Wrong model?** Check: `curl -s http://localhost:11434/api/tags | jq -r '.models[].name'`