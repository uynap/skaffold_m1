ARG BUILDER_IMAGE=golang:1.17.2-buster
ARG EMULATOR_IMAGE=gcr.io/cloud-spanner-emulator/emulator:1.3.0

FROM --platform=$TARGETPLATFORM ${BUILDER_IMAGE} AS builder

WORKDIR /src
COPY go.mod go.sum ./
COPY cmd cmd
RUN go build -o /go/bin/spanner ./cmd/spanner

FROM --platform=$TARGETPLATFORM ${EMULATOR_IMAGE}
COPY --from=builder /go/bin/spanner /
ENTRYPOINT ["/spanner"]
