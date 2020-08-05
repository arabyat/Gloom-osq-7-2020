FROM ubuntu:latest
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip
RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN pip install virtualenv
RUN virtualenv --system-site-packages virtualenv
RUN /bin/bash -c "source /app/virtualenv/bin/activate"
RUN pip install -r requirements.txt
CMD python cli.py migrate
CMD uwsgi --http-socket 0.0.0.0:3000 uwsgi.ini
