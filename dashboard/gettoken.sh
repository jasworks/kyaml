#!/bin/bash

USRNAME=$1

if [ "x$1" = "x" ]
then
  echo "Please specify a username"
  exit 1
fi
echo "The token for $USRNAME-dashboard-account is"
echo "Copy this token to your browser"
echo "-------------------------------"
echo
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/$USRNAME-dashboard-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
echo 
echo
echo "-------------------------------"
