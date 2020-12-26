init:
	pip install -U --force-reinstall .

run_tests:
	python -m unittest discover -f

flake:
	python -m flake8

mypy:
	mypy .

build:
	rm -rf dist/ && python setup.py sdist bdist_wheel

check-build:
	twine check dist/*


test: run_tests flake mypy