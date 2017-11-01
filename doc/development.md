# Development

Whoosis is a [python](https://www.python.org/)-based web application utilizing
the [Django](https://www.djangoproject.com/) framework.

### Requirements

 * [Make](https://www.gnu.org/software/make/)
 * [Docker](https://www.docker.com/community-edition)

Development for the application is done in a docker container using a local
volume to mount the source.

Make targets have been provided to perform various tasks.

### Initialization

The first step is to initialize the local development environment.

```
make init
```

This will create a docker container locally named `whoosis-dev` where the
application dependencies will be installed and database migrations performed.

### Preview

The next step is to preview the application by running it in the local
development container.

```
make preview
```

The application should be available in the browser at
[http://0.0.0.0:4778](http://0.0.0.0:4778) for verification.

### Shell

A target has been provided to run shell commands in the local development
container as needed.

```
make devsh
```

A shell in the local development container will be established. The working
directory will be the path where the source has been mounted, allowing all of
the normal `django` commands.

```
# python manage.py check
```

### Manage

A target has been provided as a shortcut to running the django
`python manage.py <task>` related commands.

```
make manage TASK=check
```

### Migrate

A target has been provided that will perform the database migrations for the
application.

```
make migrate
```

### Remove

A target has been provided that will remove the local development container.

```
make devrm
```

### Clean

A target has been provided that will remove any temporary artifacts generated
during development.

```
make clean
```

### Reset

A target has been provided that will perform a `clean` target, as well as
removing the local development database file.

```
make reset
```
