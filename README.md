# Vault namespaces demo

This demo is used to demonstrate Vault namespaces, identities, identity groups and policies.

## Commands
vault server -dev -dev-root-token-id root -dev-listen-address 0.0.0.0:9201

export VAULT_TOKEN=root

terraform init

terraform apply

export VAULT_TOKEN=

vault login -namespace=education -method=userpass username="bob" password="training"

## Tests
```
**$ vault namespace create -namespace=education test1**
Key     Value
---     -----
id      x2hb3
path    education/test1/


**$ vault namespace create -namespace=education/test1 test2**
Error creating namespace: Error making API request.

Namespace: education/test1/
URL: PUT http://192.168.1.119:9201/v1/sys/namespaces/test2
Code: 403. Errors:

* 1 error occurred:
	* permission denied

**$ vault namespace create -namespace=education/training test3**
Key     Value
---     -----
id      g8wrN
path    education/training/test3/

**$ vault namespace create -namespace=education/training/test3 test4**
Error creating namespace: Error making API request.

Namespace: education/training/test3/
URL: PUT http://192.168.1.119:9201/v1/sys/namespaces/test4
Code: 403. Errors:

* 1 error occurred:
	* permission denied

**$ vault kv put -ns=education/training kv/kv blub=asd**
== Secret Path ==
kv/data/kv

======= Metadata =======
Key                Value
---                -----
created_time       2022-07-20T20:27:44.418075036Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            3


**$ vault kv get -ns=education/training kv/kv**
== Secret Path ==
kv/data/kv

======= Metadata =======
Key                Value
---                -----
created_time       2022-07-20T20:27:44.418075036Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            3

==== Data ====
Key     Value
---     -----
blub    asd

```
