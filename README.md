# MicroK8s
Estudos e Poc Micro k8s - https://microk8s.io/

* __Install MicroK8s on Linux:__ 

  * Link de referencia Installing snap on Linux Mint:
  *[Link](https://snapcraft.io/docs/installing-snap-on-linux-mint)

  ```
  ┌─[orbite]@[Navita]:~/MicroK8s
  └──> $ sudo rm /etc/apt/preferences.d/nosnap.pref

  ┌─[orbite]@[Navita]:~/MicroK8s
  └──> $ sudo apt update

  ┌─[orbite]@[Navita]:~/MicroK8s
  └──> $ sudo apt install snapd

  ```

  ```
  ┌─[orbite]@[Navita]:~/MicroK8s
  └──> $ sudo snap install microk8s --classic

  ```

* __Check the status while Kubernetes starts__  

  ```
   microk8s status --wait-ready

  ```
