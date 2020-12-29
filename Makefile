init:
	pip install -U --force-reinstall .

run_tests:
	python -m unittest discover -f

flake:
	python -m flake8

mypy:
	mypy .

.PHONY:build
build:
	rm -rf dist/ && python setup.py sdist bdist_wheel

.PHONY:check
check:
	twine check dist/*


test: run_tests flake mypy