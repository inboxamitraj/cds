# I am trying to create an A record in hosted zone that points to Kong ingress controller NLB.
# r53 A record requires IP address for assignement 
# dns_name of nlb does not have an IP address, hence it is required to create elastic ip and assign it to NLB
/*
Error: creating Route 53 Record: InvalidChangeBatch: [Invalid Resource Record: 'FATAL problem: ARRDATAIllegalIPv4Address (Value is not a valid IPv4 address) encountered with 'a8766bd02556a46b0957e35a3b1d580f-552b7cf33ac3c5ae.elb.ap-southeast-1.amazonaws.com'']
│       status code: 400, request id: 97a38a45-2490-49e6-8e57-98eb7a3e80df
*/