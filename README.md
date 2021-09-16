# MicroK8s
Estudos e Poc Micro k8s - https://microk8s.io/

* __Install MicroK8s on Linux:__ 

  * Link de referencia Installing snap on Linux Mint:

   *[Link](https://snapcraft.io/docs/installing-snap-on-linux-mint)

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
