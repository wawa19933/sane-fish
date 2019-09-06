if status --is-interactive; and type -q pyenv
    source (pyenv init -|psub)
end

set -q PYENV_HOME; or set -l PYENV_HOME $HOME/.pyenv
if status --is-interactive; and test -d $PYENV_HOME/plugins/pyenv-virtualenv
    source (pyenv virtualenv-init -|psub)
end
