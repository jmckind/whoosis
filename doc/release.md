### Release

To create a new release, increment the application version in `src/setup.py` as
needed and commit any changes to version control.

Run the target provided to create a new tag in the repository.

```
make tag
```

This will cause a new image to be built using a build trigger on
[Docker Cloud](https://cloud.docker.com/swarm/jmckind/repository/docker/jmckind/whoosis/general).
