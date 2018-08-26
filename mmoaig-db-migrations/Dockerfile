FROM ruby:2.5

RUN bundle config --global frozen 1

WORKDIR /user/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
CMD ["sh", "update-db.sh"]
