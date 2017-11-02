# Release

In addition to the development requirements, the following are required to
perform a release the application.

### Requirements

 * [github-release](https://github.com/aktau/github-release)

To create a new release, increment the application version in `src/setup.py` as
needed and commit any changes to version control.

### Personal Access Token

First, create a
[Personal Access Token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)
on GitHub to authenticate.

Once the token is setup, create a shell environment variable with the value of
the token.

```
export GITHUB_TOKEN=<PERSONAL_ACCESS_TOKEN>
```

### Distributable

Run the target provided to create a new distributable artifact for the
application.

```
make dist
```

### Tag

Run the target provided to create a new tag in the repository.

```
make tag
```

This will cause a new image to be built using a build trigger on
[Docker Cloud](https://cloud.docker.com/swarm/jmckind/repository/docker/jmckind/whoosis/general).

### Release

Run the target provided to upload the distributable artifact to the release in
GitHub.

```
make release
```
