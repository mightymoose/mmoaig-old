FROM haskell:8.4.3

RUN apt-get update && \
  apt-get install -y libpq-dev

RUN mkdir -p /mmoaig-api
WORKDIR /mmoaig-api
COPY stack.yaml *.cabal ./

RUN export PATH=$(stack path --local-bin):$PATH
RUN stack build --dependencies-only

COPY . /mmoaig-api
RUN stack install

CMD ["mmoaig-api-exe"]
