function update --description "Run updates for apt, brew, flatpak"
    command sudo apt update && sudo apt -y upgrade
    command brew update && brew upgrade
    command flatpak --system --assumeyes update
    command flatpak --user --assumeyes update
    command nvim --headless -c "Lazy! update" -c qall
end
