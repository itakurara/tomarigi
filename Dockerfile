FROM ruby:2.5.1
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs postgresql-client
RUN mkdir /tomarigi
ARG APP_ROOT=/tomarigi
WORKDIR $APP_ROOT
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install --path $APP_ROOT/vendor/bundle
COPY . $APP_ROOT
