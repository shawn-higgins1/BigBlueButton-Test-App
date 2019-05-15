FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client curl

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && apt-get install -y nodejs yarn

# Set an environment variable for the install location.
ENV RAILS_ROOT /var/www/app

# Make the directory and set as working.
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Set environment variables.
ENV RAILS_ENV production

# Adding project files.
COPY . .

# Install gems.
RUN bundle install --without development test --deployment --clean

# Precompile assets.
RUN bundle exec rake assets:clean
RUN bundle exec rake assets:precompile

EXPOSE 3000

# Start the application.
CMD ["bin/start"]