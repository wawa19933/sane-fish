if type -q balias
    set alias balias
else
    set alias alias
end

if type -q exa
    set base_ls 'exa --group-directories-first'
else
    set base_ls 'ls --group-directories-first -h'
end

if not type -q rg
    eval $alias rg 'grep -Ei'
else
    eval $alias rg 'rg -i'
end

eval $alias ip 'ip --color'
alias df 'df -kh'
alias du 'du -kh'
alias free 'free -h'
alias less 'less -iR'
# alias ping 'ping -c 5'
if type -q exa
    alias l "$base_ls -l"
    alias la "$base_ls -la"
    alias lr "$base_ls -R"
    alias le "$base_ls -la --sort extension"
    alias lss "$base_ls -la --sort size"
else
    alias l "$base_ls -l"
    alias la "$base_ls -lA"
    alias lr "$base_ls -R"
    alias le "$base_ls -lA --sort extension"
    alias lss "$base_ls -lA --sort size --reverse"
end
alias mkdir 'mkdir -pv'

# eval $alias rsync 'rsync -h --progress'
eval $alias rsync-copy "rsync -avh --progress"
eval $alias rsync-move "rsync -avh --remove-source-files --progress"
eval $alias rsync-update "rsync -avhu --progress"
eval $alias rsync-synchronize "rsync -avhu --delete --progress"

# Package managers
type -q pacman; and eval $alias pacman 'sudo pacman'
type -q dnf; and eval $alias dnf 'sudo dnf'
type -q yum; and eval $alias yum 'sudo yum'
type -q rpm; and eval $alias rpm 'sudo rpm'
type -q apt; and eval $alias apt 'sudo apt'
type -q apt-get; and eval $alias apt-get 'sudo apt-get'
type -q dpkg; and eval $alias dpkg 'sudo dpkg'

# Systemd
set -l user_commands \
      list-units list-sockets is-active status show help list-unit-files\
      is-enabled list-jobs show-environment cat list-machines

set -l sudo_commands \
      start stop reload restart try-restart isolate kill\
      reset-failed enable disable reenable preset mask unmask\
      link load cancel set-environment unset-environment\
      edit daemon-reload daemon-reexec

for c in $user_commands
    eval $alias sc-$c "systemctl $c"
end

for c in $sudo_commands
    eval $alias sc-$c "sudo systemctl $c"
end

# Nmap
alias nmap_open_ports "nmap --open"
alias nmap_list_interfaces "nmap --iflist"
alias nmap_slow "nmap -sS -v -T1"
alias nmap_fin "nmap -sF -v"
alias nmap_full "nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
alias nmap_check_for_firewall "nmap -sA -p1-65535 -v -T4"
alias nmap_ping_through_firewall "nmap -PS -PA"
alias nmap_fast "nmap -F -T5 --version-light --top-ports 300"
alias nmap_detect_versions "nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
alias nmap_check_for_vulns "nmap --script vulscan"
alias nmap_full_udp "nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
alias nmap_traceroute "nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
alias nmap_full_with_scripts "sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all "
alias nmap_web_safe_osscan "sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "

function dls --description "List directories only"
  command ls -lF $argv | grep '/$' | awk '{print $9}' | tr -d /
end

function getip --description "Get global IP address"
  command curl -s -S https://icanhazip.com
end

function ll -d "List files with pager"
  la --color always $argv | less
end
