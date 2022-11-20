# infra-guide
FROM ruby:2.3 AS build

# We're creating files at the root, so we need to be root.
# USER root
ENV JEKYLL_ENV=production
ENV LC_ALL=C.UTF-8
ENV guide /opt/infra-guide

COPY Gemfile /tmp
WORKDIR /tmp
RUN bundle install

RUN mkdir $guide
WORKDIR $guide
ADD . $guide

RUN bundle exec jekyll build

FROM nginx:alpine AS release

COPY --from=build /opt/infra-guide/web /usr/share/nginx/html

