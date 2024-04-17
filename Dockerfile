FROM eclipse-mosquitto AS build

RUN apk upgrade
RUN apk add rust cargo

ADD . /mosquitto-jwt-auth
WORKDIR /mosquitto-jwt-auth

RUN cargo build --release

FROM eclipse-mosquitto

RUN apk add libgcc
COPY --from=build /mosquitto-jwt-auth/target/release/libmosquitto_jwt_auth.so /usr/lib/