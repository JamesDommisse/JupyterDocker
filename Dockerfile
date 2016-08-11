FROM python:3.5-alpine

ARG user=gordon

RUN apk add --no-cache g++
RUN apk add --update tini
ENV TINI_VERSION v0.6.0

RUN adduser -S $user

RUN pip install Jupyter
COPY conf/jupyter_notebook_config.py /home/$user/.jupyter/jupyter_notebook_config.py
ENV PYTHONPATH $PYTHONPATH:/usr/src

ENTRYPOINT ["/sbin/tini", "--"]

USER $user
EXPOSE 8888
WORKDIR /home/$user/
CMD ["jupyter", "notebook"]
