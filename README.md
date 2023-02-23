# Projet Final du Groupe 3

## Crédits

Réalisé par Mathieu Marconi, Nathan Lalloué, Paul Blouët, Sabrina Macaluso !

## Installation rapide

Pour installer :

```
./install.sh
```

Sont également présents un script `uninstall.sh` et un script `reinstall.sh`.

## Architecture

* **Terraform** provisionne les machines sur Azure.
* **Ansible** installe et prépare les outils, principalement GitLab (chaîne DevOps) et Kubernetes (production).
* **GitLab CI** déploie en continu les applications sur le cluster K8S.
