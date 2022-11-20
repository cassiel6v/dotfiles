<div align="center">
    <h1>Dotfiles</h1>
    <p>
        Personal macOS dotfiles
    </p>
</div>

### Content

#### ~/.config

- **kitty** | Terminal Emulator

- **ranger** | TUI File Manager

- **neofetch** | System Fetch

- **nvim** | TUI Text Editor

- **btop** | TUI System Monitor

- **spaceship** | Shell Prompt

- **mpv** | Media Player

#### $HOME 

- **zprofile** | Shell (ZSH)


### Deployment

Dotfiles are deployed as symlinks into the ~/.config and $HOME directory as necessary, pointing back to the repository for easy updates and maintenance.

1. Clone this repo
```
git clone https://github.com/cassiel6v/dotfiles
```

2. Run the deployment script from within the dotfiles directory
```
cd dotfiles/
chmod +x deploy.sh
./deploy.sh
```
