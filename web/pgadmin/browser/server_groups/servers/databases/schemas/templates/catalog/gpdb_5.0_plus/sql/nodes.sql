{% import 'catalog/gpdb_5.0_plus/macros/catalogs.sql' as CATALOGS %}
SELECT
    nsp.oid,
{{ CATALOGS.LABELS('nsp', _) }},
    has_schema_privilege(nsp.oid, 'CREATE') as can_create,
    has_schema_privilege(nsp.oid, 'USAGE') as has_usage
FROM
    pg_namespace nsp
WHERE
    {% if scid %}
    nsp.oid={{scid}}::oid AND
    {% endif %}
    (
{{ CATALOGS.LIST('nsp') }}
    )
ORDER BY 2;
