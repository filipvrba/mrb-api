FROM thevlang/vlang:alpine-dev AS builder

RUN apk update && apk upgrade
RUN apk --no-cache add upx ruby
RUN gem install rake

WORKDIR /opt/mruby
RUN git clone https://github.com/mruby/mruby.git /opt/mruby && rake && \
    /opt/mruby/bin/mruby -v && mkdir /app && ln -s /opt/mruby/build/host/lib /app/lib

WORKDIR /app
COPY . .
RUN mkdir bin && /opt/vlang/v -prod -o bin/mrb_api app.v

FROM alpine AS runtime

RUN apk update && apk upgrade \
    && apk add --no-cache openssl

WORKDIR /app
COPY --from=builder /app/bin/ .

EXPOSE 8080
CMD [ "./mrb_api" ]
