FROM postgres:11.6

ENV POSTGRES_PASSWORD=minigadmin
ENV POSTGRES_USER=minigadmin

EXPOSE 5432/tcp

COPY setup.sql /docker-entrypoint-initdb.d/setup.sql
