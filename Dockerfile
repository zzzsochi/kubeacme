FROM neilpang/acme.sh
LABEL maintainer="Alexander Zelenyak <zzz.sochi@gmail.com>"

ARG KUBECTL_VERSION=v1.13.1

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD scripts/kubesetup /usr/local/bin/kubesetup
ADD scripts/kubeacme /usr/local/bin/kubeacme

RUN chmod +x /usr/local/bin/kubectl /usr/local/bin/kubesetup /usr/local/bin/kubeacme

ENTRYPOINT ["/usr/local/bin/kubeacme"]
