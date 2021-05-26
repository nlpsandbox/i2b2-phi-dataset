# RStudio

[![GitHub Release](https://img.shields.io/github/release/Sage-Bionetworks-Challenges/challenge-analysis.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/Sage-Bionetworks-Challenges/challenge-analysis/releases)
[![GitHub CI](https://img.shields.io/github/workflow/status/Sage-Bionetworks-Challenges/challenge-analysis/CI.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/Sage-Bionetworks-Challenges/challenge-analysis)
[![GitHub License](https://img.shields.io/github/license/Sage-Bionetworks-Challenges/challenge-analysis.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/Sage-Bionetworks-Challenges/challenge-analysis/blob/main/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/sagebionetworks/challenge-analysis.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/sagebionetworks/challenge-analysis)

A template project for challenge analysis in R and Python

## Introduction

The motivation for this project is to encourage the use of portable development
environments in research and engineering. The environment should be intuitive to
use so that anyone can deploy it and reproduce your results - even you six
months from now!

This project provides a portable development environment that enables you to run
the analysis included in this repository (see [Notebooks](#Notebooks)). The
Docker image [sagebionetworks/challenge-analysis] provided by this project and
that enables to run the notebooks seamlessly is based on the image
[sagebionetworks/rstudio].

For more information on how to use this repository to develop and publish your
own analysis, please read the section [How to use this
repository](#How-to-use-this-repository).

All packages:

- R (see [renv.lock]).
- Python (see [conda/sage-bionetworks/environment.yml]).

### Requirements

- [Docker Engine] >=19.03.0

## Notebooks

The notebooks below are rendered to HTML and published to GitHub Pages by the
[CI/CD workflow of this repository](.github/workflows/ci.yml).

Rmd Notebook | Description | HTML Notebook
-------- | ----------- | -------------
[compare-models-to-baseline.Rmd](notebooks/compare-models-to-baseline.Rmd)         | A simple description of a bootstrap analysis to determine the performance of participants relative to a comparator model.                                | [![HTML notebook](https://img.shields.io/badge/latest-blue.svg?color=1283c3&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://sage-bionetworks-challenges.github.io/rstudio/latest/notebooks/compare-models-to-baseline.html)
[determine-top-performers.Rmd](notebooks/determine-top-performers.Rmd) | A simple description of a bootstrap analysis to determine the top performers in a challenge.                  | [![HTML notebook](https://img.shields.io/badge/latest-blue.svg?color=1283c3&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://sage-bionetworks-challenges.github.io/rstudio/latest/notebooks/determine-top-performers.html)
[ensemble-analysis.Rmd](notebooks/ensemble-analysis.Rmd)     | A simple description of an ensemble analysis for a challenge. | [![HTML notebook](https://img.shields.io/badge/latest-blue.svg?color=1283c3&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://sage-bionetworks-challenges.github.io/rstudio/latest/notebooks/ensemble-analysis.html)
[survey-analysis.Rmd](notebooks/survey-analysis.Rmd)           | A simple description of a post-challenge survey analysis.                  | [![HTML notebook](https://img.shields.io/badge/latest-blue.svg?color=1283c3&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://sage-bionetworks-challenges.github.io/rstudio/latest/notebooks/survey-analysis.html)

> Important: Please make sure when you write your own notebooks that no
> sensitive information ends up being publicly available. Please check with the
> information security officer of your organization to confirm that the approach
> described here can be applied to your use case.

## Usage

1. Create and edit the configuration file. You can initially start RStudio using
   this configuration as-is.

       cp .env.example .env

2. Start RStudio. Add the option `-d` or `--detach` to run in the background.

       docker compose up

RStudio is now available at http://localhost. On the login page, enter the
default username (`rstudio`) and the password specified in `.env`.

To stop RStudio, enter `Ctrl+C` followed by `docker compose down`.  If running
in detached mode, you will only need to enter `docker compose down`.

## How to use this repository

You can use the image [sagebionetworks/challenge-analysis] as-is to start an
instance of RStudio and develop tools that interact with Sage Bionetworks
services, e.g. Synapse.

If you want to create a portable development environment, start by creating a
new GitHub repository from [this template]. You can then customize your
environment by specifying the R and Python packages to include with your image.
Finally, edit the the GitHub workflow [.github/workflows/ci.yml] to indicates
the Docker repository where the image should be pushed (see Section
[Versioning](#Versioning)).

Example projects that use this repository / image:

- TBA

## Manage R and Python dependencies

### R

In RStudio, use the following options to add and update libraries:

- `Tools` > `Install Packages...`
- `Tools` > `Check for Package Updates...`

Run the command `renv::snapshot()` to update the file `renv.lock`, which is used
in `Dockerfile` to install the required R libraries.

### Python

See the content of the folder `conda` for an example of how to define a conda
environment. The packages to add to this environment must be added to the file
`requirements.txt`. The creation of one or more Conda environments can be
specified in `Dockerfile`.

## Setting Synapse credentials

Set the environment variables `SYNAPSE_TOKEN` to the value of one of your
Synapse Personal Access Tokens. If this variable is set, it will be used to
create the configuration file `~/.synapseConfig` when the container starts.

## Using Conda

This Docker image comes with [Miniconda] installed (see below) and an example
Conda environment named `challenge-analysis`. This environment includes packages
used to interact with the collaborative platform [Synapse] developed by [Sage
Bionetworks].

### From the terminal

Attach to the RStudio container (here assuming that `challenge-analysis` is the
name of the container). For better safety, it is recommended to work as a
non-root user. You can then list the environments available, activate an
existing environment or create a new one.

```console
$ docker exec -it challenge-analysis bash
container # su yourusername
container $ conda env list
container $ conda activate challenge-analysis
```

### From RStudio

The R code below lists the environment available before activating the existing
environment named `challenge-analysis`.

```console
> library(reticulate)
> conda_list()
    name                              python
1 miniconda           /opt/miniconda/bin/python
2      challenge-analysis /opt/miniconda/envs/challenge-analysis/bin/python
> use_condaenv("challenge-analysis", required = TRUE)
```

## Setting user / group identifiers

When using Docker volumes, permissions issues can arise between the host OS and
the container. You can avoid these issues by letting RStudio know the User ID
(UID) and Group ID (GID) it should use when creating and editting files so that
these IDs match yours, which you can get using the command `id`:

```console
$ id
uid=1000(kelsey) gid=1000(kelsey) groups=1000(kelsey)
```

In this example, we would set `USERID=1000` and `GROUPID=1000`.

## Giving the user root permissions

Set the environment variable `ROOT=TRUE` (default is `FALSE`).

## Accessing logs

```console
docker logs --follow challenge-analysis
```

## Generating an HTML notebook

This Docker image provides the command `render` that generates an HTML or PDF
notebook from an R notebook (*.Rmd*). Run the command below from the host to
mount the directory `$(pwd)/notebooks` where the R notebook is and generate the
HTML notebook that will be saved to the same directory with the extension
`.nb.html`.

```console
docker run --rm \
    --env-file .env \
    -v $(pwd)/notebooks:/notebooks \
    sagebionetworks/challenge-analysis:latest \
    render /notebooks/*.Rmd
```

## Versioning

### GitHub tags

This repository uses [semantic versioning] to track the releases of this
project. This repository uses "non-moving" GitHub tags, that is, a tag will
always point to the same git commit once it has been created.

### Docker tags

The artifact published by this repository is the Docker image
[sagebionetworks/challenge-analysis]. The versions of the image are aligned with
the versions of R/RStudio, not the GitHub tags of this repository.

The table below describes the image tags available.

| Tag name                        | Moving | Description
|---------------------------------|--------|------------
| `latest`                        | Yes    | Latest stable release.
| `edge`                          | Yes    | Lastest commit made to the default branch.
| `weekly`                        | Yes    | Weekly release from the default branch.
| `<major>`                       | Yes    | Latest stable major release of this analysis.
| `<major>.<minor>`               | Yes    | Latest stable minor release of this analysis.
| `<major>.<minor>.<patch>`       | Yes    | Latest stable patch release of this analysis.
| `<major>.<minor>.<patch>-<sha>` | No     | Same as above but with the reference to the git commit.

You should avoid using a moving tag like `latest` when deploying containers in
production, because this makes it hard to track which version of the image is
running and hard to roll back.

<!-- ## Contributing

Thinking about contributing to this project? Get started by reading our
[Contributor Guide](CONTRIBUTING.md). -->

## License

[Apache License 2.0]

<!-- Links -->

[sagebionetworks/rstudio]: https://hub.docker.com/repository/docker/sagebionetworks/challenge-analysis
[Miniconda]: https://docs.conda.io/en/latest/miniconda.html
[synapse]: https://www.synapse.org/
[Synapse Python client]: https://pypi.org/project/synapseclient/
[GitHub Dependabot]: https://docs.github.com/en/free-pro-team@latest/github/administering-a-repository/enabling-and-disabling-version-updates
[semantic versioning]: https://semver.org/
[sagebionetworks/rstudio]: https://hub.docker.com/r/rocker/rstudio
[Apache License 2.0]: https://github.com/Sage-Bionetworks-Challenges/challenge-analysis/blob/main/LICENSE
[Sage Bionetworks]: https://sagebionetworks.org
[reticulate]: https://rstudio.github.io/reticulate
[sagebionetworks/challenge-analysis]: https://hub.docker.com/repository/docker/sagebionetworks/rstudio
[sagethemes]: https://github.com/Sage-Bionetworks/sagethemes
[challengeutils]: https://github.com/Sage-Bionetworks/challengeutils
[synapseclient]: https://github.com/Sage-Bionetworks/synapsePythonClient
[renv.lock]: renv.lock
[Dockerfile]: Dockerfile
[conda/sage-bionetworks/environment.yml]: conda/sage-bionetworks/environment.yml
[this template]: https://github.com/nlpsandbox/nlpsandbox.io/generate
[.github/workflows/ci.yml]: .github/workflows/ci.yml
[Sage-Bionetworks-Challenges/challenge-analysis]: https://github.com/Sage-Bionetworks-Challenges/challenge-analysis
[Sage-Bionetworks-Challenges/challenge-analysis]: https://github.com/Sage-Bionetworks-Challenges/challenge-analysis
[Docker Engine]: https://docs.docker.com/engine/install/
[Docker Compose]: https://docs.docker.com/compose/install/
