#!/bin/bash

USRNAME=$1
EXEPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
EXEDIR=`dirname $EXEPATH`


echo "
===============================
This little tool will help you create a service account and generate a
token for remote accessing Kubernetes-Dashboard

If you create an ingress for the dashboard, you can use the token generated
to login to it.

Please ensure that you keep this token safe because it can be used to control
everything in the cluster !!! "
if [ "x$1" = "x" ]
then
  echo "Please specify a username"
  exit 1
fi
echo "
The user $USRNAME-dashboard-account will be generated in the
kubernetes-dashboard namespace
"
echo -n "Press ENTER to continue..., or Control-C to break ..."
read abc

sed "s/dashboard-admin-user/$USRNAME-dashboard-user/g" $EXEDIR/user-tmpl.yaml | kubectl apply -f -
echo "Copy this token to your browser"
echo "-------------------------------"
echo
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/$USRNAME-dashboard-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
echo 
echo
echo "-------------------------------"
