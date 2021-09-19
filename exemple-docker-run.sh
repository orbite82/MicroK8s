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

# Obtenha a versão da label de todos os pods com a label app=cassandra
kubectl get pods --selector=app=cassandra -o \
  jsonpath='{.items[*].metadata.labels.version}'

# Obter todos os nós workers (use um seletor para excluir resultados que possuem uma label
# nomeado 'node-role.kubernetes.io/master')
kubectl get node --selector='!node-role.kubernetes.io/master'
