#!/bin/bash


function build_image_web(){
    DOCKER_USERNAME=$1
    DOCKER_PASSWORD=$2
    DOCKER_REPOSITORY=$3
    docker build -t web-app -f web-app/app/Dockerfile web-app/app
    echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
    docker tag web-app $DOCKER_REPOSITORY/helloworld-web-app:0.1
    docker push $DOCKER_REPOSITORY/helloworld-web-app:0.1
}

usage() {
echo -e "\n"
echo "docker build "
echo "${yellow}Usage: $0 -u [user] -p password -r repo" 1>&2;
echo "${yellow}Usage: $0 [option...] " >&2
echo "Options:"
echo "-u docker_user [ docker user  ]"
echo "-p password [ docker password ]"
echo "-r docker_repo [ docker repo  ]"
}
while getopts ":u:p:r:" o; do
    case "${o}" in
        u)
            u=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        r)
            r=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${u}" ] ||  [ -z "${p}" ] || [ -z "${r}" ] ; then
    usage
else
    build_image_web ${u} ${p} ${r} 
fi





