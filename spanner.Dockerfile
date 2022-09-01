ARG BUILDER_IMAGE=golang:1.18.3-bullseye
ARG EMULATOR_IMAGE=gcr.io/cloud-spanner-emulator/emulator:1.4.3

#FROM --platform=$TARGETPLATFORM ${BUILDER_IMAGE} AS builder
FROM ${BUILDER_IMAGE} AS builder

WORKDIR /src
COPY go.mod go.sum ./
COPY cmd cmd
RUN CGO_ENABLED=0 go build -o /go/bin/spanner ./cmd/spanner
#RUN go build -o /go/bin/spanner ./cmd/spanner

#FROM --platform=$TARGETPLATFORM ${EMULATOR_IMAGE}
FROM ${EMULATOR_IMAGE}
COPY --from=builder /go/bin/spanner /
ENTRYPOINT ["/spanner"]
