**Response Wait Github Actions Bash Script**

When deploying changes to virtual machines or containers (whether hosted in AWS, Azure or other) there are situations in which a deployment step may be complete 
within a pipeline, but the site that the changes are being deployed to is not ready. This is especially relevant with terraform changes being applied to an EC2 
instance or ECS task from a Github Actions pipeline, but more time needed for the application to startup before the deployment is complete. 

This bash script is a perfect way to allow a pause in your github actions pipeline for a site to be properly queried for a 200 ok response code before continuing 
the pipeline (without having to statically put a sleep step in the script). 

**URL**
The URL to poll. Default "http://example.com"

**TIMEOUT**
Timeout before giving up in seconds. Default "720" or 12 minutes

**INTERVAL**
Interval between polling in seconds. Default "5"

**Example usage**

name: Deploy

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Grant execute permissions to the script
        run: chmod +x ./http_response_query.sh

      - name: Run site availability check
        run: ./http_response_query.sh