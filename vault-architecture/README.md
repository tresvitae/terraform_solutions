

# Sources:
https://developer.hashicorp.com/vault/tutorials/raft/raft-storage-aws


# Use Vault's Integrated Storage to persist the encrypted data. The integrated storage has the following benefits:

Integrated into Vault (reducing total administration)
All configuration within Vault
Supports failover and multi-cluster replication
Eliminates additional network requests
Lowers complexity when diagnosing issues (leading to faster time to recovery)


# IMPROVE
- userdata-vault-server.tpl file
- S3 snapshots
- autounseal
- use policy in vault/
- 