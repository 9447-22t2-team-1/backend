# wget https://github.com/jeremylong/DependencyCheck/releases/download/v7.1.1/dependency-check-7.1.1-release.zip
# unzip dependency-check-7.1.1-release.zip
# rm dependency-check-7.1.1-release.zip
# cd dependency-check/bin/
# ln -s dependency-check.sh /usr/bin/dependency-check.sh

#Takes two arguments, the first is the name, the second is the path

dependency-check.sh --project $1 --format JSON --scan $2 