# i2b2 PHI dataset for the NLP Sandbox

[![GitHub Release](https://img.shields.io/github/release/nlpsandbox/i2b2-phi-dataset.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/nlpsandbox/i2b2-phi-dataset/releases)
[![GitHub CI](https://img.shields.io/github/workflow/status/nlpsandbox/i2b2-phi-dataset/CI.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/nlpsandbox/i2b2-phi-dataset)
[![GitHub License](https://img.shields.io/github/license/nlpsandbox/i2b2-phi-dataset.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/nlpsandbox/i2b2-phi-dataset/blob/main/LICENSE)

Generation of the i2b2 PHI dataset for the NLP Sandbox

## Introduction

[NLPSandbox.io] is an open platform for benchmarking modular natural language
processing (NLP) tools on both public and private datasets. Academics, students,
and industry professionals are invited to browse the available tasks and
participate by developing and submitting an NLP Sandbox tool.

A series of tasks benchmarked in the NLP Sandbox are PHI annotation and
de-identification tasks. One of the datasets used to benchmark the performance
of NLP Sandbox tools submitted to solve these tasks is from the [2014 i2b2 NLP
De-identification Challenge]. This dataset do not include sensitive information
since the authors have replaced the PHIs with synthetic values that prevent the
re-identification of patients.

This repository provides a portable and reproducible development environment
with RStudio and Python generated from the template GitHub repository
[sagebionetworks/rstudio]. This environment provides a notebook (see
[Notebooks](#notebooks)) that takes as input the official training and
evaluation dataset files of the 2014 i2b2 NLP De-identification Challenge and
generates a new dataset using the [NLP Sandbox Schemas].

All packages:

- R (see [renv.lock]).
- Python (see [conda/i2b2-phi-dataset/environment.yml]).

### Requirements

- [Docker Engine] >=19.03.0
- Synapse.org user account

## Notebooks

The notebooks below are rendered to HTML and published to GitHub Pages by the
[CI/CD workflow of this repository].

Rmd Notebook | Description | HTML Notebook
-------- | ----------- | -------------
[generate-dataset.Rmd](notebooks/generate-dataset.Rmd)         | Generation of the i2b2 PHI dataset for the NLP Sandbox.                                | [![HTML notebook](https://img.shields.io/badge/latest-blue.svg?color=1283c3&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://nlpsandbox.github.io/rstudio/latest/notebooks/generate-dataset.html)

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

## Versioning

### GitHub tags

This repository uses [semantic versioning] to track the releases of this
project. This repository uses "non-moving" GitHub tags, that is, a tag will
always point to the same git commit once it has been created.

### GitHub Pages

The artifact published by this repository are HTML notebooks published to GitHub
Pages and the Docker image [docker.synapse.org/syn22277123/i2b2-phi-dataset].

The table below describes the GH Pages tags available.

| Tag name                        | Moving | Description
|---------------------------------|--------|------------
| `latest`                        | Yes    | Latest stable release.
| `edge`                          | Yes    | Lastest commit made to the default branch.
| `weekly`                        | Yes    | Weekly release from the default branch.
| `<major>`                       | Yes    | Latest stable major release of this project.
| `<major>.<minor>`               | Yes    | Latest stable minor release of this project.
| `<major>.<minor>.<patch>`       | Yes    | Latest stable patch release of this project.
| `<major>.<minor>.<patch>-<sha>` | No     | Same as above but with the reference to the git commit.

You should avoid using a moving tag like `latest` when deploying containers in
production, because this makes it hard to track which version of the image is
running and hard to roll back.

## License

[Apache License 2.0]

<!-- Links -->

[NLPSandbox.io]: https://nlpsandbox.io
[sagebionetworks/rstudio]: https://github.com/Sage-Bionetworks/rstudioenabling-and-disabling-version-updates
[semantic versioning]: https://semver.org/
[Apache License 2.0]: https://github.com/nlpsandbox/i2b2-phi-dataset/blob/main/LICENSE
[renv.lock]: renv.lock
[conda/i2b2-phi-dataset/environment.yml]: conda/i2b2-phi-dataset/environment.yml
[CI/CD workflow of this repository]: .github/workflows/ci.yml
[Docker Engine]: https://docs.docker.com/engine/install/
[docker.synapse.org/syn22277123/i2b2-phi-dataset]: https://www.synapse.org/#!Synapse:syn25813728
[2014 i2b2 NLP De-identification Challenge]: https://dx.doi.org/10.1016%2Fj.jbi.2015.06.007
[2014 i2b2 NLP De-identification Challenge Dataset]: https://portal.dbmi.hms.harvard.edu/projects/n2c2-nlp/
[NLP Sandbox Schemas]: https://github.com/nlpsandbox/nlpsandbox-schemas
