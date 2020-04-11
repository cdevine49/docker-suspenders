FROM ruby:2.6.3-alpine3.10

# build_base contains tools for compiling gems from source
# postgresql-dev is used when installing the pg gem
# tzdata is used by Rails for timezone info
RUN apk update && apk add git nodejs yarn build-base postgresql-dev tzdata

ARG APP_USER=appuser
ARG APP_GROUP=appgroup
ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000

RUN addgroup -g $APP_GROUP_ID -S $APP_GROUP && \
	adduser -S -s /sbin/nologin -u $APP_USER_ID -G $APP_GROUP $APP_USER && \
	mkdir /app && \
	chown $APP_USER:$APP_GROUP /app

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /app
USER $APP_USER
COPY --chown=$APP_USER:$APP_GROUP Gemfile /app/Gemfile
COPY --chown=$APP_USER:$APP_GROUP Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
