FROM thevlang/vlang:ubuntu-build

# Create user
RUN useradd -ms /bin/bash user


# Update
RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get upgrade -y \
    && apt-get install --quiet -y openssl upx ruby \
    && apt-get autoclean && apt-get autoremove

# Install V
WORKDIR /opt/vlang
RUN mkdir -p /home/user/.local/bin
RUN git clone https://github.com/vlang/v.git /opt/vlang && make && v -version && \
    ln -s /opt/vlang/v /home/user/.local/bin/v

# Install Mruby
WORKDIR /opt/mruby
RUN git clone https://github.com/mruby/mruby.git /opt/mruby && rake && bin/mruby -v && \
    ln -s /opt/mruby/build/host/lib /home/user/lib

USER user

# Copy & build mrb-api
WORKDIR /home/user
COPY . .
RUN mkdir dist
RUN v -o dist/mrb_api app.v

# Open build app
EXPOSE 8000
ENTRYPOINT [ "dist/mrb_api"]
