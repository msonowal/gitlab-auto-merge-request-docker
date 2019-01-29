# Open GitLab Merge Requests automatically


This script is meant to be used in GitLab CI to automatically open Merge Requests for feature branches, if there is none yet.

The script is provided as dedicated docker image to improve maintainability in the future.

It is based on the script and idea of [blog post by Riccardo Padovani](https://about.gitlab.com/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/).
Thanks for providing this.

## Instructions

### 1) `GITLAB_PRIVATE_TOKEN`
Set a secret variable in your GitLab project with your private token.
Name it `GITLAB_PRIVATE_TOKEN`.
This is necessary to raise the Merge Request on your behalf.
To create the personal token you can go to /profile/personal_access_tokens on your GitLab instance, and then you add to your pipeline following this guide.

### 2) `.gitlab-ci.yml`

Add the following to your `.gitlab-ci.yml` file:

```yaml
stages:
  - openMr

Open Merge Request:
  image: msonowal/gitlab-auto-merge-request-docker
  before_script: [] # We do not need any setup work, let's remove the global one (if any)
  variables:
    GIT_STRATEGY: none # We do not need a clone of the GIT repository to create a Merge Request
  stage: openMr
  only:
    - /^feature\/*/ # Means on which branch the automerge will be executed, here we are saying the branches starts with name feature, We have a very strict naming convention
  script:
    - merge-request.sh # The name of the script
```


set the variable `TARGET_BRANCH` on the branch where you want the merge request to be placed by default it will determine the default branch, otherwise it will use the target branch

## Docker images

The images are hosted on [Docker Hub](https://hub.docker.com/r/msonowal/gitlab-auto-merge-request-docker).

Two tags are noteworthy:
* `latest`: Latest release on `master` branch of this project


## Authors

* Script and idea: [Gitlab Blog post](https://about.gitlab.com/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/)
