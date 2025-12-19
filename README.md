> ⚠️ **Important Warning**
>
> The `boss_script.sh` installer in `.dotfiles/script/` will **fully configure your shell environment** by linking this repository’s dotfiles into your home directory.
> **Running this script will permanently delete and replace** certain existing files and directories in your home folder with **symbolic links** from this repo.
>
> 🚨 **The following will be removed and replaced:**
>
> * `~/.bashrc`
> * `~/.bash_profile`
> * `~/.zshrc`
> * `~/.zshenv`
> * `~/.icons/` *(directory)*
> * `~/.theme/` *(directory)*
>
> 📌 **Important:**
>
> * Any custom configurations, themes, icons, aliases, plugins, or environment tweaks you currently have in these locations will be overwritten.
> * After running the script, your shell environment (including themes and icons) will be managed entirely through this `.dotfiles` repository via symlinks.
>
> 🧠 **Before you continue:**
> Make sure you back up anything you want to keep! You can use the following commands to create backups:
>
> ```bash
> cp ~/.bashrc ~/.bashrc.backup
> cp ~/.bash_profile ~/.bash_profile.backup
> cp ~/.zshrc ~/.zshrc.backup
> cp ~/.zshenv ~/.zshenv.backup
> cp -r ~/.icons ~/.icons.backup
> cp -r ~/.theme ~/.theme.backup
> ```
>
> ✅ Once you’ve backed up your files and folders, you can safely run the script.
> Proceed with caution!


