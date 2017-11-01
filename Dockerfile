FROM python:3

COPY src/dist/*.gz /tmp/
RUN pip install /tmp/whoosis-*.tar.gz

ENTRYPOINT ["dumb-init", "--"]
CMD ["gunicorn", "-b", "0.0.0.0:4778", "whoosis.wsgi"]
EXPOSE 4778
