project = "nomad-waypoint-integration-tests"
  runner {
    enabled = true
    data_source "git" {
      url  = "https://github.com/clarkbains/nomad-waypoint-integration-tests.git"
    }
  }

app "nomad-waypoint-integration-tests" {

  build {
    use "pack" {}
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
