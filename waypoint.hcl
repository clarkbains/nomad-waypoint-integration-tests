project = "example-nodejs"
  runner {
    enabled = true

    data_source "git" {
      url  = "https://github.com/hashicorp/waypoint-examples.git"
      path = "docker/nodejs"
    }
  }
app "waypoint-cd-test" {

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "waypoint-cd-test"
        tag   = "1"
        local = true
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
