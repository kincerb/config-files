function update --description "Run updates for apt, brew, flatpak"
    if command -qs apt
        command sudo apt update && sudo apt -y upgrade
    else if command -qs garuda-update
        command sudo garuda-update -noconfirm
    end

    if command -qs brew
        command brew update
        command brew upgrade --no-ask
        command brew upgrade --cask --greedy --no-ask
    end

    if command -qs flatpak
        command sudo flatpak --system --assumeyes update
        command flatpak --user --assumeyes update
    end

    if command -qs snap
        command snap refresh
    end

    if command -qs nvim
        command nvim --headless -c "Lazy! update" -c qall
    end
end
