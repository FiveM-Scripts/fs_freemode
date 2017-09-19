database = {
    host = GetConvar('es_couchdb_url', '127.0.0.1'),
    port = GetConvar('es_couchdb_port', '5984'),
    username = GetConvar('es_couchdb_password', 'admin:changeme')
}