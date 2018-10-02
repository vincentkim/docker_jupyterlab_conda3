# docker_jupyterlab_conda3
This document is made for dockerized jupyterlab using ananconda3

sudo docker build -t jupyterlab_conda3:0.0 ./

sudo docker run -i -t -d -p 8080:8888 --name kto_notebook -v /app/dev/notebooks/kto:/opt/notebooks -e GRANT_SUDO=yes --user root jupyterlab_conda3:0.0 /bin/bash -c "/opt/conda/bin/jupyter lab --notebook-dir=/opt/notebooks --ip="*" --no-browser --allow-root"
