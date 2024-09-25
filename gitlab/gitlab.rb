gitlab_rails['gitlab_default_theme'] = 2
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab-root-password')

# EXTRA FEATURES
gitlab_rails['smtp_enable'] = false
gitlab_rails['gitlab_email_enabled'] = false
gitlab_rails['gitlab_username_changing_enabled'] = false
gitlab_rails['gitlab_default_projects_features_issues'] = false
gitlab_rails['gitlab_default_projects_features_merge_requests'] = false
gitlab_rails['gitlab_default_projects_features_wiki'] = false
gitlab_rails['gitlab_default_projects_features_snippets'] = false
gitlab_rails['gitlab_default_projects_features_builds'] = true
gitlab_rails['gitlab_default_projects_features_container_registry'] = true
gitlab_rails['trusted_proxies'] = []
gitlab_rails['shutdown_blackout_seconds'] = 10
gitlab_rails['incoming_email_enabled'] = false
postgresql['enable'] = false
redis['enable'] = false
nginx['enable'] = true
gitlab_pages['enable'] = false
gitlab_kas['enable'] = false
mattermost['enable'] = false
gitlab_rails['lfs_enabled'] = false
gitlab_rails['disable_animations'] = true
gitlab_rails['usage_ping_enabled'] = false
gitlab_rails['omniauth_enabled'] = false
gitlab_rails['manage_backup_path'] = true
gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"

# POSTGRESQL
gitlab_rails['db_adapter'] = "postgresql"
gitlab_rails['db_database'] = "gitlab"
gitlab_rails['db_username'] = "gitlab"
gitlab_rails['db_password'] = File.read('/run/secrets/postgres-password')
gitlab_rails['db_host'] = "postgres"
gitlab_rails['db_port'] = 5432
gitlab_rails['db_sslmode'] = nil
gitlab_rails['db_sslcompression'] = 0
gitlab_rails['db_sslrootcert'] = nil
gitlab_rails['db_sslcert'] = nil
gitlab_rails['db_sslkey'] = nil

# REDIS
gitlab_rails['redis_host'] = "redis"
gitlab_rails['redis_port'] = 6379
gitlab_rails['redis_ssl'] = false
gitlab_rails['redis_password'] = nil
gitlab_rails['redis_database'] = 0
gitlab_rails['redis_enable_client'] = true
gitlab_rails['redis_tls_ca_cert_dir'] = '/opt/gitlab/embedded/ssl/certs/'
gitlab_rails['redis_tls_ca_cert_file'] = '/opt/gitlab/embedded/ssl/certs/cacert.pem'
gitlab_rails['redis_tls_client_cert_file'] = nil
gitlab_rails['redis_tls_client_key_file'] = nil

################################################################################
## Container Registry settings
##! Docs: https://docs.gitlab.com/ee/administration/packages/container_registry.html
################################################################################

# registry_external_url 'https://registry.example.com'

### Settings used by GitLab application
# gitlab_rails['registry_enabled'] = true
# gitlab_rails['registry_host'] = "registry.gitlab.example.com"
# gitlab_rails['registry_port'] = "5005"
# gitlab_rails['registry_path'] = "/var/opt/gitlab/gitlab-rails/shared/registry"

# Notification secret, it's used to authenticate notification requests to GitLab application
# You only need to change this when you use external Registry service, otherwise
# it will be taken directly from notification settings of your Registry
# gitlab_rails['registry_notification_secret'] = nil

###! **Do not change the following 3 settings unless you know what you are
###!   doing**
# gitlab_rails['registry_api_url'] = "http://127.0.0.1:5000"
# gitlab_rails['registry_key_path'] = "/var/opt/gitlab/gitlab-rails/certificate.key"
# gitlab_rails['registry_issuer'] = "omnibus-gitlab-issuer"

### Settings used by Registry application
# registry['enable'] = true
# registry['username'] = "registry"
# registry['group'] = "registry"
# registry['uid'] = nil
# registry['gid'] = nil
# registry['dir'] = "/var/opt/gitlab/registry"
# registry['registry_http_addr'] = "127.0.0.1:5000"
# registry['debug_addr'] = "localhost:5001"
# registry['log_directory'] = "/var/log/gitlab/registry"
# registry['env_directory'] = "/opt/gitlab/etc/registry/env"
# registry['env'] = {
#   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
# }
# registry['log_level'] = "info"
# registry['log_formatter'] = "text"
# registry['rootcertbundle'] = "/var/opt/gitlab/registry/certificate.crt"
# registry['health_storagedriver_enabled'] = true
# registry['middleware'] = nil
# registry['storage_delete_enabled'] = true
# registry['validation_enabled'] = false
# registry['autoredirect'] = false
# registry['compatibility_schema1_enabled'] = false
# registry['database'] = nil

gitlab_shell['log_level'] = 'WARN'

################################################################################
## Registry NGINX
################################################################################

# All the settings defined in the "GitLab Nginx" section are also available in
# this "Registry NGINX" section, using the key `registry_nginx`.  However, those
# settings should be explicitly set. That is, settings given as
# `nginx['some_setting']` WILL NOT be automatically replicated as
# `registry_nginx['some_setting']` and should be set separately.

# Below you can find settings that are exclusive to "Registry NGINX"
# registry_nginx['enable'] = false

# When the registry is automatically enabled using the same domain as `external_url`,
# it listens on this port
# registry_nginx['listen_port'] = 5050

prometheus['enable'] = false
prometheus['monitor_kubernetes'] = false
alertmanager['enable'] = false
prometheus_monitoring['enable'] = false
