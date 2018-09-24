# build stage
FROM golang:1.11.0-alpine AS builder

ADD . /go/src/github.com/LinAnt/outyet
WORKDIR /go/src/github.com/LinAnt/outyet
RUN go install .

# final stage
FROM alpine:3.7

RUN apk update && apk --no-cache add ca-certificates
COPY --from=builder /usr/local/go/lib/time/zoneinfo.zip /usr/local/go/lib/time/zoneinfo.zip
COPY --from=builder /go/bin/outyet /usr/bin/outyet
ENTRYPOINT [ "/usr/bin/outyet" ]
EXPOSE 8080
