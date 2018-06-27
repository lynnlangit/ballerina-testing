# ISTIO Sample

From [here](https://ballerina.io/learn/by-guide/ballerina-with-istio/)

## Build YAML Files  

`$ ballerina build time_service.bal`

        @kubernetes:Service             - complete 1/1
        @kubernetes:Ingress             - complete 1/1
        @kubernetes:Docker              - complete 3/3
        @kubernetes:Deployment          - complete 1/1

Run following command to deploy kubernetes artifacts:  
`kubectl apply -f /Users/kasun/Dev/Source/git/kasun04/ballerina-guides/using-kubernetes/src/kubernetes/`
