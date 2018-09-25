#!/bin/bash
usage() {
  echo 'usage: d(ocker) [p(ps)|a(attach)|l(logs)|t(ail_logs)|s(top)|r(estart)|i(nspect)]'
  echo '  ps'
  echo '  attach {id}'
  echo '  logs {id}'
  echo '  tail_logs {id}'
  echo '  stop {id}'
  echo '  restart {id}'
  echo '  inspect {id}'
}
if [ $# -eq 0 ]
then
  usage
elif [ "$1" = "p" -o "$1" = "ps" ]
then
  if [ $# -ge 2 ]
  then
    echo "sudo docker ps $2"
    sudo docker ps $2
  else
    echo "sudo docker ps"
    sudo docker ps
  fi
elif [ "$1" = "a" -o "$1" = "attach" ]
then
  echo "sudo docker exec -i -t $2 //bin/bash"
  sudo docker exec -i -t $2 //bin/bash
elif [ "$1" = "s" -o "$1" = "stop" ]
then
  echo "sudo docker stop $2"
  sudo docker stop $2
elif [ "$1" = "r" -o "$1" = "restart" ]
then
  echo "sudo docker restart $2"
  sudo docker restart $2
elif [ "$1" = 'l' -o "$1" = "logs" ]
then
  echo "sudo docker logs $2"
  sudo docker logs $2
elif [ "$1" = 't' -o "$1" = "tail_logs" ]
then
  echo "tail -f `sudo docker inspect --format='{{.LogPath}}' $2`"
  sudo tail -f `sudo docker inspect --format='{{.LogPath}}' $2`

elif [ "$1" = 'i' -o "$1" = "inspect" ]
then
  echo "sudo docker inspect --format='{{.LogPath}}' $2"
  sudo docker inspect --format='{{.LogPath}}' $2
else
  # all arguments except the first one (in a bash script)
  # will support docker shortcut `dk`
  echo "sudo docker ${@:1}"
  sudo docker ${@:1}
fi
exit 0