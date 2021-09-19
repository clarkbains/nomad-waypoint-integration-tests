job "nomad-integration" {
  datacenters = ["cwdc-os-1"]
  group "nomad-waypoint-integration-tests" {
    network {
      port  "http"{
        to = -1
      }
    }
    service {
      name = "nomad-waypoint-integration-tests"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.nomad-waypoint.rule=Path(`/hw`)",
      ]


    }
    task "server" {
      driver = "docker"
      config {
        image = "${artifact.image}:${artifact.tag}"
        ports = ["http"]
      }
      env {
        #Inject details about the environment like what port is being used
        %{ for k,v in entrypoint.env ~}
        ${k} = "${v}"
        %{ endfor ~}
      }
    }
  }
}