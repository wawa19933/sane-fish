if type -q bax
    bax source ~/.profile
else if type -q bass
    bass source ~/.profile
else if type -q dash
    env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" \
    | grep -Ev 'PWD|Agent' | source
else if type -q sh
    env -i HOME=$HOME sh -l -c 'export -p' | sed -e "/PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" \
    | grep -Ev 'PWD|Agent' | source
end
