FROM ruby:2.3.1-alpine

RUN apk update && apk add --no-cache git

RUN gem install trigger_build

ENTRYPOINT ["trigger_build"]
