# Kube User Scripts

This repo is a set of tools used to simplify the access of the cluster by an end-user.
It is using certificates and roles to give access to your cluster from your machine.

## Quick How To
1. User generates a pair of key/certificate signing request (user/gen-csr.sh)
2. Admin sign and gives back the certificates and API URL to User (admin/add-csr.sh)
3. Admin bind the new certificate to a Role/ClusterRole (admin/README.md)
3. User generates its kubeconfig (user/gen-kubeconfig)
4. User can access the cluster with the access granted by Admin
