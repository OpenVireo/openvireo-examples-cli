# A config file template for `ov inject`. Each reference is replaced with its value.
database:
  host: db.internal
  user: {{ ov://Team Infra/Database/username }}
  password: {{ ov://Team Infra/Database/password }}
github:
  deploy_key: ov://Team%20Infra/GitHub%20deploy%20key/password
