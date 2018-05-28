FROM golang:1.10.2 AS builder

WORKDIR /go/src/github.com/bitly/oauth2_proxy
COPY . .
RUN dep ensure -vendor-only -v
RUN CGO_ENABLED=0 GOOS=linux go build

FROM alpine:latest

RUN apk --no-cache add ca-certificates
COPY --from=builder /go/src/github.com/bitly/oauth2_proxy/oauth2_proxy /usr/local/bin/oauth2_proxy
ENTRYPOINT ["/usr/local/bin/oauth2_proxy"]
