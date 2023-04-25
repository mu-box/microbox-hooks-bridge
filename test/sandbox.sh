#!/bin/bash
#
# Launch a container and console into it

test_dir="$(dirname $(readlink -f $BASH_SOURCE))"
payload_dir="$(readlink -f ${test_dir}/payloads)"
hookit_dir="$(readlink -f ${test_dir}/../src)"
util_dir="$(readlink -f ${test_dir}/util)"

# start a container for a sandbox
echo "Launching a sandbox container..."
docker run \
  --name=test-console \
  -d \
  --privileged \
  --net=microbox \
  --ip=192.168.0.55 \
  --volume=${hookit_dir}/:/opt/microbox/hooks \
  --volume=${payload_dir}/:/payloads \
  mubox/bridge

# hop into the sandbox
echo "Consoling into the sandbox..."
docker exec -it test-console bash

# remove the sandbox
echo "Destroying the sandbox container..."
docker stop test-console
docker rm test-console

echo "Bye."
