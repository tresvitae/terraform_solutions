provider "aws" {
  profile = "terraform"
}

provider "docker" {
  # check what host cat /etc/docker/daemon.json 
  # host = "npipe:////.//pipe//docker_engine"
  # host = "unix:///var/run/dockerd" # /var/lib/docker
  host = "unix:///mnt/wsl/shared-docker/docker.sock"
}