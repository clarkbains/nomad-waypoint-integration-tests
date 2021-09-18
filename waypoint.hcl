project = "example-nodejs"

  variable "b64cred" {
    type = object({
      email = string
      username = string
      password = string
    })
    default = {email:"example@test.com", username:"example", password:"test"}  
  }
  runner {
    enabled = true
    data_source "git" {
      url  = "https://github.com/clarkbains/nomad-waypoint-integration-tests.git"
    }
  }

app "nomad-waypoint-integration-tests" {

  build {
    use "pack" {  }
    registry {

      use "docker" {
        image = "ghcr.io/clarkbains/nomad-waypoint-integration-tests"
        tag   = "latest"
        encoded_auth = base64encode(jsonencode(var.b64cred))
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
