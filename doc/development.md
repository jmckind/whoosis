### Development

Start a container locally to run the application in development mode.

```
docker run --rm -it -v $(pwd):/opt/whoosis -p 8000:8000 -w /opt/whoosis python:3 /bin/bash
```

Once the container is running, start the development server.

```
python manage.py runserver 0.0.0.0:8000
```
