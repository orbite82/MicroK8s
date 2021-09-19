# MicroK8s
Estudos e Poc Micro k8s - https://microk8s.io/

* __Install MicroK8s on Linux:__ 

  * Link de referencia Installing snap on Linux Mint:

   [Link](https://snapcraft.io/docs/installing-snap-on-linux-mint)

  ```
   sudo rm /etc/apt/preferences.d/nosnap.pref

  ```
  ```
   sudo apt update

  ```
  ```
   sudo apt install snapd

  ```
  ```
  sudo snap install microk8s --classic

  ```

* __Check the status while Kubernetes starts__  

  ```
   microk8s status --wait-ready

  ```
  ```
   ┌─[orbite]@[Navita]:~/MicroK8s
   └──> $ microk8s status --wait-ready
   Insufficient permissions to access MicroK8s.
   You can either try again with sudo or add the user orbite to the 'microk8s' group:

    sudo usermod -a -G microk8s orbite
    sudo chown -f -R orbite ~/.kube

  ```
  ```
   sudo usermod -a -G microk8s orbite

  ```
  ```
   sudo chown -f -R orbite ~/.kube
  
  ```  
  * Reboot 

  ```
    ┌─[orbite]@[Navita]:~/MicroK8s
    └──> $ microk8s status --wait-ready
    microk8s is running
    high-availability: no
      datastore master nodes: 127.0.0.1:19001
      datastore standby nodes: none
    addons:
      enabled:
        ha-cluster           # Configure high availability on the current node
      disabled:
        ambassador           # Ambassador API Gateway and Ingress
        cilium               # SDN, fast with full network policy
        dashboard            # The Kubernetes dashboard
        dns                  # CoreDNS
        fluentd              # Elasticsearch-Fluentd-Kibana logging and monitoring
        gpu                  # Automatic enablement of Nvidia CUDA
        helm                 # Helm 2 - the package manager for Kubernetes
        helm3                # Helm 3 - Kubernetes package manager
        host-access          # Allow Pods connecting to Host services smoothly
        ingress              # Ingress controller for external access
        istio                # Core Istio service mesh services
        jaeger               # Kubernetes Jaeger operator with its simple config
        keda                 # Kubernetes-based Event Driven Autoscaling
        knative              # The Knative framework on Kubernetes.
        kubeflow             # Kubeflow for easy ML deployments
        linkerd              # Linkerd is a service mesh for Kubernetes and other frameworks
        metallb              # Loadbalancer for your Kubernetes cluster
        metrics-server       # K8s Metrics Server for API access to service metrics
        multus               # Multus CNI enables attaching multiple network interfaces to pods
        openebs              # OpenEBS is the open-source storage solution for Kubernetes
        openfaas             # openfaas serverless framework
        portainer            # Portainer UI for your Kubernetes cluster
        prometheus           # Prometheus operator for monitoring and logging
        rbac                 # Role-Based Access Control for authorisation
        registry             # Private image registry exposed on localhost:32000
        storage              # Storage class; allocates storage from host directory
        traefik              # traefik Ingress controller for external access

  ```   

* __Turn on the services you want__
 
  ```
  microk8s enable dashboard dns registry istio

  ```
   * Try microk8s enable --help for a list of available services and optional features. microk8s disable <name> turns off a service.

* __Start using Kubernetes__

   ```
   microk8s kubectl get all --all-namespaces

   ```
   ```
    ┌─[orbite]@[Navita]:~/MicroK8s
    └──> $ microk8s kubectl get all --all-namespaces
    NAMESPACE            NAME                                             READY   STATUS              RESTARTS   AGE
    kube-system          pod/calico-kube-controllers-f7868dd95-57j8h      1/1     Running             1          21m
    kube-system          pod/metrics-server-8bbfb4bdb-5ftk8               1/1     Running             0          106s
    kube-system          pod/calico-node-nxd72                            1/1     Running             1          21m
    kube-system          pod/kubernetes-dashboard-85fd7f45cb-4sdvf        0/1     ContainerCreating   0          25s
    istio-system         pod/istio-grafana-post-install-1.5.1-5gcnx       0/1     ContainerCreating   0          22s
    istio-system         pod/istio-security-post-install-1.5.1-x4zjm      0/1     ContainerCreating   0          22s
    istio-system         pod/istio-galley-6fb8c7b586-dt4pf                0/1     ContainerCreating   0          21s
    istio-system         pod/istio-egressgateway-674898c6-rhj5z           0/1     ContainerCreating   0          21s
    istio-system         pod/istio-ingressgateway-5ff49854cc-sxjvl        0/1     ContainerCreating   0          21s
    istio-system         pod/grafana-74488d57b4-vxrfm                     0/1     ContainerCreating   0          21s
    istio-system         pod/kiali-75b58b6fd8-r8w8p                       0/1     ContainerCreating   0          21s
    istio-system         pod/istio-policy-56698c6987-bnsdv                0/2     ContainerCreating   0          21s
    istio-system         pod/istio-pilot-6976cdf765-8cjl6                 0/2     ContainerCreating   0          20s
    istio-system         pod/istio-sidecar-injector-69f7fcc574-n6s9d      0/1     ContainerCreating   0          20s
    istio-system         pod/istio-telemetry-6f4556487d-m29zh             0/2     ContainerCreating   0          20s
    istio-system         pod/prometheus-95dd89f5b-27h2k                   0/1     ContainerCreating   0          20s
    istio-system         pod/istio-citadel-67658cf6c-dvd4k                0/1     ContainerCreating   0          20s
    kube-system          pod/hostpath-provisioner-5c65fbdb4f-fv8ts        1/1     Running             0          25s
    kube-system          pod/coredns-7f9c69c78c-65kg7                     1/1     Running             0          25s
    istio-system         pod/istio-tracing-c69cb5cf5-shsz2                0/1     ContainerCreating   0          20s
    container-registry   pod/registry-9b57d9df8-q6b96                     0/1     ContainerCreating   0          25s
    kube-system          pod/dashboard-metrics-scraper-78d7698477-tqxl4   1/1     Running             0          25s

    NAMESPACE            NAME                                TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                                                      AGE
    default              service/kubernetes                  ClusterIP      10.152.183.1     <none>        443/TCP                                                                                                                                      21m
    kube-system          service/metrics-server              ClusterIP      10.152.183.130   <none>        443/TCP                                                                                                                                      106s
    kube-system          service/kubernetes-dashboard        ClusterIP      10.152.183.240   <none>        443/TCP                                                                                                                                      103s
    kube-system          service/dashboard-metrics-scraper   ClusterIP      10.152.183.23    <none>        8000/TCP                                                                                                                                     103s
    kube-system          service/kube-dns                    ClusterIP      10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP                                                                                                                       102s
    container-registry   service/registry                    NodePort       10.152.183.39    <none>        5000:32000/TCP                                                                                                                               91s
    istio-system         service/istio-galley                ClusterIP      10.152.183.126   <none>        443/TCP,15014/TCP,9901/TCP                                                                                                                   21s
    istio-system         service/istio-egressgateway         ClusterIP      10.152.183.168   <none>        80/TCP,443/TCP,15443/TCP                                                                                                                     21s
    istio-system         service/istio-ingressgateway        LoadBalancer   10.152.183.171   <pending>       15020:31399/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31712/TCP,15030:30545/TCP,15031:32574/TCP,15032:30073/TCP,15443:31063/TCP   21s
    istio-system         service/grafana                     ClusterIP      10.152.183.20    <none>        3000/TCP                                                                                                                                     21s
    istio-system         service/kiali                       ClusterIP      10.152.183.127   <none>        20001/TCP                                                                                                                                    21s
    istio-system         service/istio-policy                ClusterIP      10.152.183.60    <none>        9091/TCP,15004/TCP,15014/TCP                                                                                                                 21s
    istio-system         service/istio-telemetry             ClusterIP      10.152.183.51    <none>        9091/TCP,15004/TCP,15014/TCP,42422/TCP                                                                                                       21s
    istio-system         service/istio-pilot                 ClusterIP      10.152.183.81    <none>        15010/TCP,15011/TCP,8080/TCP,15014/TCP                                                                                                       21s
    istio-system         service/prometheus                  ClusterIP      10.152.183.219   <none>        9090/TCP                                                                                                                                     21s
    istio-system         service/istio-citadel               ClusterIP      10.152.183.80    <none>        8060/TCP,15014/TCP                                                                                                                           21s
    istio-system         service/istio-sidecar-injector      ClusterIP      10.152.183.32    <none>        443/TCP,15014/TCP                                                                                                                            21s
    istio-system         service/jaeger-query                ClusterIP      10.152.183.101   <none>        16686/TCP                                                                                                                                    21s
    istio-system         service/jaeger-collector            ClusterIP      10.152.183.165   <none>        14267/TCP,14268/TCP,14250/TCP                                                                                                                21s
    istio-system         service/jaeger-collector-headless   ClusterIP      None             <none>        14250/TCP                                                                                                                                    21s
    istio-system         service/jaeger-agent                ClusterIP      None             <none>        5775/UDP,6831/UDP,6832/UDP                                                                                                                   21s
    istio-system         service/zipkin                      ClusterIP      10.152.183.40    <none>        9411/TCP                                                                                                                                     21s
    istio-system         service/tracing                     ClusterIP      10.152.183.104   <none>        80/TCP                                                                                                                                       21s

    NAMESPACE     NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
    kube-system   daemonset.apps/calico-node   1         1         1       1            1           kubernetes.io/os=linux   21m

    NAMESPACE            NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
    kube-system          deployment.apps/calico-kube-controllers     1/1     1            1           21m
    kube-system          deployment.apps/metrics-server              1/1     1            1           107s
    kube-system          deployment.apps/kubernetes-dashboard        0/1     1            0           103s
    container-registry   deployment.apps/registry                    0/1     1            0           91s
    istio-system         deployment.apps/istio-galley                0/1     1            0           21s
    istio-system         deployment.apps/istio-egressgateway         0/1     1            0           21s
    istio-system         deployment.apps/istio-ingressgateway        0/1     1            0           21s
    istio-system         deployment.apps/grafana                     0/1     1            0           21s
    istio-system         deployment.apps/kiali                       0/1     1            0           21s
    istio-system         deployment.apps/istio-policy                0/1     1            0           21s
    istio-system         deployment.apps/istio-telemetry             0/1     1            0           21s
    istio-system         deployment.apps/istio-pilot                 0/1     1            0           21s
    istio-system         deployment.apps/prometheus                  0/1     1            0           21s
    istio-system         deployment.apps/istio-citadel               0/1     1            0           21s
    istio-system         deployment.apps/istio-sidecar-injector      0/1     1            0           21s
    istio-system         deployment.apps/istio-tracing               0/1     1            0           21s
    kube-system          deployment.apps/hostpath-provisioner        1/1     1            1           91s
    kube-system          deployment.apps/coredns                     1/1     1            1           102s
    kube-system          deployment.apps/dashboard-metrics-scraper   1/1     1            1           103s

    NAMESPACE            NAME                                                   DESIRED   CURRENT   READY   AGE
    kube-system          replicaset.apps/calico-kube-controllers-f7868dd95      1         1         1       21m
    kube-system          replicaset.apps/metrics-server-8bbfb4bdb               1         1         1       106s
    kube-system          replicaset.apps/kubernetes-dashboard-85fd7f45cb        1         1         0       25s
    container-registry   replicaset.apps/registry-9b57d9df8                     1         1         0       25s
    istio-system         replicaset.apps/istio-galley-6fb8c7b586                1         1         0       21s
    istio-system         replicaset.apps/istio-egressgateway-674898c6           1         1         0       21s
    istio-system         replicaset.apps/istio-ingressgateway-5ff49854cc        1         1         0       21s
    istio-system         replicaset.apps/grafana-74488d57b4                     1         1         0       21s
    istio-system         replicaset.apps/kiali-75b58b6fd8                       1         1         0       21s
    istio-system         replicaset.apps/istio-policy-56698c6987                1         1         0       21s
    istio-system         replicaset.apps/istio-telemetry-6f4556487d             1         1         0       21s
    istio-system         replicaset.apps/istio-pilot-6976cdf765                 1         1         0       20s
    istio-system         replicaset.apps/prometheus-95dd89f5b                   1         1         0       20s
    istio-system         replicaset.apps/istio-citadel-67658cf6c                1         1         0       20s
    istio-system         replicaset.apps/istio-sidecar-injector-69f7fcc574      1         1         0       20s
    istio-system         replicaset.apps/istio-tracing-c69cb5cf5                1         1         0       20s
    kube-system          replicaset.apps/hostpath-provisioner-5c65fbdb4f        1         1         1       25s
    kube-system          replicaset.apps/coredns-7f9c69c78c                     1         1         1       25s
    kube-system          replicaset.apps/dashboard-metrics-scraper-78d7698477   1         1         1       25s

    NAMESPACE      NAME                                          COMPLETIONS   DURATION   AGE
    istio-system   job.batch/istio-grafana-post-install-1.5.1    0/1           22s        22s
    istio-system   job.batch/istio-security-post-install-1.5.1   0/1           22s        22s

  ```
* If you mainly use MicroK8s you can make our kubectl the default one on your command-line with alias mkctl="microk8s kubectl". Since it is a standard upstream kubectl, you can also drive other Kubernetes clusters with it by pointing to the respective kubeconfig file via the --kubeconfig argument.
 
 * __Access the Kubernetes dashboard__

  ```
   microk8s dashboard-proxy

  ``` 
  ```
    ┌─[orbite]@[Navita]:~/MicroK8s
    └──> $ microk8s dashboard-proxy
    Checking if Dashboard is running.
    Dashboard will be available at https://127.0.0.1:10443
    Use the following token to login:

  ```
  ┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   36m
┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl get nodes
NAME     STATUS   ROLES    AGE   VERSION
navita   Ready    <none>   36m   v1.21.4-3+e5758f73ed2a04
┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl get pods
No resources found in default namespace.
