FROM ruby:2.7-alpine
LABEL maintainer="niclas.axelsson@teliacompany.com"
LABEL "com.github.actions.name"="Slate Documentation builder"
LABEL "com.github.actions.description"="Build repository md files using the slate framework"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

ENV CNAME=${CNAME:-""}
ENV DOC_BASE_FOLDER=${DOC_BASE_FOLDER:-"/usr/src/doc"}
ENV ZIP_BUILD=${ZIP_BUILD:-"true"}

WORKDIR /usr/src/app

COPY scripts/*.sh /usr/src/scripts/
COPY index.html.md /usr/src

RUN apk --no-cache --update add nodejs g++ make coreutils git zip && \
    git clone https://github.com/slatedocs/slate.git /usr/src/app && \
    bundle install && \
    chmod +x /usr/src/scripts/*.sh

VOLUME ["/usr/src/doc"]

ENTRYPOINT ["sh", "/usr/src/scripts/prepare_doc.sh" ]
CMD ["sh", "/usr/src/scripts/build.sh"]
