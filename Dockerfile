FROM phusion/passenger-ruby22:0.9.18
MAINTAINER Abhaya S Rawal "abhayarawal@icloud.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx info
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf

# Prepare folders
RUN mkdir /home/app/webapp

# Run Bundle in a cache efficient way
WORKDIR /tmp  
ADD Gemfile /tmp/  
ADD Gemfile.lock /tmp/  
RUN bundle install

# Add the rails app
ADD . /home/app/webapp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  