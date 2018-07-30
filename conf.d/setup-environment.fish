if type -q bass
    bass source ~/.profile
else
    env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" \
        | ag -v 'PWD|Agent' | source
end
