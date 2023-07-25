# TODO: resolve yq dependency on jq
# yq commands won't execute unless jq is intalled and included in the path
project=$(python -m yq '.devops.project' ./parameters.yaml | tr -d '"')
echo "Cleanup Repositories in $project DevOps"
repo_list=()

while IFS=', ' read -r line
do
    repo="${line}"
    echo "Cloning $repo"
    az repos show -r $repo --query sshUrl -p $project | tr -d '"' | \
    while read sshUrl ; do git clone ${sshUrl} archive/$repo ; done && \
    echo "Clone complete, starting compression"
    
    cd archive/$repo && \
    git archive --format zip -o ../$repo.zip HEAD && \
    echo "Compression completed"
    
    echo "Deleting $repo clone"
    cd .. && rm -r -f $repo && cd .. && \
    echo "$repo successfully cloned"

done <<< "$(python -m yq '.archive_file_config.list' ./parameters.yaml | tr -d '[""],' | sed '/^[[:space:]]*$/d')"
