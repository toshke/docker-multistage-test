# Build stage 0
# install build tools and compile source code to binary

FROM alpine:latest as build

# Install build tools
RUN apk add --update alpine-sdk

# Add and compile source to binary
ADD /src src
WORKDIR /src
RUN mkdir out && gcc main.c -o out/helloworld

# Build stage 1
# Copy binary from stage 0 and set it as entry point
FROM alpine:latest

COPY --from=build /src/out/helloworld /bin/helloworld
ENTRYPOINT ["/bin/helloworld"]
