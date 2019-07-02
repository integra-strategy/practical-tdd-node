FROM ruby:2.6.3

# Install system dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - ;\
    apt-get update -qq && apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - ;\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ;\
    apt-get update -qq && apt-get install -y yarn

# Setup project directory
RUN mkdir /myapp
WORKDIR /myapp

# Install Bundler 2
RUN gem install bundler

# Seeding base Rails gems to speed template execution
COPY Gemfile /myapp
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV YARN_CACHE_FOLDER=/myapp/tmp/cache/yarn

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
