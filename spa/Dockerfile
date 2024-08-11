FROM ruby:3.2.2

WORKDIR /app

COPY Gemfile* /app/
RUN bundle install

COPY . /app

EXPOSE 4568

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]