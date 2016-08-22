FROM python:3.5-slim

ARG user=gordon

# Add Tini
ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN groupadd -r $user && useradd -r -g $user $user

RUN pip install Jupyter
COPY conf/jupyter_notebook_config.py /home/$user/.jupyter/jupyter_notebook_config.py
ENV PYTHONPATH $PYTHONPATHl:/usr/src

RUN pip install numpy
COPY conf/requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

ENTRYPOINT ["/tini", "--"]

USER $user
EXPOSE 8888
WORKDIR /home/$user/
CMD ["jupyter", "notebook"]
