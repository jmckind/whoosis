FROM python:3

COPY src /opt/whoosis/src
RUN pip install -e /opt/whoosis/src

ENTRYPOINT ["dumb-init", "--"]
CMD ["gunicorn", "-b", "0.0.0.0:4778", "whoosis.wsgi"]
EXPOSE 4778
