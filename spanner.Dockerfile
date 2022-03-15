ARG BUILDER_IMAGE=golang:1.17.7-buster
ARG EMULATOR_IMAGE=gcr.io/cloud-spanner-emulator/emulator:1.4.0

#FROM --platform=linux/arm64 ${BUILDER_IMAGE} AS builder
FROM --platform=$TARGETPLATFORM ${BUILDER_IMAGE} AS builder

WORKDIR /src
COPY go.mod go.sum ./
COPY cmd cmd
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /go/bin/spanner ./cmd/spanner

#FROM --platform=linux/arm64 ${EMULATOR_IMAGE}
FROM --platform=$TARGETPLATFORM ${EMULATOR_IMAGE}
COPY --from=builder /go/bin/spanner /
ENTRYPOINT ["/spanner"]
