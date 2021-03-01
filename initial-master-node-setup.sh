sudo kubeadm init --control-plane-endpoint "mnode.jasworks.org" --upload-certs --pod-network-cidr=10.116.0.0/16 --service-cidr=10.16.0.0/12 --apiserver-advertise-address=192.168.238.11 
