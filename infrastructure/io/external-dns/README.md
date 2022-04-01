# external-dns

## create credentials

```sh
mkdir .aws
cat << EOF > .aws/credentials
[default]
aws_access_key_id = YOURACCESSKEYID
aws_secret_access_key = YOURSECRETACCESSKEY
region = YOUERREGION
EOF
```

## create secret

```sh
kubectl -n kube-infra --dry-run=client \
create secret generic external-dns-route53-credentials \
--from-file=credentials=.aws/credentials \
-o yaml > external-dns-route53-credentials-secret.yaml
```

## encrypt secret

```sh
# from basepath
bash hack/encrypt_secrets.sh
```