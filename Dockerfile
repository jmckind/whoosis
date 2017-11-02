FROM python:3

LABEL maintainer="jmckind@gmail.com"

COPY etc/gunicorn.conf /etc/whoosis/
COPY etc/nginx.conf /etc/nginx/conf.d/default.conf

RUN wget -O /tmp/whoosis.tar.gz $(wget -qO - https://api.github.com/repos/jmckind/whoosis/releases/latest | grep -o 'browser_download_url.*' | cut -d'"' -f3)
RUN pip install /tmp/whoosis.tar.gz

ENTRYPOINT ["dumb-init", "--"]
CMD ["gunicorn", "-b", "0.0.0.0:4778", "whoosis.wsgi"]
EXPOSE 4778
