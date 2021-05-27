# Kubeless-Kubernetes
 

How to build a kubernetes Cluster: 

Create an EC2 Instance 
Create an attach IAM to an EC2 Instance with the Following permissions: 
Kops need permissions to access
	S3
	EC2
	VPC
	Route53
	Autoscaling 

Create a domain name and register it with NameCheap: 
For Example: vianarumao.xyz
rumaoviana.xyz

Create a private hosted zone and enter your domain name 
Go to aws Route53 and create hostedzone.
Choose name for example (vianarumao.xyz)
Choose type as private hosted zone for VPC
Select default vpc in the region you are setting up your cluster
Select create




Install kops on EC2 

curl -LO https://github.com/kubernetes/kops/releases/download/v1.18.0/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops



Install kubctl 
curl -LO https://dl.k8s.io/release/v1.18.0/bin/linux/amd64/kubectl

S3 bucket is used by kubernetes to persist cluster state. Choose a unique bucket name.

Configuring your environment variables :
Open the Open .bashrc file by the following commands:

vi ~/.bashrc
Add the following in your .bashsrc file: Enter your cluster name and the S3 bucket name.
export KOPS_CLUSTER_NAME=vianarumao.xyz
export KOPS_STATE_STORE=s3://vianarumao.in.k8s

To reflect variables added to .bashrc type the below command

source ~/.bashrc


Creating a SSH key pair
Use the following command: 
ssh-keygen



Now create a cluster definition for your cluster: 
kops create cluster \
--ssh-public-key ~/.ssh/id_rsa.pub \
--state=${KOPS_STATE_STORE} \
--node-count=1 \
--master-size=t2.micro \
--node-size=t2.micro \
--zones=us-east-1a \
--name=${KOPS_CLUSTER_NAME} \
--dns=private \
--master-count=1


Note: Make sure your availability zone supports the instance type mentioned. Also, specify the key and the zone name.



 Now create a Kubernetes Cluster by the following command: 

        kops update cluster --yes --admin

Finally check  and validate your cluster to see it up running. Note this might take some time. Use the following command: 

        kops validate cluster





Now we can deploy the kubeless on the Kubernetes Cluster 

Follow the below commands: 

$ export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
$ kubectl create ns kubeless
$ kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml

$ kubectl get pods -n kubeless
$ kubectl get deployment -n kubeless
$ kubectl get customresourcedefinition

export OS=$(uname -s| tr '[:upper:]' '[:lower:]')
curl -OL https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless_$OS-amd64.zip && \
  unzip kubeless_$OS-amd64.zip && \
  sudo mv bundles/kubeless_$OS-amd64/kubeless /usr/local/bin/



Deploying the functions on the kubeless

We deploy the file named hello.py wherein we have the hello function defined. 

kubeless function deploy hello --runtime python3.8 \
                                --from-file hello.py \
                                --handler hello.hello

So the above command tells us how we deploy the function. So here we define the runtime which is python 3.8.Then we tell from which file does it take: in this case it’s hello.py and lastly we mention the file name and the function.


You will see the function's custom resource created and will see the function sent for execution and will be able to see the status whether it is ready or not. 


After the function status shows ready, call the function and you will see the output.


Code for the deploy script and the call_func:
https://github.com/rumaoviana/Kubeless-Kubernetes/tree/main

For the laptop as the Edge: 


Deploying the Minikube and Kubeless on the local machine (Windows) 


Deploying the OpenFaaS on kubernetes:

Refer the link: 
https://faun.pub/getting-started-with-openfaas-on-minikube-634502c7acdf

https://docs.openfaas.com/cli/templates/

sudo apt-get update -y &&  sudo apt-get install -y docker.io

Install the Minikube: 


















