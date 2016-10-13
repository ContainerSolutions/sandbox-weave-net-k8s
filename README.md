# Sandbox Weave Net k8s

Experiment to run Weave Net on k8s. 

# Contact

* Maarten Hoogendoorn @moretea_nl
* Frank Scholten @Frank_Scholten

# How to start the k8s cluster

```
$ ./run_k8s_cluster.sh
```

This created a Dockerized k8s cluster available on the host at port 8080

# Using the k8s cluster

```
$ ./kubectl get pods --namespace=kube-system
```

# TODO

* Configure the Weave Net CNI plugin
* Can we run this without Docker?
* Fix failed mount

```
[maarten@maarten-laptop:~/cs/nanokube]$ ./kubectl describe pod kubernetes-dashboard-v1.4.0-3yfo7 --namespace=kube-system
Name:        kubernetes-dashboard-v1.4.0-3yfo7
Namespace:    kube-system
Node:        127.0.0.1/127.0.0.1
Start Time:    Thu, 13 Oct 2016 10:26:43 +0000
Labels:        k8s-app=kubernetes-dashboard
        kubernetes.io/cluster-service=true
        version=v1.4.0
Status:        Pending
IP:        
Controllers:    ReplicationController/kubernetes-dashboard-v1.4.0
Containers:
  kubernetes-dashboard:
    Container ID:    
    Image:        gcr.io/google_containers/kubernetes-dashboard-amd64:v1.4.0
    Image ID:        
    Port:        9090/TCP
    Limits:
      cpu:    100m
      memory:    50Mi
    Requests:
      cpu:        100m
      memory:        50Mi
    State:        Waiting
      Reason:        ContainerCreating
    Ready:        False
    Restart Count:    0
    Liveness:        http-get http://:9090/ delay=30s timeout=30s period=10s #success=1 #failure=3
    Volume Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-j9rg3 (ro)
    Environment Variables:    <none>
Conditions:
  Type        Status
  Initialized     True 
  Ready     False 
  PodScheduled     True 
Volumes:
  default-token-j9rg3:
    Type:    Secret (a volume populated by a Secret)
    SecretName:    default-token-j9rg3
QoS Class:    Guaranteed
Tolerations:    CriticalAddonsOnly=:Exists
Events:
  FirstSeen    LastSeen    Count    From            SubobjectPath    Type        Reason        Message
  ---------    --------    -----    ----            -------------    --------    ------        -------
  1m        9s        8    {kubelet 127.0.0.1}            Warning        FailedMount    MountVolume.SetUp failed for volume "kubernetes.io/secret/87730f5d-912f-11e6-bed9-208984d3285c-default-token-j9rg3" (spec.Name: "default-token-j9rg3") pod "87730f5d-912f-11e6-bed9-208984d3285c" (UID: "87730f5d-912f-11e6-bed9-208984d3285c") with: exit status
```


