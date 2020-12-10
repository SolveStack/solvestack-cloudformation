# solvestack-cloudformation

## Deployment

```
./cf_deploy.sh <environment_name>
```

This script will generate an <environment_name>.yaml file and attempt to run it with the corresponding properties file. If you get a syntax/YAML error, please run the same cf_deploy.sh command one more time with no changes.

Current valid values for <environment_name> are dev, demo, stage, and prod.
## Note

There must be a <environment_name>-parameters.properties file in this directory for the cf_deploy.sh script to run properly.

All protected parameters must be stored in AWS Secrets Manager and dynamically referenced:

```
MyParameter={{resolve:secretsmanager:cloudformation/demo/secrets:SecretString:MyParameter}}
```

If you are uncertain if a parameter must be protected, ask! Or just add it as a key/value pair to the environment's secrets set.
