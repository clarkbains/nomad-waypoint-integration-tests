project = "example-nodejs"
  runner {
    enabled = true
    data_source "git" {
      url  = "https://github.com/clarkbains/nomad-waypoint-integration-tests.git"
    }
  }

app "waypoint-cd-test" {

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "ghcr.io/clarkbains/nomad-waypoint-integration-tests"
        tag   = "latest"
   #     encoded_auth = filebase64("/home/cbains/Development/vagrant/waypoint-test/waypoint-examples/nomad-waypoint-integration-tests/auth.json")
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
