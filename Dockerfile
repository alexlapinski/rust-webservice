FROM rust:1.41.0 as build-env
WORKDIR /app
ADD . /app
RUN rustup default nightly
RUN rustup update && cargo update
RUN cargo build --release

FROM gcr.io/distroless/cc
COPY --from=build-env /app/target/release/rust-webservice /
CMD ["./rust-webservice"]