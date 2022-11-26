FROM python:3.8-alpine
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
RUN apk add make go git
RUN git clone https://github.com/strangelove-ventures/strange.git
RUN cd strange && LEDGER_ENABLED=false make install
RUN cp /root/go/bin/stranged /usr/local/bin/
CMD [ "hypercorn", "-b" , "0.0.0.0:8000", "cosmos_rest_faucet:app"]
