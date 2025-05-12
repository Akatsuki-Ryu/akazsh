#!/usr/bin/env bash

# Stop and remove all running containers
echo "Stopping all running Docker containers..."
running_containers=$(docker ps -q)
if [ -n "$running_containers" ]; then
  docker kill $running_containers
else
  echo "No running containers to stop."
fi

echo "Removing all containers..."
all_containers=$(docker ps -a -q)
if [ -n "$all_containers" ]; then
  docker rm $all_containers
else
  echo "No containers to remove."
fi

# Remove all images
echo "Removing all Docker images..."
all_images=$(docker images -q)
if [ -n "$all_images" ]; then
  docker rmi -f $all_images
else
  echo "No images to remove."
fi

# Remove all volumes
echo "Removing all Docker volumes..."
all_volumes=$(docker volume ls -q)
if [ -n "$all_volumes" ]; then
  docker volume rm $all_volumes
else
  echo "No volumes to remove."
fi

# Remove all networks
echo "Removing all Docker networks..."
all_networks=$(docker network ls -q -f type=custom)
if [ -n "$all_networks" ]; then
  docker network rm $all_networks
else
  echo "No custom networks to remove (default networks are protected)."
fi

# Prune unused containers
echo "Pruning all stopped containers..."
docker container prune -f

# Prune unused images and other Docker data
echo "Pruning unused images, volumes, and other data..."
docker system prune -af --volumes

# Optional: Reset Docker Desktop (macOS-specific instructions for advanced users)
if command -v docker >/dev/null 2>&1; then
  echo "Resetting Docker Desktop settings..."
  docker context use default 2>/dev/null || echo "No custom context found."
  docker system prune -af --volumes
fi

echo "Docker has been reset! If Docker Desktop is running, restart it to apply changes."