#!/bin/bash
subnetId="subnet-5c0a9861"
securityGroupId="sg-6976ee12"
loadBalancerName="dk-load-balancer"

# Loop to spin up number of ec2 instances
for i in `seq 0 1`;
do
	instanceId=`aws ec2 run-instances --image-id ami-fce3c696 --count 1 --instance-type t2.micro --key-name "First_Key" --security-group-ids $securityGroupId --subnet-id $subnetId --associate-public-ip-address --query 'Instances[0].InstanceId' --output text`
	instanceUrl=`aws ec2 describe-instances --instance-ids $instanceId --query 'Reservations[0].Instances[0].PublicDnsName' --output text`

	echo "Instance ID: " $instanceId
	echo "Instance URL: " $instanceUrl
	echo
	arrayInstances+=($instanceId)
	arrayUrls+=($instanceUrl)
done

# Initiate an elastic load balancer and get its assigned DNS name
elbDns=`aws elb create-load-balancer --load-balancer-name $loadBalancerName --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80" --subnets $subnetId --security-groups $securityGroupId | jq -r '.DNSName'`

echo 'Load balancer DNS:' $elbDns

# Wait for instances to initiate
echo "Waiting for instances to initiate..."
sleep 60s
echo "Please wait for two more minutes..."
sleep 60s
echo "Wait 60 more seconds..."
sleep 60s

# Associate ELB to EC2 instances and ping instances
echo "**** Adding instances to ELB and validating response from instances..."
for i in `seq 0 1`;
do
	aws elb register-instances-with-load-balancer --load-balancer-name $loadBalancerName --instances ${arrayInstances[i]}
	ping -c 2 ${arrayUrls[i]}
done

# Validating ELB response
echo "**** Validating ELB response..."
ping -c 2 $elbDns

# Bootstrap nodes though Chef recipes
echo "**** Bootstrapping nodes with Chef..."
for i in `seq 0 1`;
do
	knife bootstrap ${arrayUrls[i]} --ssh-user ubuntu --sudo --identity-file ~/Documents/First_Key.pem --node-name node$i --run-list 'recipe[learn_chef_apache2]'
done

echo 'Navigate to Load balancer DNS to test:' $elbDns
echo
echo "**** Script ended normally. Goodbye. ****"
