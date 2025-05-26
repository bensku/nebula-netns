#!/bin/bash

CONTAINER_NAME="$1"

# Wait for the container to be up and retrieve its PID.
MAX_CONTAINER_WAIT=15  # Maximum seconds to wait for container startup
WAITED_CONTAINER=0
echo "Waiting for container '$CONTAINER_NAME' to be up..."
while true; do
  CONTAINER_PID=$(podman inspect --format '{{.State.Pid}}' "$CONTAINER_NAME" 2>/dev/null)
  if [ -n "$CONTAINER_PID" ] && [ "$CONTAINER_PID" -gt 0 ]; then
    break
  fi
  sleep 1
  WAITED_CONTAINER=$((WAITED_CONTAINER+1))
  if [ $WAITED_CONTAINER -ge $MAX_CONTAINER_WAIT ]; then
    echo "Error: Container '$CONTAINER_NAME' did not start within $MAX_CONTAINER_WAIT seconds."
    exit 1
  fi
done

echo "Container '$CONTAINER_NAME' is running with PID $CONTAINER_PID."

# Launch Nebula with TUN inside the container's network namespace
shift # Pass rest of arguments to Nebula
echo "Executing Nebula..."
exec $NEBULA_NETNS_BINARY -netns /proc/"$CONTAINER_PID"/ns/net $@