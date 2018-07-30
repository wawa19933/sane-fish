function psgrep --description 'grep ps output'
  command ps aux | rg -v 'rg -i' | rg -i $argv
end
