##############################################
# BASE IMAGE
##############################################

FROM python:3.11-slim as base
WORKDIR /home/patxi

ARG tmp_install_dir=/tmp/install

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential

RUN python -m pip install --upgrade pip

COPY requirements.txt ${tmp_install_dir}/requirements.txt
RUN pip install -r ${tmp_install_dir}/requirements.txt

# CLEANUP
RUN rm -r ${tmp_install_dir}

CMD ["/bin/bash"]

##############################################
# DEV
##############################################

FROM base as development

ARG tmp_install_dir=/tmp/install

RUN apt-get install -y git 
COPY dev_requirements.txt ${tmp_install_dir}/dev_requirements.txt
RUN pip install -r ${tmp_install_dir}/dev_requirements.txt

# CLEANUP
RUN rm -r ${tmp_install_dir}