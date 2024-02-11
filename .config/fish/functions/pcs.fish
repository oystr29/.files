function pcs --wraps='sudo pacman -S' --description 'alias pcs sudo pacman -S'
  sudo pacman -S $argv
        
end
