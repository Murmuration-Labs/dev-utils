
## Create static IP 
gcloud compute addresses create btscr-dev-vm-ip \
 --project=<project-name> \
 --network-tier=STANDARD \
 --region=europe-west3

## Setup http/s rules
gcloud compute firewall-rules create allow-http \
 --project=<project-name> \
 --direction=INGRESS \
 --network=default \
 --action=ALLOW \
 --rules=tcp:80 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=http-server

gcloud compute firewall-rules create allow-https \
 --project=<project-name> \
 --direction=INGRESS \
 --network=default \
 --action=ALLOW \
 --rules=tcp:443 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=https-server


## clone utils repository to use the setup script in the create vm command
git clone https://github.com/keyko-io/dev-utils.git
cd ~/dev-utils/vm-setup

## Get the IP address and set it on the envvar IP_ADDRESS_DEV_MACHINE
gcloud compute addresses list --project=<project-name> 
// find the address for btscr-dev-vm-ip and set it on this EnvVar
export IP_ADDRESS_DEV_MACHINE=""

## This is the command to create the vm
gcloud compute instances create btscr-dev-vm \
 --project=<project-name> \
 --zone=europe-west3-a \
 --machine-type=n1-standard-1 \
 --preemptible \
 --image=ubuntu-2004-focal-v20220419 \
 --image-project=ubuntu-os-cloud \
 --boot-disk-size=100GB \
 --boot-disk-type=pd-standard \
 --boot-disk-device-name=btscr-dev-vm \
 --metadata-from-file startup-script=ubuntu.sh \
 --network-tier=PREMIUM \
 --address=$IP_ADDRESS_DEV_MACHINE \
 --subnet=default \
 --tags=http-server,https-server



