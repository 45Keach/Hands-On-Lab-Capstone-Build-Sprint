#!/usr/bin/env bash
set -euo pipefail
: "${PGDATABASE:=capstone}"
: "${RESTORE_DB:=capstone_restore_test}"
stamp="$(date +%F)"
mkdir -p backups
dump="backups/capstone_${stamp}.dump"
pg_dump -Fc -f "$dump" "$PGDATABASE"
createdb "$RESTORE_DB"
trap 'dropdb --if-exists "$RESTORE_DB"' EXIT
pg_restore --no-owner --dbname="$RESTORE_DB" "$dump"
psql "$RESTORE_DB" -v ON_ERROR_STOP=1 -c "SELECT count(*) AS restored_orders FROM public.orders;"
echo "Restore smoke check completed; compare row counts and run application smoke tests."
