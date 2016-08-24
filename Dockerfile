FROM python:3.5

# Add Tini
ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN pip install Jupyter
ENV PYTHONPATH /src

RUN pip install numpy
COPY conf/requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

ENTRYPOINT ["/tini", "--"]

COPY conf/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
EXPOSE 8888
CMD ["jupyter", "notebook", "notebooks"]
