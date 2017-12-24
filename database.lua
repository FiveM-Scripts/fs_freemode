-- no need to change this, use convars instead 
-- Check the documentation https://freemode.readme.io/docs/getting-started
database = {
    driver = GetConvar('database_driver', 'couchdb'),
    host = GetConvar('es_couchdb_url', '127.0.0.1'),
    port = GetConvar('es_couchdb_port', '5984'),
    username = GetConvar('es_couchdb_password', 'admin:changeme')
}
