FROM fluent/fluentd:v1.9.2-1.0

# params
ENV SITE_CODE=TEST
ENV PROFILE=TEST
ENV ELASTIC_SEARCH_USER=
ENV ELASTIC_SEARCH_PWD=

# copy configuration
COPY --chown=fluent:fluent ["fluent.conf", "/fluentd/"]

# be root user for install block
USER root

# install plugins
RUN fluent-gem install \
        fluent-plugin-grok-parser \
        fluent-plugin-concat \
        fluent-plugin-elasticsearch

USER fluent

# conatiners entry point
ENTRYPOINT ["fluentd", "-c",  "./fluentd/fluent.conf"]
