FROM nimlang/nim as builder

RUN apt-get install musl-tools -y

# install deps
COPY backend.nimble ./
RUN nimble install -y --depsOnly

# build
COPY ./src ./src
RUN nim --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static c src/backend.nim

FROM alpine:3

COPY --from=builder src/backend ./

CMD ["/backend"]
