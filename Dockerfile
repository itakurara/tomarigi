FROM ruby:2.5.1

ARG APP_ROOT=/tomarigi
ENV BUNDLE_PATH $APP_ROOT/vendor/bundle

RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs postgresql-client
RUN mkdir /tomarigi
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle config path $BUNDLE_PATH
RUN bundle install
COPY . $APP_ROOT
