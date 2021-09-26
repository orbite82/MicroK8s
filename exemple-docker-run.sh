docker container run -p 9999:8888 --name hello cloudnatived/demo:hello

http://localhost:9999

ctrl+c para sair do container

docker ps -a
CONTAINER ID   IMAGE                     COMMAND       CREATED         STATUS                     PORTS     NAMES
1bd2b6c02b93   cloudnatived/demo:hello   "/bin/demo"   2 minutes ago   Exited (2) 7 seconds ago             hello

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image build -t myhello .

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker container run -p 9999:8888 myhello

http://localhost:9999/

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker login
#Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: orbite82
Password: 
WARNING! Your password will be stored unencrypted in /home/orbite/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image tag myhello orbite82/myhello

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image push orbite82/myhello

# Executando sua imagem
docker container  run -p 9999:8888 orbite82/myhello

http://localhost:9999/

=====================================================

# Executando, Build e Run V1

# Build
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image build -t myhello-v1 .

# Image
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image ls
REPOSITORY          TAG           IMAGE ID       CREATED          SIZE
myhello-v1          latest        3491f5e5fa45   30 seconds ago   6.07MB
<none>              <none>        f1f7199779c2   31 seconds ago   336MB
<none>              <none>        c4a4553854ef   16 minutes ago   336MB
orbite82/myhello    latest        866ff5d95025   16 minutes ago   6.07MB
myhello             latest        866ff5d95025   16 minutes ago   6.07MB

# Executando
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker container run -p 9999:8888 myhello-v1

# Teste Web
http://localhost:9999/


# Gerando Tag
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image tag myhello-v1 orbite82/myhello-v1

# Push
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker image push orbite82/myhello-v1

# Run
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ docker container  run -p 9999:8888 orbite82/myhello-v1

# Teste Web
http://localhost:9999/

# Exec k8s demo
┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ microk8s kubectl run demo --image=orbite82/myhello-v1 --port=9999 --labels app=demo
pod/demo create

┌─[orbite]@[Navita]:~/MicroK8s/demo/hello
└──> $ microk8s kubectl port-forward  pod/demo 9999:8888
Forwarding from 127.0.0.1:9999 -> 8888
Forwarding from [::1]:9999 -> 8888

# Teste Web
http://localhost:9999/

# Ver o pod
┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl get pods 
NAME   READY   STATUS    RESTARTS   AGE
demo   1/1     Running   0          5m3s

# Verificar este comando
┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl get pods --selector app=demo
NAME   READY   STATUS    RESTARTS   AGE
demo   1/1     Running   0          6m6s

# Deletando o pod
┌─[orbite]@[Navita]:~/MicroK8s
└──> $ microk8s kubectl delete pod demo
pod "demo" deleted

# Estudar comando
microk8s kubectl get pods --selector app=demo

#LINK --> https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/
# --> https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/

# Obtenha a versão da label de todos os pods com a label app=cassandra
kubectl get pods --selector=app=cassandra -o \
  jsonpath='{.items[*].metadata.labels.version}'

# Obter todos os nós workers (use um seletor para excluir resultados que possuem uma label
# nomeado 'node-role.kubernetes.io/master')
kubectl get node --selector='!node-role.kubernetes.io/master'

# Habilitando o DNS no MicroK8s

# Link: https://microk8s.io/docs/addon-dns

┌─[orbite]@[Navita]:~
└──> $ microk8s enable dns
Addon dns is already enabled.

microk8s kubectl -n kube-system edit configmap/coredns

# Desativar
microk8s disable dns

# Instalando Golang no Linux
https://golang.org/doc/install

root@orbite:~#

rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# Estado de um cluster

microk8s kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:16443
Metrics-server is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
CoreDNS is running at https://127.0.0.1:16443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

# Listar os nodes de um cluster

