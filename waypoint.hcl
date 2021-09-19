project = "waypoint-firstrun"

variable "git-email" {
  type = string
  default = "example@example.com"  
}

variable "git-user" {
  type = string
  default = "example"  
}

variable "git-pat" {
  type = string
  default = "ghp_xxxx"  
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
       #disable_entrypoint = true

     }
    registry {
      use "docker" {
        image = "ghcr.io/${var.git-user}/nomad-waypoint-integration-tests"
        tag   = "latest"
      #  local = true
        encoded_auth = base64encode(jsonencode({email:var.git-email, username:var.git-user, password:var.git-pat}))
      }
    }
  }

  deploy {
    use "nomad-jobspec" {
      jobspec = templatefile("${path.app}/app.nomad.tpl")
    }
  }
}

