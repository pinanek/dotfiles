# Windows configs

My Powershell, Terminal and winget configs 😉

## Installation

- winget: Edit winget settings using the command `winget settings` or you can copy [`winget-settings.json`](winget-settings.json) file to `$HOME\AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json`

- Cascadia Code Nerd Font: Download and install using this link [https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip)

- Oh My Posh

  ```ps1
  winget install -e --id JanDeDobbeleer.OhMyPosh
  ```

  Copy folder [`oh-my-posh`](../oh-my-posh/) in the repo's root to `$HOME\.dotfiles`

- Powershell: Install with `winget`

  ```ps1
  winget install -e --id Microsoft.PowerShell
  ```

  Open Powershell as admin an run

  ```ps1
  Set-ExecutionPolicy RemoteSigned
  ```

  Copy [`Microsoft.PowerShell_profile.ps1`](Microsoft.PowerShell_profile.ps1) to `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

- Terminal: Upgrade to the latest version

  ```ps1
  winget upgrade -e --id Microsoft.WindowsTerminal
  ```

  And copy [`windows-terminal-settings.json`](windows-terminal-settings.json) to `$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
