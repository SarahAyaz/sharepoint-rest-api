repos=("airflow")
project="Business-Intelligence"

for repo in ${repos[@]}
do
    echo "Cloning $repo"
    repo_id=$(az repos show -r $repo --query id -p $project | tr -d '"')
    az repos show -r $repo --query sshUrl -p $project | tr -d '"' | while read sshUrl ; do git clone ${sshUrl} archive/$repo ; done
    cd archive/$repo
    git archive --format zip -o ../$repo.zip HEAD
    cd ..
    rm -r $repo
    cd ..
    echo "Deleting $repo with id $repo_id"
    az repos delete --id $repo_id -p $project
done    

echo "Archive complete"
