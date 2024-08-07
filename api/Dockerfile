FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

WORKDIR /app

COPY Gemfile* /app/
RUN bundle install

COPY . /app

CMD ["ruby", "app.rb"]
