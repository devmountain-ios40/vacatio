# Vacatio

Your mobile vacation planner.

_Collaborate with your friends and family to plan your next vacation._

# Development Environment Setup

In order to work on this project some tools need to first be installed on the developers Mac.

## Python Tooling

This project makes use of the Python powered [Grip](https://github.com/joeyespo/grip) tool for
editing and viewing GitHub flavor Markdown documents. If this is your first time setting up
this project on your machine then follow the instructions in 
[this document](./ops/env/dev/install-and-setup-python-tools.md) to setup a Python development
environment.

### pyevn

It's recommended to use pyenv to manage your Python version for this project.

Run the following command to instruct pyenv to switch to the version of Python tracked in the
[`.python-version`](./.python-version) file that lives in the root of this project:

```bash
$ eval "$(pyenv init -)"
```

> **Note:** this can be run from any folder in this project. **Additionally:** this command
> will need to be run every time you open a new terminal to use the Python tools tracked by
> this project.

### Poetry

Install Grip and its dependencies with [Poetry](https://python-poetry.org/), like so:

```bash
$ poetry install
```

### Enter the Python environment

**Note**: this will need to be done on every new shell.

```bash
$ poetry shell
```

### Editing and Live-Previewing Markdown Documents

Once installed, you can edit and live-preview Markdown documents by running the following
command:

```bash
$ grip README.md
```

_Then open your editor and make your changes._

## License

[MIT](./LICENSE)
