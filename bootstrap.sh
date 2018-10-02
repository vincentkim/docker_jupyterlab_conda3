#!/bin/bash

set -e
#ip address
/bin/bash -c "/opt/conda/bin/jupyter lab --notebook-dir=/opt/notebooks --ip='*' --no-browser --allow-root --NotebookApp.token=''"