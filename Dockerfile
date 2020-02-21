#
# Quantum Espresso : a program for electronic structure calculations
#
FROM ubuntu:18.04

MAINTAINER Mauro Palumbo <mauro.palumbo@unito.it>
#
# update and install some useful tools
#
RUN apt-get update --fix-missing && apt-get -y upgrade && \
    apt-get install -y nano wget bzip2 ca-certificates net-tools make curl git cpio build-essential rsync g++ ssh \
                       gfortran g++ libopenmpi-dev openmpi-bin make libblas-dev  liblapack-dev  \ 
                       evince gv gnuplot grace less vim patch unzip && \
    apt-get clean && apt autoremove

RUN  apt-get install --no-install-recommends --no-install-suggests texlive-latex-base -y
RUN  adduser mauro
RUN  echo "mauro:mauro" | chpasswd 
USER mauro 
WORKDIR /home/mauro/
RUN  wget https://github.com/QEF/q-e/archive/qe-6.5.tar.gz
RUN  tar xzf qe-6.5.tar.gz && mv q-e-qe-6.5 qe && cd qe && ./configure && make all && cd ../ && rm qe-6.5.tar.gz
RUN cd qe && wget https://people.sissa.it/~dalcorso/thermo_pw/thermo_pw.1.2.1.tar.gz
RUN cd qe && tar xzf thermo_pw.1.2.1.tar.gz && rm thermo_pw.1.2.1.tar.gz && cd thermo_pw && make join_qe && cd .. && make thermo_pw

#RUN RUN echo "export OMP_NUM_THREADS=1">> .bashrc



