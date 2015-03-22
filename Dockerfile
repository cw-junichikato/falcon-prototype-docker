FROM ubuntu:14.04
MAINTAINER j5ik2o <j5ik2o@gmail.com>

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y \
        python-yaml python-jinja2 \
        python-httplib2 python-keyczar \
        python-paramiko python-setuptools \
        python-pkg-resources git python-pip

RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts

RUN mkdir /opt/ansible/
RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git submodule update --init
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library

ADD ansible .
RUN ansible-playbook playbook.yml -c local


