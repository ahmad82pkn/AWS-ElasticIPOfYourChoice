echo "Please Enter Subnet in which you want EIP, example 13.0.0.0/8 or 52.34.0.0/16 etc"
read DESIREDIP
echo "Please Enter Region in format ap-southeast-2, us-east-1 etc"
read REGION
read var1 var2 < <(echo $(aws ec2 allocate-address --domain vpc --region $REGION | jq -r '.PublicIp, .AllocationId'))
count=0
grepcidr "$DESIREDIP" <(echo "$var1") >/dev/null
value=$?
        if [ $value -eq 0 ]
        then
                echo "You are Lucky to Find your desired IP $var1 is in $DESIREDIP range."
                echo "PublicIp : $var1"
                echo "AllocationId : $var2"
        else
                while [ $value -eq 1 ] && [ $count -le 50 ]; do
                        aws ec2 release-address --allocation-id $var2 --region $REGION
                        read var1 var2 < <(echo $(aws ec2 allocate-address --domain vpc --region $REGION | jq -r '.PublicIp, .AllocationId'))
                        grepcidr "$DESIREDIP" <(echo "$var1") >/dev/null
                        value=$?
                        if [ $value -eq 1 ]
                        then
                        ((count++))
                        echo "Number of attempts made $count"
                        continue
                        else
                        echo "You are Lucky to Find your desired $IP is in $DESIREDIP range"
                        echo "PublicIp : $var1"
                        echo "AllocationId : $var2"
                        break
                        fi
                done
                #echo "100 attempts made, exiting"
        fi
if [ $count -ge 49 ]
then
echo "50 attempts made, exiting"
fi
