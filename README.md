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