microk8s kubectl get nodes -o wide
NAME     STATUS   ROLES    AGE   VERSION                    INTERNAL-IP     EXTERNAL-IP   OS-IMAGE          KERNEL-VERSION      CONTAINER-RUNTIME
navita   Ready    <none>   9d    v1.21.5-3+e8b6c7dca47a08   192.168.1.104   <none>        Linux Mint 20.1   5.11.0-36-generic   containerd://1.4.4

# Listar os podes de um cluster

microk8s kubectl get pods -o wide
No resources found in default namespace.

microk8s kubectl get pods -n traefik -o wide
NAME                               READY   STATUS    RESTARTS   AGE     IP              NODE     NOMINATED NODE   READINESS GATES
traefik-ingress-controller-6sgbk   1/1     Running   0          8m26s   192.168.1.104   navita   <none>           <none>

# Pegar informações sobre os serviços de um cluster

microk8s kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   9d

# Detalhes da configuração de um serviço

microk8s kubectl get service kubernetes -o json
{
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "creationTimestamp": "2021-09-16T20:59:12Z",
        "labels": {
            "component": "apiserver",
            "provider": "kubernetes"
        },
        "name": "kubernetes",
        "namespace": "default",
        "resourceVersion": "99",
        "selfLink": "/api/v1/namespaces/default/services/kubernetes",
        "uid": "ee2ce8bc-9e0e-4b05-8b06-d2dba00277df"
    },
    "spec": {
        "clusterIP": "10.152.183.1",
        "clusterIPs": [
            "10.152.183.1"
        ],
        "ipFamilies": [
            "IPv4"
        ],
        "ipFamilyPolicy": "SingleStack",
        "ports": [
            {
                "name": "https",
                "port": 443,
                "protocol": "TCP",
                "targetPort": 16443
            }
        ],
        "sessionAffinity": "None",
        "type": "ClusterIP"
    },
    "status": {
        "loadBalancer": {}
    }
}

# Listar o IP de um Pod

microk8s kubectl describe pods traefik-ingress-controller -n traefik
Name:         traefik-ingress-controller-6sgbk
Namespace:    traefik
Priority:     0
Node:         navita/192.168.1.104
Start Time:   Sat, 25 Sep 2021 20:25:04 -0300
Labels:       controller-revision-hash=6d69bc6757
              k8s-app=traefik-ingress-lb
              name=traefik-ingress-lb
              pod-template-generation=1
Annotations:  <none>
Status:       Running
IP:           192.168.1.104
IPs:
  IP:           192.168.1.104
