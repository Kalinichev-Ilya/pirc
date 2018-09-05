FROM ruby:2.5.1

RUN mkdir /app
WORKDIR /app
ADD . /app
COPY ./Gemfile* /app/

RUN gem install bundler
RUN bundle install
RUN apt-get update && apt-get install -y curl

CMD ["puma", "-C", "./config/puma.rb"]
