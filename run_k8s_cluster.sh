K8S_VERSION=v1.4.1
ARCH=amd64

run_k8s() {
  docker run -d \
    --name="k8s-kubelet" \
    --volume=/:/rootfs:ro \
    --volume=/sys:/sys:rw \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:`pwd`/var/lib/kubelet:rw \
    --volume=/var/run:`pwd`/var/run:rw \
    --volume=/var/run/docker.sock:/var/run/docker.sock:rw \
    --volume=/var/run/docker:/var/run/docker:rw \
    --net=host \
    --pid=host \
    --privileged \
    --restart=always \
    gcr.io/google_containers/hyperkube-${ARCH}:${K8S_VERSION} \
    /hyperkube kubelet \
    --containerized \
    --hostname-override=127.0.0.1 \
    --api-servers=http://localhost:8080 \
    --config=/etc/kubernetes/manifests \
    --cluster-dns=8.8.8.8 \
    --cluster-domain=cluster.local \
    --allow-privileged --v=2
}

cleanup_k8s() {
  echo "Stopping k8s"
  # First stop the kubelet (will otherwise restart other components.
  docker ps --format '{{ .Names }}' | grep -e '^k8s-kubelet' | xargs docker rm -f
  docker ps --format '{{ .Names }}' | grep -e '^k8s_' | xargs docker rm -f
}

kubelet_id=`run_k8s`

echo "Kubelet started, id: $kubelet_id"
./kubectl config set-cluster nanokube --server=http://localhost:8080 > /dev/null


trap cleanup_k8s EXIT

while true; do
  sleep 1
done

