if [ -n "$(which jira)" ]
then
    echo "$(which jira)"
    eval "$(jira --completion-script-bash)"
fi
