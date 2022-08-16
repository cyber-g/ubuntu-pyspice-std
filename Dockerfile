FROM ubuntu:22.10
ENV DEBIAN_FRONTEND=noninteractive
RUN (apt-get update && apt-get upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

# Install convenient tools for working on the host
RUN apt-get install -y bash-completion vim

# Install minimal dependencies
RUN apt-get install -y git wget unzip \
                python3 python3-pip\
                ngspice libngspice0-dev
# This places the shared library to a standard place
# libngspice0-dev installs also libngspice0

RUN python3 -m pip install --upgrade pip

# Install PySpice : pip pulls all the python depencies
RUN pip3 install PySpice
# This places the PySpice modules to a standard place

# Retrieve latest version of PySpice to test an example
WORKDIR /root
RUN git clone https://github.com/FabriceSalvaire/PySpice.git

# Install an additional package for enabling graphics output with python on docker
RUN apt-get install -y python3-tk

# Print the PYTHONPATH variable
RUN python3 -c "import sys; print(sys.path)"

# Run PySpice example
ENTRYPOINT python3 PySpice/examples/transistor/transistor.py
