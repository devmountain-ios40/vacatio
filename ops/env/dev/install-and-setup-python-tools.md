# Installation and Setup of Python Tools for a Mac Dev Environment

This project tracks its Python dependencies (used for development purposes) using
[Poetry](https://python-poetry.org/). As such, to make use of the Python tools, the following
steps are recommended in order to set up a Python virtual environment.

This document assumes you are using a Mac 11.5+ machine; though, it should be easy enough to
adapt the installation instructions for a different OS.

> **Note:** If you are not running Mac 11.5 or later, then you _may_ need to adapt the steps
> provided for your system.

## pyenv

It's recommended to use [pyenv](https://github.com/pyenv/pyenv) to manage Python versions.

Assuming [Homebrew](https://brew.sh/) is installed, you may run the following to install pyenv:

```bash
$ brew install pyenv
```

First, check which shell you are using by running the following command:

```bash
$ echo $SHELL
```

If you are using `bash` then run the following command to add `pyenv` to your terminal shell:

```bash
$ echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
```

Else if you are using `zsh`, then running the following command:

```bash
$ echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
```

Then source your `~/.bash_profile`, like so:

```bash
$ source ~/.bash_profile
```

Or, if you're using `zsh`, source your `~/.zprofile` like so:

```bash
$ source ~/.zprofile
```

Change into this project's root directory and install the version of Python tracked in
[`.python-version`](../.python-version) by running the following command:

```bash
$ cat .python-version | pyenv install
```

Now switch to that Python version, like so:

```bash
$ eval "$(pyenv init -)"
```

## Poetry

This project has some dependencies that are installed via Poetry. Poetry can be installed via
Homebrew:

```bash
$ brew install poetry
```

Poetry uses the [`pyproject.toml`](../pyproject.toml) and [`poetry.lock`](../poetry.lock)
files to track dependencies. Install the project dependencies, like so:

```bash
$ poetry install
```

### Two ways to use the Poetry environment

You can either spawn a new shell with the Python virtual environment instantiated, like so:

```bash
$ poetry shell
$ grip ops/dev/mac-dev-environment.md
```

Or you can run commands ad-hoc style by prepending them with `poetry run`, as follows:

```bash
$ poetry run grip ops/dev/mac-dev-environment.md
```

Now return to the original [README](./README.md) for more instructions.
