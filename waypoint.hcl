project = "example-nodejs"

variable "ghcr-creds" {
  type = object({
    email = string
    username = string
    password = string
  })
  default = {email:"example@gmail.com", username:"example", password:"ghp_xxxxxx"}  
}

runner {
  enabled = true
  data_source "git" {
    url  = "https://github.com/clarkbains/nomad-waypoint-integration-tests.git"
  }
}

app "nomad-waypoint-integration-tests" {

  build {
    use "pack" { 
       disable_entrypoint = true

     }
    registry {
      use "docker" {
        image = "ghcr.io/clarkbains/nomad-waypoint-integration-tests"
        tag   = "latest"
      #  local = true
        encoded_auth = base64encode(jsonencode(var.ghcr-creds))
      }
    }
  }


  deploy {
    use "nomad" {
      datacenter = "cwdc-os-1"
    }
  }

}
