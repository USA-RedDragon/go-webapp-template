# Builder
FROM golang:alpine as builder

WORKDIR /go/src/github.com/USA-RedDragon/go-webapp-template

RUN apk add --no-cache nodejs npm make git bash zip

ADD . ./

RUN make build

# Runner
FROM alpine

WORKDIR /app

RUN adduser -S -D -H -h /app appuser

USER appuser

COPY --from=builder /go/src/github.com/USA-RedDragon/go-webapp-template/bin/go-webapp-template /app/

ENV LISTEN_ADDR="0.0.0.0"
ENV PORT=3000

CMD ["sh", "-c", "./go-webapp-template -listen $LISTEN_ADDR -port $PORT"]