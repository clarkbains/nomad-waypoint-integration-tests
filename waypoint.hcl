project = "example-nodejs"
  runner {
    enabled = true
    data_source "git" {
      url  = "https://github.com/clarkbains/nomad-waypoint-integration-tests.git"
    }
  }

app "nomad-waypoint-integration-tests" {

  build {
    use "pack" {}
    registry {
      variable "ghcr-creds" {
          type = object({
            email = number
            username = number
            pat = string
          })
#          sensitive = true
        }
      use "docker" {
        image = "ghcr.io/clarkbains/nomad-waypoint-integration-tests"
        tag   = "latest"
        encoded_auth = base64encode(var.ghcr-creds)
      }
    }
  }


  deploy {
    use "nomad" {
      // these options both default to the values shown, but are left here to
      // show they are configurable
      datacenter = "cwdc-os-1"
      namespace  = "default"
    }
  }

}
