FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs npm

RUN apt-get install -y \
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb

WORKDIR /app

COPY Gemfile* /app/
RUN bundle install

COPY package.json package-lock.json /app/
RUN npm install

COPY . /app

EXPOSE 4568

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
