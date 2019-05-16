ARG MASTER_KEY

FROM ruby:2.6.3

ARG MASTER_KEY

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client curl

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg

RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg && \
echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list &&  \
curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
apt-get update && apt-get install -y nodejs yarn

# Set an environment variable for the install location.
ENV RAILS_ROOT /var/www/app

# Make the directory and set as working.
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Set environment variables.
ENV RAILS_ENV production

# Adding project files.
COPY . .

ENV RAILS_MASTER_KEY ${MASTER_KEY}

# Install gems.
RUN bundle install --without development test --deployment --clean && \
bundle exec rake assets:precompile

EXPOSE 3000

# Start the application.
CMD ["bin/start"]