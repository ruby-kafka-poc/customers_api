# README

Simple API to create customers
It act as a producer to confluent Kafka

## Run

You will need postgres running (you have the docker-compose)

```shell
git clone git@github.com:ruby-kafka-poc/customers_api.git
cd customers_api

open https://confluent.cloud
# Create a free account (no credit card needed free for 1 month), create a cluster,
# create a global API key
# go to cluster, cluster overview, cluster settings and get the bootstrap server

# WARNING DO NOT COMMIT THIS THINGS ANYWHERE!!!
echo "
BOOTSTRAP_SERVERS=AAAAAAAAAA:9092
SECURITY_PROTOCOL=sasl_ssl
SASL_MECHANISM=PLAIN
SASL_USERNAME=BBBBBB
SASL_PASSWORD=CCCCCCC
" >> .priv_env
export $(cat ./.private_env | sed 's/#.*//g' | xargs )


bundle install
bundle update
bundle exec rake db:create db:migrate db:seed
```

## Routes

```shell
GET    /organizations/:organization_id/invites
POST   /organizations/:organization_id/invites
DELETE /organizations/:organization_id/invites/:id
GET    /organizations
POST   /organizations
GET    /organizations/:id
PATCH  /organizations/:id
PUT    /organizations/:id
DELETE /organizations/:id

GET    /customers
POST   /customers
GET    /customers/:id
PATCH  /customers/:id
PUT    /customers/:id
DELETE /customers/:id
```

## Create some data

```shell
bundle exec rails server -b '0.0.0.0' -p 3001

curl --location -g --request POST 'http://localhost:3001/organizations' \
--header 'Content-Type: application/json' \
--data-raw '{ "organization": {"name": "Teravision" }}'

curl --location -g --request POST 'http://localhost:3001/organizations' \
--header 'Content-Type: application/json' \
--data-raw '{ "organization": {"name": "Versapay" }}'

curl --location -g --request POST 'http://localhost:3001/customers' \
--header 'Content-Type: application/json' \
--data-raw '{ "customer": {"name": "John", "last_name": "Do", "email": "jdo@gmail.com"}}'

curl --location -g --request POST 'http://localhost:3001/customers' \
--header 'Content-Type: application/json' \
--data-raw '{ "customer": {"name": "Matt", "last_name": "Berrueta", "email": "mberrueta@teravisiontech.com"}}'



```
