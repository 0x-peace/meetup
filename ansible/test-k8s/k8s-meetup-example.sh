#!/bin/bash


ENVIRONMENT="test"

echo "Environment name  - $ENVIRONMENT"
echo "Kubespray version - $K8S_CORE247_PROD_KUBESPRAY_VERSION"

if [ -z ${K8S_CORE247_PROD_KUBESPRAY_VERSION} ]; then
   K8S_CORE247_PROD_KUBESPRAY_VERSION="v2.26.0"
fi

if [ ! -d "roles/kubespray-${K8S_CORE247_PROD_KUBESPRAY_VERSION}" ]; then
   echo "Download kubespray role"
   git clone https://github.com/kubernetes-sigs/kubespray.git -b ${K8S_CORE247_PROD_KUBESPRAY_VERSION} ./roles/kubespray
fi

if [ ! -d "env/$ENVIRONMENT" ]; then
   pip install --upgrade pip
   pip install -r ./roles/kubespray/requirements.txt
else
   source env/$ENVIRONMENT/bin/activate
   pip install --upgrade pip
   pip3 install -r ./roles/kubespray/requirements.txt
fi


