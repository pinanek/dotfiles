# Init Oh My Posh theme
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$HOME\.dotfiles\oh-my-posh\pinanek.omp.yaml" --print) -join "`n"))

# Remove Python Virtual Env prefix
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
