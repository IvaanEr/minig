-- Creación de las DBs
CREATE DATABASE "minig_dev";
CREATE DATABASE "minig_test";

create user minigadmin with encrypted password 'minigadmin';
ALTER USER minigadmin CREATEDB;
ALTER USER minigadmin SUPERUSER;

grant all privileges on database minig_dev to minigadmin;
grant all privileges on database minig_test to minigadmin;
