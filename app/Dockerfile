FROM python:3.9-slim

COPY . .

RUN apt update && apt -y install curl
RUN /usr/sbin/useradd -d /home/app-user -m -s /bin/bash app-user

ENV USER app-user
USER $USER
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
ENV POETRY_NO_INTERACTION 1
ENV HOME /home/$USER
ENV PATH=$PATH:$HOME/.poetry/bin
RUN poetry config virtualenvs.create false
RUN poetry install

ENV PYTHONUNBUFFERED 1

CMD exec poetry run python main.py
