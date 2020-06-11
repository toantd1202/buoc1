FROM python:3.6

COPY Pipfile Pipfile.lock /

RUN apt-get update \
    && pip install pipenv \
    && pipenv install
ADD . /

ENTRYPOINT [ "pipenv", "run" ]

CMD [ "python", "./main.py" ]
