FROM python:2

WORKDIR /usr/share/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt
RUN curl 'https://codeload.github.com/mxcoder/jsonpyes/tar.gz/1.3.2-alpha' --output ./f.tar.gz \
    && tar xzf ./f.tar.gz && mv ./jsonpyes-1.3.2-alpha ./jsonpyes && rm ./f.tar.gz

COPY _bulk.sh _bulk.sh
COPY _prepare.sh _prepare.sh
COPY run.sh run.sh

ENTRYPOINT [ "bash", "run.sh" ]
CMD [ "http://elastic:elastic@localhost:9200" , "/input"]
