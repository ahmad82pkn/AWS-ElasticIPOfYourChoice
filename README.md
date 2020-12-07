# AWS-ElasticIPOfYourChoice
If you want AWS EIP (ELASTIC IP) from particular range x.x.x.x in region Z , then you can try your luck with this shell script.
You might need to run it multiple times or you can modify number of attempts in the code.
But if the range is pre occuiped, then obviously, you can't get EIP.
A particular use case could be, you already have few EIP in a range, and you want more EIP from same range.
Or your ISP might have better path towards a particular range.
Or you just want to route few IP subnets on one ISP And other on other ISP etc.
