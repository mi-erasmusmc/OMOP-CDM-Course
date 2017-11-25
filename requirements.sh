# This script will start up your postgres server
REPO_PATH=OMOP-CDM-Course

pip3 install sqlwhat-ext==0.0.1

apt-get update && apt-get install -y unzip

mkdir -p $REPO_PATH/data
# You can replace this with a link to your archive of csv files
wget "https://s3.amazonaws.com/assets.datacamp.com/production/course_6000/datasets/vocab1.zip"
unzip vocab1.zip -d $REPO_PATH/data

service postgresql start   && sudo -u postgres createdb -O repl vocab1   && cd $REPO_PATH   && sudo -u postgres psql vocab1 < data/vocab1/vocab.sql   && service postgresql stop
