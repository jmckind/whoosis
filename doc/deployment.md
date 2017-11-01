# Deployment

The application can be deployed to run locally through docker directly or using
[Kubernetes](https://kubernetes.io/).

### Local

A target has been provided that will run the release image in a container
locally.

```
make run
```

###### Remove

A target has been provided that will remove the local container.

```
make runrm
```

### Kubernetes

A manifest has been provided in the `k8s` directory as a starting point for
deployment on Kubernetes.
