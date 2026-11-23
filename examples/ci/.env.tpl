# An env file template for `ov run --env-file`. Values that are ov:// references are resolved, put in
# the command's environment, and masked in its output.
DATABASE_PASSWORD=ov://Team%20Infra/Database/password
DEPLOY_KEY=ov://Team%20Infra/GitHub%20deploy%20key/password
APP_ENV=production