Controlled By:  DaemonSet/traefik-ingress-controller
Containers:
  traefik-ingress-lb:
    Container ID:  containerd://620833afc9563b2261aa9e4a62a14f051675fbb09ec34fe21c577ce4db1a5a0a
    Image:         traefik:2.3
    Image ID:      docker.io/library/traefik@sha256:0181e35c5af98f7f30fb391f91a6dbd281a90d7cf971e9909e26afd4ea923251
    Port:          8080/TCP
    Host Port:     8080/TCP
    Args:
      --providers.kubernetesingress=true
      --providers.kubernetesingress.ingressendpoint.ip=127.0.0.1
      --log=true
      --log.level=INFO
      --accesslog=true
      --accesslog.filepath=/dev/stdout
      --accesslog.format=json
      --entrypoints.web.address=:8080
      --entrypoints.websecure.address=:8443
    State:          Running
      Started:      Sat, 25 Sep 2021 20:25:04 -0300
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ghsdj (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-ghsdj:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 :NoSchedule op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  18m   default-scheduler  Successfully assigned traefik/traefik-ingress-controller-6sgbk to navita
  Normal  Pulled     18m   kubelet            Container image "traefik:2.3" already present on machine
  Normal  Created    18m   kubelet            Created container traefik-ingress-lb
  Normal  Started    18m   kubelet            Started container traefik-ingress-lb

# Ver NameSpace e Pods

microk8s kubectl get pods -A -o wide
NAMESPACE            NAME                                         READY   STATUS      RESTARTS   AGE   IP              NODE     NOMINATED NODE   READINESS GATES
istio-system         istio-grafana-post-install-1.5.1-5gcnx       0/1     Completed   0          9d    10.1.41.136     navita   <none>           <none>
istio-system         istio-security-post-install-1.5.1-x4zjm      0/1     Completed   0          9d    10.1.41.137     navita   <none>           <none>
kube-system          hostpath-provisioner-5c65fbdb4f-fv8ts        1/1     Running     16         9d    10.1.41.171     navita   <none>           <none>
kube-system          dashboard-metrics-scraper-78d7698477-tqxl4   1/1     Running     16         9d    10.1.41.168     navita   <none>           <none>
kube-system          coredns-7f9c69c78c-65kg7                     1/1     Running     16         9d    10.1.41.149     navita   <none>           <none>
kube-system          kubernetes-dashboard-85fd7f45cb-4sdvf        1/1     Running     16         9d    10.1.41.154     navita   <none>           <none>
kube-system          calico-kube-controllers-f7868dd95-57j8h      1/1     Running     17         9d    10.1.41.135     navita   <none>           <none>
istio-system         istio-sidecar-injector-69f7fcc574-n6s9d      1/1     Running     16         9d    10.1.41.169     navita   <none>           <none>
istio-system         istio-citadel-67658cf6c-dvd4k                1/1     Running     16         9d    10.1.41.146     navita   <none>           <none>
kube-system          metrics-server-8bbfb4bdb-5ftk8               1/1     Running     16         9d    10.1.41.170     navita   <none>           <none>
istio-system         prometheus-95dd89f5b-27h2k                   1/1     Running     16         9d    10.1.41.156     navita   <none>           <none>
istio-system         grafana-74488d57b4-vxrfm                     1/1     Running     16         9d    10.1.41.183     navita   <none>           <none>
istio-system         istio-galley-6fb8c7b586-dt4pf                1/1     Running     16         9d    10.1.41.182     navita   <none>           <none>
kube-system          calico-node-nxd72                            1/1     Running     17         9d    192.168.1.104   navita   <none>           <none>
container-registry   registry-9b57d9df8-q6b96                     1/1     Running     16         9d    10.1.41.145     navita   <none>           <none>
istio-system         kiali-75b58b6fd8-r8w8p                       1/1     Running     16         9d    10.1.41.133     navita   <none>           <none>
istio-system         istio-pilot-6976cdf765-8cjl6                 2/2     Running     33         9d    10.1.41.150     navita   <none>           <none>
istio-system         istio-telemetry-6f4556487d-m29zh             2/2     Running     68         9d    10.1.41.163     navita   <none>           <none>
istio-system         istio-tracing-c69cb5cf5-shsz2                1/1     Running     31         9d    10.1.41.140     navita   <none>           <none>
istio-system         istio-policy-56698c6987-bnsdv                2/2     Running     69         9d    10.1.41.153     navita   <none>           <none>
istio-system         istio-egressgateway-674898c6-rhj5z           1/1     Running     16         9d    10.1.41.147     navita   <none>           <none>
istio-system         istio-ingressgateway-5ff49854cc-sxjvl        1/1     Running     16         9d    10.1.41.175     navita   <none>           <none>
ingress              nginx-ingress-microk8s-controller-gpnf8      1/1     Running     0          36m   10.1.41.176     navita   <none>           <none>
traefik              traefik-ingress-controller-6sgbk             1/1     Running     0          29m   192.168.1.104   navita   <none>           <none>

# Ver Labels

microk8s kubectl get nodes --show-labels
NAME     STATUS   ROLES    AGE   VERSION                    LABELS
navita   Ready    <none>   9d    v1.21.5-3+e8b6c7dca47a08   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=navita,kubernetes.io/os=linux,microk8s.io/cluster=true

# Verificar o pod rodando

microk8s kubectl get pods -n traefik --output=wide
NAME                               READY   STATUS    RESTARTS   AGE   IP              NODE     NOMINATED NODE   READINESS GATES
traefik-ingress-controller-6sgbk   1/1     Running   0          37m   192.168.1.104   navita   <none>           <none>