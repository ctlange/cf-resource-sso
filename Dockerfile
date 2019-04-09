FROM alpine:3.8

ADD assets/ /opt/resource/
RUN chmod -v +x /opt/resource/*

# Install uuidgen
RUN apk add --no-cache ca-certificates curl bash jq util-linux

# Install Cloud Foundry cli
ADD https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
  tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
  cf --version && \
  rm -f /tmp/cf-cli.tgz

# Install Concourse fly cli
RUN mkdir -p /usr/local/bin
ADD https://github.com/concourse/concourse/releases/download/v3.14.1/fly_linux_amd64 /usr/local/bin/fly
