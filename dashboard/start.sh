#!/bin/bash

USRNAME=`uuidgen | cut -f 1 -d '-'`
EXEPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
EXEDIR=`dirname $EXEPATH`

sed "s/dashboard-admin-user/$USRNAME-dashboard-user/g" $EXEDIR/user-tmpl.yaml | kubectl apply -f -

echo ""
echo "==============================="
echo "This little tool will help you create a unique service account and generate a token for remote accessing Kubernetes-Dashboard"
echo
echo "It should be run via a SSH tunnel with your own machine, normally using this format:"
echo "ssh -L 8001:localhost:8001 <master node> <path-to-script>/start.sh"
echo ""
echo "Once started, using your local browser to access"
echo ""
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
echo ""
echo "and copy the token to the login window to access the dashboard"
echo ""
echo "Copy this token to your browser"
echo "-------------------------------"
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/$USRNAME-dashboard-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
echo ""
echo "-------------------------------"
kubectl proxy 1> /dev/null 2> /dev/null &

sleep 1

ans=""

while [ "x$ans" != "xSTOP" ]
do
  echo -n "Enter STOP to stop everything: "
  read ans
done

pkill -f "kubectl proxy"
kubectl -n kubernetes-dashboard delete serviceaccount $USRNAME-dashboard-user
kubectl delete clusterrolebinding $USRNAME-dashboard-user
