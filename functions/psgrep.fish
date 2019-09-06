function psgrep --description 'grep ps output'
  command ps aux | grep -v 'grep -i' | grep -i $argv
end
