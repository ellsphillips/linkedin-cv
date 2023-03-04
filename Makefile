POETRY_VERSION = 1.1.5

# Env stuff
.PHONY: get-poetry
get-poetry:
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 - --version $(POETRY_VERSION)

.PHONY: build-env
build-env:
	python3 -m venv .venv
	poetry run pip install --upgrade pip
	poetry run poetry install

# Tests
.PHONY: tests
tests:
	poetry run pytest --cov=linkedincv --cov-report=term-missing --cov-report=xml tests

# Passive linters
.PHONY: black
black:
	poetry run black linkedincv tests --check

.PHONY: flake8
flake8:
	poetry run flake8 linkedincv tests

.PHONY: isort
isort:
	poetry run isort linkedincv tests --profile=black --check

.PHONY: mypy
mypy:
	poetry run mypy linkedincv tests

.PHONY: pylint
pylint:
	poetry run pylint "linkedincv/"

# Aggresive linters
.PHONY: black!
black!:
	poetry run black linkedincv tests

.PHONY: isort!
isort!:
	poetry run isort linkedincv tests --profile=black
