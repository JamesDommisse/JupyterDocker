FROM python:3.5-slim

ARG user=gordon

ENV TINI_VERSION v0.6.0

RUN groupadd -r $user && useradd -r -g $user $user

RUN pip install Jupyter
COPY conf/jupyter_notebook_config.py /home/$user/.jupyter/jupyter_notebook_config.py
ENV PYTHONPATH $PYTHONPATHl:/usr/src

RUN pip install numpy
COPY conf/requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

ENTRYPOINT ["/sbin/tini", "--"]

USER $user
EXPOSE 8888
WORKDIR /home/$user/
CMD ["jupyter", "notebook"]
