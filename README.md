# Cloud Foundry Resource (SSO)

An output only resource (at the moment) that will deploy an application to a
Cloud Foundry deployment.

## Source Configuration

Note: you must provide either `username` and `password` or `client_id` and `client_secret`.

* `api`: *Required.* The address of the Cloud Controller in the Cloud Foundry
  deployment.
* `authorized_grant_type`: *Required.* The authorized_grant_type used to authenticate. (client_credentials)
* `client_id`: *Required.* The password used to authenticate.
* `client_secret`: *Required.* The client id used to authenticate.
* `credentials_endpoint`: *Required.* The client secret used to authenticate.
* `token_url`: *Required.* The client secret used to authenticate.
* `organization`: *Required.* The organization to push the application to.
* `space`: *Required.* The space to push the application to.

## Behaviour

### `out`: Deploy an application to a Cloud Foundry

Pushes an application to the Cloud Foundry detailed in the source
configuration. A [manifest][cf-manifests] that describes the application must
be specified.

[cf-manifests]: http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html

#### Parameters

* `manifest`: *Required.* Path to a application manifest file.
* `path`: *Optional.* Path to the application to push. If this isn't set then
  it will be read from the manifest instead.
* `environment_variables`: *Optional.* It is not necessary to set the variables in [manifest][cf-manifests] if this parameter is set.
* `vars`: *Optional.* Map of variables to pass to manifest
* `vars_files`: *Optional.* List of variables files to pass to manifest
* `no_start`: *Optional.* Deploys the app but does not start it. This parameter is ignored when `current_app_name` is specified.
* `debug`: *Optional.* TO enable debug output.

## Pipeline example

```yaml
---
jobs:
- name: job-deploy-app
  public: true
  serial: true
  plan:
  - get: resource-web-app
  - task: build
    file: resource-web-app/build.yml
  - put: resource-deploy-web-app
    params:
      manifest: build-output/manifest.yml
      environment_variables:
        key: value
        key2: value2

resource_types:
- name: cf-resource-sso
  type: docker-image
  source:
    repository: ctlange/cf-resource-sso

resources:
- name: deploy-cf
  type: cf-resource-sso
  source:
    api: https://....
    organization: org
    space: space
    authorized_grant_type: "client_credentials"
    client_id: ...
    client_secret: ...
    credentials_endpoint: "https://...."
    token_url: "https://...."
```

## Development

### Contributing

Please make all pull requests to the `master` branch and ensure tests pass
locally.
