# TODO: WIP
FROM python:3.11-slim as base

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN apt-get update -y && apt-get install -y yq

ENV APP_HOME /code
WORKDIR $APP_HOME

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . $APP_HOME

RUN chmod +x archive_repos.sh

RUN ["/bin/bash", "/code/archive_repos.sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]