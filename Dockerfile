FROM ruby:3.0.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs
RUN npm install -g yarn

# Set working directory
WORKDIR /app

# Install specific Bundler version
RUN gem install bundler:2.5.4

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server (overridden by docker-compose.yml for tailwind)
CMD ["rails", "server", "-b", "0.0.0.0"]
