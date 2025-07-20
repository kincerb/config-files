function update --description "Run updates for apt, brew, flatpak"
    command sudo apt update && sudo apt -y upgrade
    command brew update && brew upgrade
    command sudo flatpak update
    command flatpak update
end
