ARG IMAGE=pytorch/pytorch
ARG TAG=2.4.1-cuda12.4-cudnn9-runtime

FROM ${IMAGE}:${TAG} AS base


RUN adduser --no-create-home --home /opt/aiops aiops
RUN mkdir -p /opt/aiops; chown aiops:aiops /opt/aiops

WORKDIR /opt/aiops
USER aiops

COPY requirements.txt /opt/aiops/requirements.txt
RUN pip install -r requirements.txt

COPY . /opt/aiops
ENV PATH=${PATH}:/opt/aiops/.local/bin

EXPOSE 8000

CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]