# Security, Backup and Restore

## Roles
Create roles as a database administrator; never run the app as superuser. Create a separate migration owner and app login. Grant the app only required table operations and sequence usage. The app role must not own tables or have BYPASSRLS. Restrict direct UPDATE/DELETE access to audit rows; trigger writes should be managed carefully with production-tested ownership/grants.

## Tenant context
Within each request transaction, after authentication, set context using a bound parameter: SELECT set_config('app.tenant_id', $1, true). Never trust tenant ID directly from browser input. A custom GUC alone is not an authentication boundary if arbitrary SQL is possible. Test two tenants and cross-tenant SELECT/INSERT/UPDATE/DELETE denial.

## Sensitive data and queries
Store passwords only as slow salted Argon2id/bcrypt hashes. Do not store payment card data. Use TLS and encrypted backups in deployment. Parameterize all values; never concatenate user input into SQL. Dynamic identifiers must be allow-listed. Audit snapshots can contain sensitive fields, so define redaction and retention policies before production.

## Backup and restore
```sh
mkdir -p backups
pg_dump -Fc -f "backups/capstone_$(date +%F).dump" capstone
createdb capstone_restore_test
pg_restore --no-owner --dbname=capstone_restore_test "backups/capstone_$(date +%F).dump"
psql capstone_restore_test -c "SELECT count(*) FROM orders;"
dropdb capstone_restore_test
```
Supply credentials via environment, password file or secret manager; never commit dump files. Verify restore with row counts and application smoke tests.

## Checklist
- [ ] App role is not superuser, table owner or BYPASSRLS
- [ ] RLS tested on every tenant table
- [ ] Passwords hashed; no payment secrets stored
- [ ] Audit access restricted
- [ ] All queries parameterized
- [ ] Backup created and restore tested
