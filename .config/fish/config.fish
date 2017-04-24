# Path to Oh My Fish install.
set -gx OMF_PATH "/home/corn/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/corn/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias gs "git status"
alias gd "git diff"
alias pp "git pull origin; git push origin"
alias rs "./manage.py runserver 0.0.0.0:8000"
alias sp "./manage.py shell_plus"
alias g "git"

function pp
    git pull origin $argv ;git push origin $argv;
end

function push
    git push origin $argv
end

function pull
    git pull origin $argv
end

eval (python -m virtualfish)

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# AutoenvFish
# Directory-based environments, inspired by Kenneth Reitz's autoenv

# allow overriding of the default autoenvfish file name
if not set -q AUTOENVFISH_FILE
    set -g AUTOENVFISH_FILE ".env.fish"
end

# Automatic env loading when the current working dir changes
# inspired by virtualfish (https://github.com/adambrenecki/virtualfish)
function _autoenvfish --on-variable PWD
    if status --is-command-substitution # doesn't work with 'or', inexplicably
        return
    end

    # find an autoenv file, checking up the directory tree until we find
    # such a file (or nothing)
    set -l envfishdir $PWD
    while test ! "$envfishdir" = "" -a ! -f "$envfishdir/$AUTOENVFISH_FILE"
        # this strips the last path component from the path.
        set envfishdir (echo "$envfishdir" | sed 's|/[^/]*$||')
    end
    set -l envfishpath "$envfishdir/$AUTOENVFISH_FILE"
    if [ $envfishpath != "$AUTOENVFISH" ]
        # New path is different...
        if [ -f $envfishpath ]
            # congratulations, it's a file!
            # variable change triggers loading of the fishenv file
            set -gx AUTOENVFISH $envfishpath
        else
            # file doesn't exist, so null out $AUTOENVFISH
            set -ex AUTOENVFISH
        end
    end
end

# Triggered upon change of $AUTOENVFISH, source it if the file exists
function _source_envfish --on-variable AUTOENVFISH
    if [ -f "$AUTOENVFISH" ]
        echo "loading $AUTOENVFISH"
        . $AUTOENVFISH
    end
end

