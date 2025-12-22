-- AI Integration Documentation

This directory contains configurations for two AI assistant plugins that work with LazyVim:

## OpenCode Plugin (`opencode.lua`)
- **Plugin**: `NickvanDyke/opencode.nvim`
- **Key Leader**: `<leader>o` for OpenCode commands
- **Features**:
  - Cloud-based AI (OpenAI, Claude, Gemini, etc.)
  - Multi-session support
  - Event handling and notifications
  - Embedded terminal integration
- **Keymappings**:
  - `<leader>oa` - Ask OpenCode
  - `<leader>oc` - Ask about cursor
  - `<leader>os` - Ask about selection
  - `<leader>ot` - Toggle OpenCode
  - `<leader>on` - New session
  - `<leader>oe` - Explain code near cursor
  - `<leader>or` - Review code near cursor
  - `<leader>od` - Debug code near cursor

## Ollama Plugin (`ollama.lua`)
- **Plugin**: `nomnivore/ollama.nvim`
- **Key Leader**: `<leader>o` for local AI commands (same as OpenCode)
- **Features**:
  - Local Ollama integration with Podman container
   - qwen2.5-Coder:0.5b model (lighter and faster)
  - Custom prompts for coding tasks
  - Visual selection support
  - No API key required
- **Keymappings**:
  - `<leader>oo` - Ollama prompt menu
  - `<leader>og` - Generate code
  - `<leader>oe` - Explain code
  - `<leader>or` - Review code
  - `<leader>od` - Debug code
  - `<leader>of` - Refactor code

## Usage Notes

### OpenCode Setup
1. Install OpenCode CLI: `curl -fsSL https://opencode.ai/install | bash`
2. Configure API keys: `/connect` command in OpenCode
3. Uses snacks.nvim for better input experience
4. **Key prefix**: `<leader>oa` for OpenCode-specific commands

### Ollama Setup
1. Podman Ollama container is already running: 
   ```bash
   # Container is running and accessible
   # podman ps shows: 0.0.0.0:11434->11434/tcp  ollama
   ```
2. Model: qwen2.5-Coder:0.5b is now configured (lighter and faster)
3. Local API endpoint: http://localhost:11434 (container port mapping)
4. **Key prefix**: `<leader>o` for Ollama commands

### Key Mapping Strategy
- **OpenCode**: `<leader>o*` (OpenCode - cloud AI)
- **Ollama**: `<leader>a*` (Ollama - local AI)  
- **Clear separation**: No conflicts, easy to remember
  - `o` prefix = OpenCode (cloud)
  - `a` prefix = Ollama (local)

### Installation
Both plugins will be automatically installed by LazyVim when Neovim starts up.

### Advantages of Ollama.nvim over sidekick.nvim
- Well-maintained and actively developed
- Better LazyVim integration
- Visual selection support with `<c-u>` prefix
- Custom prompt actions
- Automatic container connection checking