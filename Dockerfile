FROM python:3.5-alpine

RUN apk add --no-cache g++
RUN apk add --update tini
ENV TINI_VERSION v0.6.0

RUN pip install Jupyter

ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
