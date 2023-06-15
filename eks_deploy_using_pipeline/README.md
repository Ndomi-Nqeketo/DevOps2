These are the resources that will be created.


`Backend`
* DynamoDB
    - This will be used to lock the state.

* S3 Bucket
    - This will store the state of the infrastructure
    - Manually create the bucket.

* Install the AWS provider


`VPC`
* Cidr 
    - 10.1.0.0/16

`Subnets`
* Public
    - 10.1.1.0/24
    - 10.1.2.0/24
* Private
    - 10.1.3.0/24
    - 10.1.4.0/24

`Security groups`

`route_tables`

`Nat Gateway`

`Internet Gateway`

`Elastic IP`

`worker nodes`

`datasource`
* To automatically choose an EC2 Instance

`Eks Cluster`

`Buildspec`
* buildspec-plan
* buildspec-apply
* buildspec-destroy => This is not used in this example


**This is NOT production ready**

