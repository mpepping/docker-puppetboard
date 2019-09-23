name: puppetboard
on:
  push:
    branches:
    - master

jobs:
  update_docker_hub_metadata:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Build
      run: |
        docker build --file Dockerfile --tag ${IMAGE} .
        #
        # build for Github Package Registry (GPR)
      env:
        IMAGE: mpepping/puppetboard
        DOCKER_USERNAME: mpepping
        DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
    - name: Logs / docker (inspect, history, version, info), uname
      run: |
        docker inspect ${IMAGE}
        docker history ${IMAGE} --no-trunc
        docker version
        docker info
        uname -a
        env
      env:
        IMAGE: mpepping/puppetboard
    - name: Publish
      run: |
        echo ${{ secrets.DOCKERHUB_PASSWORD }} | docker login --username ${DOCKER_USERNAME} --password ${{ secrets.DOCKER_PASSWORD }}
        docker push ${IMAGE}
        env
      env:
        IMAGE: mpepping/puppetboard
        DOCKER_USERNAME: mpepping
        DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
    - name: Update Docker hub metadata
      uses: docker://mpepping/docker-hub-metadata-github-action
      env:
        IMAGE: mpepping/testcases
        DOCKER_USERNAME: mpepping
        DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
