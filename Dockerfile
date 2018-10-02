FROM debian:8

MAINTAINER Kamil Kwiek <kamil.kwiek@continuum.io>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN /bin/bash -c "/opt/conda/bin/conda update --all -y"    

RUN /bin/bash -c "/opt/conda/bin/conda install -c anaconda pymysql -y"

RUN /bin/bash -c "/opt/conda/bin/conda install -c conda-forge jupyterlab -y"

RUN /bin/bash -c "/opt/conda/bin/conda install -c conda-forge opencv -y"

RUN /bin/bash -c "/opt/conda/bin/conda config --add channels conda-forge"

RUN /bin/bash -c "/opt/conda/bin/conda install qgrid -y"

RUN /bin/bash -c "/opt/conda/bin/conda install -c bioconda/label/deprecated joblib -y"

RUN /bin/bash -c "/opt/conda/bin/conda install -c conda-forge pip -y"




RUN apt-get update && apt-get install build-essential -y

RUN /bin/bash -c "/opt/conda/bin/pip install fancyimpute"

#RUN apt-get update && apt-get install -y --no-install-recommends apt-utils


#set korea time
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#install vim editor
RUN apt-get update && apt-get install -y vim

#install cron
#RUN apt-get update && apt-get install -y cron




#RUN apt-get update && apt-get install -y cron
#COPY hello-cron /etc/cron.d/hello-cron
#RUN crontab /etc/cron.d/hello-cron



RUN mkdir -p /opt/notebooks
ADD . /opt/notebooks

WORKDIR /opt/notebooks

# Copy crontab file in the cron directory
#COPY hello-cron /etc/cron.d/hello-cron
 
# Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/hello-cron

#RUN crontab /etc/cron.d/hello-cron

#RUN service cron start 

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log
 
#RUN crontab /etc/cron.d/hello-cron


ENV PATH /opt/conda/bin:$PATH

RUN /bin/bash -c "git config --global user.email 'oe3216@gmail.com'"

RUN /bin/bash -c "git config --global user.name 'vincentkim'"


ENTRYPOINT [ "/usr/bin/tini", "--" ]

# Run the command on container startup
#CMD cron && tail -f /var/log/cron.logdoc

#CMD ["cron", "-f"]
CMD [ "bash", "bootstrap.sh" ]
