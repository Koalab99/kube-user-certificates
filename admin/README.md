# Admin

## Define Roles
Your task starts by setting up roles on your kubernetes cluster.

Sample roles can be found in `roles/` directory.

I recommend reading the [documentation about roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) first.

## Generate user CSR request
A user might want to access the cluster. You need to grab its CSR and run
```
./add-csr.sh <CSR_FILE>
```
To generate the kubernetes CSR definition in yaml
Then feel free to apply it using:
```
kubectl apply -f <CSR_FILE>
```

## Review user CSR
```
kubectl get csr
```
Then you can approve or deny the certificate:
```
kubectl certificate <approve|deny> <CSR_NAME>
```

You can get the user certificate using:
```
kubectl get csr <CSR_NAME> -o yaml
```
and the CA certificate by looking in your cluster certificates, usually `/etc/kubernetes/pki/` or `/var/lib/rancher/k3s/server/tls/`

Both files need to be given to the user.

## Create a rolebinding
Your user doesn't have any right, we need to add it to one or multiple roles.

You can get a list of namespaces roles with:
```
kubectl get roles -A
```

In case this is an admin account, you probably want to give it a cluster wide role:
```
kubectl get clusterrole
```

If you know your user name and (cluster)role, you might want to use the command:
```
kubectl create rolebinding <ROLEBINDING_NAME> --user <USER> --role <ROLE>
# OR
kubectl create clusterrolebinding <CRB_NAME> --user <USER> --clusterrole=<CLUSTER_ROLE>
```

If you want to generate the YAML file for this, you can append `-o yaml --dry-run=client` to the above commands.
