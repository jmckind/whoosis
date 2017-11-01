FROM python:3

LABEL maintainer="jmckind@gmail.com"

COPY etc/gunicorn.conf /etc/whoosis/
COPY src /opt/whoosis/src

WORKDIR /opt/whoosis/src

RUN pip install -e /opt/whoosis/src

ENTRYPOINT ["dumb-init", "--"]
CMD ["gunicorn", "--config", "/etc/whoosis/gunicorn.conf"]
EXPOSE 4778
