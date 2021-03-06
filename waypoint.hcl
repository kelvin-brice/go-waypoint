# The name of your project. A project typically maps 1:1 to a VCS repository.
# This name must be unique for your Waypoint server. If you're running in
# local mode, this must be unique to your machine.
project = "my-project"

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

# An application to deploy.
app "web" {
    # Build specifies how an application should be deployed. In this case,
    # we'll build using a Dockerfile and keeping it in a local registry.
    build {
        use "docker" {}

        # Uncomment below to use a remote docker registry to push your built images.
        #
        registry {
          use "docker" {
            image = "us.gcr.io/sandbox-pcf1-19090210/way-to-go"
            tag   = "latest"
          }
        }
      }


    deploy {
      use "google-cloud-run" {
        project  = "sandbox-pcf1-19090210"
        location = "us-east1"

        port = 80

        capacity {
          memory                     = 128
          cpu_count                  = 1
          max_requests_per_container = 10
          request_timeout            = 300
        }

        auto_scaling {
          max = 2
        }
      }
    }

    release {
      use "google-cloud-run" {}
    }
}
