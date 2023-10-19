FROM python:3.11-slim

RUN apt-get update && apt-get install -y apt-transport-https

RUN pip install -U pip

# Install Poetry
RUN pip install poetry

WORKDIR /app

# Copy the current directory contents into the container at /app
COPY pyproject.toml /app
COPY poetry.lock /app
COPY README.md /app

# Install the dependencies with Poetry
RUN poetry config installer.max-workers 10
RUN poetry install --no-interaction --no-ansi -vvv

COPY . /app

ENTRYPOINT ["poetry", "run"]
