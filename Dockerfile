FROM civisanalytics/datascience-python:3.2.0
MAINTAINER support@civisanalytics.com

# Version strings are set in datascience-python
# Set to blank strings here; they'd be misleading.
ENV VERSION= \
    VERSION_MAJOR= \
    VERSION_MINOR= \
    VERSION_MICRO= \
    TINI_VERSION=v0.16.1 \
    DEFAULT_KERNEL=python3 \
    CIVIS_JUPYTER_NOTEBOOK_VERSION=0.2.2

# Install Tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN pip install git+https://github.com/civisanalytics/civis-jupyter-notebook.git@574c6831fc9fe8ba568e99f0c3fd8680902c21f8 && \
    civis-jupyter-notebooks-install

EXPOSE 8888
WORKDIR /root/work

# Configure container startup
ENTRYPOINT ["/tini", "--"]
CMD ["civis-jupyter-notebooks-start"]
