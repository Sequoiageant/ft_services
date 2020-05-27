#!/bin/sh

# sed -i "s/disable_initial_admin_creation = false/disable_initial_admin_creation = true/" /grafana-6.7.3/conf/defaults.ini
sed -i "s/admin_user = admin/admin_user = $USER/" /grafana-6.7.3/conf/defaults.ini
sed -i "s/admin_password = admin/admin_password = $PASSWORD/" /grafana-6.7.3/conf/defaults.ini

# chown grafana:grafana /grafana-6.7.3/data/grafana.db
cd /grafana-6.7.3/bin/ && ./grafana-server
