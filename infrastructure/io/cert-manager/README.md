# cert-manager

## create credentials

```sh
mkdir .aws
echo YOUERREGION > .aws/config
cat << EOF > .aws/credentials
[default]
aws_access_key_id = YOURACCESSKEYID
aws_secret_access_key = YOURSECRETACCESSKEY
EOF
```

## create secret

```sh
kubectl -n kube-infra --dry-run=client \
create secret generic cert-manager-route53-credentials \
--from-file=config=.aws/config \
--from-file=credentials=.aws/credentials \
-o yaml > cert-manager-route53-credentials-secret.yaml
```

## encrypt secret

```sh
# from basepath
bash hack/encrypt_secrets.sh
```