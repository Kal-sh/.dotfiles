# AI Shortcuts Reference

## 🌐 **OpenCode** (Cloud AI) - Prefix: `<leader>o`

| Shortcut | Command | Mode | Description |
|----------|---------|-------|-------------|
| `<leader>oa` | Ask | n,v | OpenCode - Ask general question |
| `<leader>oc` | Ask @cursor | n | OpenCode - Ask about cursor position |
| `<leader>os` | Ask @selection | v | OpenCode - Ask about selection |
| `<leader>ot` | Toggle | n | OpenCode - Toggle window |
| `<leader>on` | session_new | n | OpenCode - New session |
| `<leader>oy` | messages_copy | n | OpenCode - Copy last message |
| `<leader>op` | select_prompt | n,v | OpenCode - Select prompt from menu |
| `<leader>oe` | Explain @cursor | n | OpenCode - Explain code near cursor |
| `<leader>or` | Review @cursor | n | OpenCode - Review code near cursor |
| `<leader>od` | Debug @cursor | n | OpenCode - Debug code near cursor |
| `<leader>og` | Generate @cursor | n | OpenCode - Generate code |
| `<leader>of` | Refactor @cursor | n | OpenCode - Refactor code near cursor |
| `<leader>ok` | clear | n | OpenCode - Clear messages |

## 🏠 **Ollama** (Local AI) - Prefix: `<leader>a`

| Shortcut | Command | Mode | Description |
|----------|---------|-------|-------------|
| `<leader>aa` | prompt | n,v | Ollama - Open prompt menu |
| `<leader>ag` | prompt | n,v | Ollama - Generate code |
| `<leader>ae` | prompt | n,v | Ollama - Explain code |
| `<leader>ar` | prompt | n,v | Ollama - Review code |
| `<leader>ad` | prompt | n,v | Ollama - Debug code |
| `<leader>af` | prompt | n,v | Ollama - Refactor code |

## 🎯 **How to Remember**

- **`o`** = **OpenCode** (cloud AI - single letter)
- **`a`** = **AI/Local** (local AI - single letter)

## 🚀 **Usage Tips**

### For Quick AI Help:
1. **Select code** (V, v, or Ctrl+V)
2. **Choose AI type**:
   - `<leader>aa` for fast local AI (Ollama/qwen2.5-Coder:0.5b)
   - `<leader>oa` for powerful cloud AI (OpenCode/GPT/Claude)

### Code Analysis Workflow:
1. **Select problematic code**
2. **Try local first**: `<leader>ad` (Ollama debug)
3. **If needed**: `<leader>od` (OpenCode debug)

### Selection Support:
- **OpenCode**: Full context support (@cursor, @selection)
- **Ollama**: Uses selected text automatically in prompts

## 📖 **Key Differences**

| Feature | OpenCode | Ollama |
|---------|-----------|---------|
| AI Type | Cloud (GPT/Claude/Gemini) | Local (qwen2.5-Coder:0.5b) |
| Speed | Slower but smarter | Faster but smaller model |
| Cost | API costs | Free (local) |
| Setup | API keys needed | Container required |
| Selection | @cursor/@selection syntax | Automatic in prompts |
| Context | Full project awareness | File-based selection |

## ⚠️ **Important Notes**

- **No conflicts**: Different prefixes (`o` vs `a`)
- **Both work together**: Run simultaneously if needed
- **API keys**: Only OpenCode needs them, Ollama works offline
- **Container required**: Make sure `podman ps | grep ollama` shows running container

## 🔧 **Troubleshooting**

### OpenCode Issues:
- **lsof error**: `sudo pacman -S lsof` (already installed)
- **Selection issues**: Use visual mode (V/v/C-v) before commands
- **Connection**: `/connect` in OpenCode CLI

### Ollama Issues:
- **Container**: `podman start ollama` if stopped
- **Model**: Check `curl -s http://localhost:11434/api/tags`
- **Timeout**: Adjusted to 60 seconds for local model

## 🎉 **Quick Start**

1. **Restart Neovim** to apply configurations
2. **Test local AI**: Select code + `<leader>ae`
3. **Test cloud AI**: Select code + `<leader>oe`

Both systems are now fully separated and functional!