# This script will start up your postgres server
REPO_PATH=OMOP-CDM-Course

pip3 install sqlwhat-ext==0.0.1

apt-get update && apt-get install -y unzip

mkdir -p $REPO_PATH/data
# You can replace this with a link to your archive of csv files
wget "https://s3.amazonaws.com/assets.datacamp.com/production/course_6000/datasets/vocab.zip"
unzip vocab.zip -d $REPO_PATH/data

service postgresql start   && sudo -u postgres createdb -O repl vocab   && cd $REPO_PATH   && sudo -u postgres psql vocab < data/vocab/vocab.sql   && service postgresql stop
