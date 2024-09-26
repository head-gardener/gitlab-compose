gitlab_rails['gitlab_default_theme'] = 2
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab-root-password')
gitlab_shell['log_level'] = 'WARN'

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
gitlab_pages['enable'] = false
gitlab_kas['enable'] = false
mattermost['enable'] = false
gitlab_rails['lfs_enabled'] = false
gitlab_rails['disable_animations'] = true
gitlab_rails['usage_ping_enabled'] = false
gitlab_rails['omniauth_enabled'] = false
gitlab_rails['manage_backup_path'] = true
gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"

# NGINX
nginx['enable'] = true

# POSTGRESQL
postgresql['enable'] = true

# REDIS
redis['enable'] = true
redis['enable_client'] = false
redis['client_max_memory'] = '256mb'
redis['maxmemory_policy'] = 'allkeys-lru'

# REGISTRY
registry_external_url 'http://gitlab'
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = "gitlab"
gitlab_rails['registry_port'] = "5000"
gitlab_rails['registry_path'] = "/var/opt/gitlab/gitlab-rails/shared/registry"
registry['enable'] = true
registry['username'] = "registry"
registry['group'] = "registry"
registry['dir'] = "/var/opt/gitlab/registry"
registry['registry_http_addr'] = "0.0.0.0:5000"
registry['debug_addr'] = "localhost:5001"
registry['log_directory'] = "/var/log/gitlab/registry"
registry['log_level'] = "warn"
registry['log_formatter'] = "json"

# PROMETHEUS
prometheus['enable'] = false
prometheus['monitor_kubernetes'] = false
alertmanager['enable'] = false
prometheus_monitoring['enable'] = false
