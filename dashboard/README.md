Kubernetes Dashboard useful scripts:

start.sh
This script automates the process of creating a temporary service account for Kubernetes Cluster, generates the security token which allows you to copy & paste to your browser, then it creates a kubectl proxy process to allow access to the dashboard via localhost.

If you use it together with a SSH tunnel, you can use your own browser to access it remotely. This is useful because a lot of Cluster setup is headless, hence you will not have a browser in the localhost.

Once done, go to the terminal session and type STOP and press ENTER. It will kill the proxy, and remove the temporary credentials.

A ssh tunnel can be created on your own machine through

ssh -L 8001:localhost:8001 <master-node> "<path-to-script>/start.sh"
