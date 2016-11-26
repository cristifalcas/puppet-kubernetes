# == Class: kubernetes::master::apiserver
# http://kubernetes.io/docs/admin/kube-apiserver/
#
# [*ensure*]
#   Whether you want the apiserver daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
# [*enable*]
#   Whether you want the apiserver daemon to start up at boot
#   Defaults to true
#
# [*manage_as*]
#   How to manage the apiserver service. Valid values are: service, pod, container
#   Defaults to service
#
# [*container_image*]
#   From where to pull the image.
#   Defaults to gcr.io/google_containers/hyperkube-amd64:v1.3.5
#
# [*pod_cpu*]
#   CPU limits for this pod.
#   Defaults to 100mi
#
# [*pod_memory*]
#   Memory limits for this pod.
#   Defaults to 400Mi
#
## Parameters ##
#
# [*admission_control*]
#   Ordered list of plug-ins to do admission control of resources into cluster.
#   Comma-delimited list of: LimitRanger, AlwaysAdmit, ServiceAccount, ResourceQuota,
#   NamespaceExists, NamespaceAutoProvision, DenyExecOnPrivileged, AlwaysDeny, SecurityContextDeny, NamespaceLifecycle
#   Defaults to AlwaysAdmit
#
# [*admission_control_config_file*]
#   File with admission control configuration.
#   Defaults to undef
#
# [*advertise_address*]
#   The IP address on which to advertise the apiserver to members of the cluster.
#    This address must be reachable by the rest of the cluster. If blank, the --bind-address
#    will be used. If --bind-address is unspecified, the host's default interface will be used.
#   Defaults to undef
#
# [*allow_privileged*]
#   If true, allow privileged containers.
#   Defaults to false.
#
# [*apiserver_count*]
#   The number of apiservers running in the cluster
#   Defaults to 1.
#
# [*audit_log_maxage*]
#   The maximum number of days to retain old audit log files based on the timestamp encoded in their filename.
#   Defaults to undef.
#
# [*audit_log_maxbackup*]
#   The maximum number of old audit log files to retain.
#   Defaults to undef.
#
# [*audit_log_maxsize*]
#   The maximum size in megabytes of the audit log file before it gets rotated. Defaults to 100MB.
#   Defaults to undef.
#
# [*audit_log_path*]
#   If set, all requests coming to the apiserver will be logged to this file.
#   Defaults to undef.
#
# [*authentication_token_webhook_cache_ttl*]
#   The duration to cache responses from the webhook token authenticator.
#   Defaults to undef. (default 2m0s)
#
# [*authentication_token_webhook_config_file*]
#   File with webhook configuration for token authentication in kubeconfig format.
#   The API server will query the remote service to determine authentication for bearer tokens.
#   Defaults to undef.
#
# [*authorization_mode*]
#   Ordered list of plug-ins to do authorization on secure port. Comma-delimited list of: AlwaysAllow,AlwaysDeny,ABAC
#   Default AlwaysAllow.
#
# [*authorization_policy_file*]
#   File with authorization policy in csv format, used with --authorization-mode=ABAC, on the secure port.
#   Default undef.
#
# [*authorization_webhook_cache_authorized_ttl*]
#   The duration to cache 'authorized' responses from the webhook authorizer.
#   Default undef. (default 5m0s)
#
# [*authorization_webhook_cache_unauthorized_ttl*]
#   The duration to cache 'unauthorized' responses from the webhook authorizer.
#   Default undef. (default 30s)
#
# [*authorization_webhook_config_file*]
#   File with webhook configuration in kubeconfig format, used with --authorization-mode=Webhook.
#   The API server will query the remote service to determine access on the API server's secure port.
#   Default undef
#
# [*basic_auth_file*]
#   If set, the file that will be used to admit requests to the secure port of the API server via http basic authentication.
#   Deafaul undef
#
# [*bind_address*]
#   The IP address on which to serve the --read-only-port and --secure-port ports.
#    The associated interface(s) must be reachable by the rest of the cluster, and
#    by CLI/web clients. If blank, all interfaces will be used (0.0.0.0).
#   Deafaul 0.0.0.0
#
# [*cert_dir*]
#   The directory where the TLS certs are located (by default /var/run/kubernetes).
#    If --tls-cert-file and --tls-private-key-file are provided, this flag will be ignored.
#   Default /var/run/kubernetes
#
# [*client_ca_file*]
#   If set, any request presenting a client certificate signed by one of the authorities
#    in the client-ca-file is authenticated with an identity corresponding to the CommonName of the client certificate.
#   Default undef
#
# [*cloud_config*]
#   The path to the cloud provider configuration file. Empty string for no configuration file.
#   Default undef
#
# [*cloud_provider*]
#   The provider for cloud services. Empty string for no provider.
#   Default undef
#
# [*cors_allowed_origins*]
#   List of allowed origins for CORS, comma separated.\
#   An allowed origin can be a regular expression to support subdomain matching.
#   If this list is empty CORS will not be enabled. (default [])
#   Default undef
#
# [*delete_collection_workers*]
#   Number of workers spawned for DeleteCollection call. These are used to speed up namespace cleanup.
#   Default undef. (default 1)
#
# [*deserialization_cache_size*]
#   Number of deserialized json objects to cache in memory.
#   Default undef. (default 50000)
#
# [*enable_garbage_collector*]
#   Enables the generic garbage collector. MUST be synced with the corresponding flag of the kube-controller-manager.
#   Default undef. (default true)
#
# [*enable_swagger_ui*]
#   Enables swagger ui on the apiserver at /swagger-ui
#   Default undef.
#
# [*etcd_cafile*]
#   List of ca certificates
#   Default undef
#
# [*etcd_certfile*]
#   Public key to connect to etcd servers
#   Default undef
#
# [*etcd_keyfile*]
#   Private key to connect to etcd servers
#   Default undef
#
# [*etcd_prefix*]
#   The prefix for all resource paths in etcd.
#   Default /registry
#
# [*etcd_quorum_read*]
#   If true, enable quorum read
#   Default false
#
# [*etcd_servers*]
#   List of etcd servers to watch (http://ip:port), comma separated.
#   Default http://127.0.0.1:2379
#
# [*etcd_servers_overrides*]
#   Per-resource etcd servers overrides, comma separated.
#    The individual override format: group/resource#servers,
#    where servers are http://ip:port, semicolon separated.
#   Default []
#
# [*event_ttl*]
#   Amount of time to retain events. Default 1 hour.
#   Default 1h0m0s
#
# [*external_hostname*]
#   The hostname to use when generating externalized URLs for this master (e.g. Swagger API Docs.)
#   Default undef
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Default undef
#
# [*insecure_bind_address*]
#   The IP address on which to serve the --insecure-port (set to 0.0.0.0 for all interfaces). Defaults to localhost.
#   Default 127.0.0.1
#
# [*insecure_port*]
#   The port on which to serve unsecured, unauthenticated access. Default 8080.
#     It is assumed that firewall rules are set up such that this port is not
#     reachable from outside of the cluster and that port 443 on the cluster's
#     public address is proxied to this port. This is performed by nginx in the default setup.
#   Default 8080
#
# [*kubelet_certificate_authority*]
#   Path to a cert. file for the certificate authority.
#   Default undef
#
# [*kubelet_client_certificate*]
#   Path to a client cert file for TLS.
#   Default undef
#
# [*kubelet_client_key*]
#   Path to a client key file for TLS.
#   Default undef
#
# [*kubelet_https*]
#   Use https for kubelet connections
#   Default true
#
# [*kubelet_timeout*]
#   Timeout for kubelet operations
#   Default 5s
#
# [*kubernetes_service_node_port*]
#   If non-zero, the Kubernetes master service (which apiserver creates/maintains) will be of type NodePort, using this as
#   the value of the port. If zero, the Kubernetes master service will be of type ClusterIP.
#   Default 0
#
# [*long_running_request_regexp*]
#   A regular expression matching long running requests which should be excluded from maximum inflight request handling.
#      Default to "(/|^)((watch|proxy)(/|$)|(logs?|portforward|exec|attach)/?$)"
#   Default undef
#
# [*master_service_namespace*]
#   The namespace from which the kubernetes master services should be injected into pods
#   Default "default"
#
# [*max_connection_bytes_per_sec*]
#   If non-zero, throttle each user connection to this number of bytes/sec.  Currently only
#      applies to long-running requests
#   Default 0
#
# [*max_requests_inflight*]
#   The maximum number of requests in flight at a given time.  When the server exceeds this, it
#      rejects requests.  Zero for no limit.
#   Default 400
#
# [*min_request_timeout*]
#   An optional field indicating the minimum number of seconds a handler must keep a request open
#      before timing it out. Currently only honored by the watch request handler, which picks a randomized value above this number
#      as the connection timeout, to spread out load.
#   Default 1800
#
# [*profiling*]
#   Enable profiling via web interface host:port/debug/pprof/
#   Default true
#
# [*repair_malformed_updates*]
#   If true, server will do its best to fix the update request to pass the validation, e.g., setting empty UID in update request
#   to its existing value. This flag can be turned off after we fix all the clients that send malformed updates.
#   Default true
#
# [*runtime_config*]
#   A set of key=value pairs that describe runtime configuration that may be passed to apiserver.
#      apis/<groupVersion> key can be used to turn on/off specific api versions. apis/<groupVersion>/<resource> can be used to turn
#      on/off specific resources. api/all and api/legacy are special keys to control all and legacy api versions respectively.
#   Default undef
#
# [*secure_port*]
#   The port on which to serve HTTPS with authentication and authorization. If 0, don't serve HTTPS at all.
#   Default 6443
#
# [*service_account_key_file*]
#   File containing PEM-encoded x509 RSA private or public key, used to verify ServiceAccount
#      tokens. If unspecified, --tls-private-key-file is used.
#   Default undef
#
# [*service_account_lookup*]
#   If true, validate ServiceAccount tokens exist in etcd as part of authentication.
#   Default false
#
# [*service_cluster_ip_range*]
#   A CIDR notation IP range from which to assign service cluster IPs. This must not overlap
#      with any IP ranges assigned to nodes for pods.
#   Default undef
#
# [*service_node_port_range*]
#   A port range to reserve for services with NodePort visibility.  Example: '30000-32767'.
#      Inclusive at both ends of the range.
#   Default undef
#
# [*ssh_keyfile*]
#   If non-empty, use secure SSH proxy to the nodes, using this user keyfile
#   Default undef
#
# [*ssh_user*]
#   If non-empty, use secure SSH proxy to the nodes, using this user name
#   Default undef
#
# [*storage_backend*]
#   The storage backend for persistence. Options: 'etcd2' (default), 'etcd3'.
#   Default undef
#
# [*storage_media_type*]
#   The media type to use to store objects in storage. Defaults to application/json.
#   Some resources may only support a specific media type and will ignore this setting. (default "application/json")
#   Default undef
#
# [*target_ram_mb*]
#   Memory limit for apiserver in MB (used to configure sizes of caches, etc.)
#   Default undef
#
# [*tls_cert_file*]
#   File containing x509 Certificate for HTTPS.  (CA cert, if any, concatenated after server cert). If HTTPS
#      serving is enabled, and --tls-cert-file and --tls-private-key-file are not provided, a self-signed certificate and key are
#      generated for the public address and saved to /var/run/kubernetes.
#   Default undef
#
# [*tls_private_key_file*]
#   File containing x509 private key matching --tls-cert-file.
#   Default undef
#
# [*token_auth_file*]
#   If set, the file that will be used to secure the secure port of the API server via token authentication.
#   Default undef
#
# [*watch_cache*]
#   Enable watch caching in the apiserver
#   Default true
#
# [*watch_cache_sizes*]
#   List of watch cache sizes for every resource (pods, nodes, etc.), comma separated. The individual override format: resource#size,
#   where size is a number. It takes effect when watch-cache is enabled.
#   Default undef
#
# [*verbosity*]
#   Set the log verbosity
#   Default 2
#
# [*extra_args*]
#   Set your own 
#   Default undef
#
class kubernetes::master::apiserver (
  $service_cluster_ip_range,
  $ensure                                       = $kubernetes::master::params::kube_api_service_ensure,
  $journald_forward_enable                      = $kubernetes::master::params::kube_api_journald_forward_enable,
  $enable                                       = $kubernetes::master::params::kube_api_service_enable,
  $manage_as                                    = $kubernetes::master::params::kube_api_manage_as,
  $container_image                              = $kubernetes::master::params::kube_api_container_image,
  $pod_cpu                                      = $kubernetes::master::params::kube_api_pod_cpu,
  $pod_memory                                   = $kubernetes::master::params::kube_api_pod_memory,
  $admission_control                            = $kubernetes::master::params::kube_api_admission_control,
  $admission_control_config_file                = $kubernetes::master::params::kube_api_admission_control_config_file,
  $advertise_address                            = $kubernetes::master::params::kube_api_advertise_address,
  $allow_privileged                             = $kubernetes::master::params::kube_api_allow_privileged,
  $apiserver_count                              = $kubernetes::master::params::kube_api_server_count,
  $audit_log_maxage                             = $kubernetes::master::params::kube_api_audit_log_maxage,
  $audit_log_maxbackup                          = $kubernetes::master::params::kube_api_audit_log_maxbackup,
  $audit_log_maxsize                            = $kubernetes::master::params::kube_api_audit_log_maxsize,
  $audit_log_path                               = $kubernetes::master::params::kube_api_audit_log_path,
  $authentication_token_webhook_cache_ttl       = $kubernetes::master::params::kube_api_authentication_token_webhook_cache_ttl,
  $authentication_token_webhook_config_file     = $kubernetes::master::params::kube_api_authentication_token_webhook_config_file,
  $authorization_mode                           = $kubernetes::master::params::kube_api_authorization_mode,
  $authorization_policy_file                    = $kubernetes::master::params::kube_api_authorization_policy_file,
  $authorization_webhook_cache_authorized_ttl   = $kubernetes::master::params::kube_api_authorization_webhook_cache_authorized_ttl,
  $authorization_webhook_cache_unauthorized_ttl = $kubernetes::master::params::kube_api_authorization_webhook_cache_unauthorized_ttl,
  $authorization_webhook_config_file            = $kubernetes::master::params::kube_api_authorization_webhook_config_file,
  $basic_auth_file                              = $kubernetes::master::params::kube_api_basic_auth_file,
  $bind_address                                 = $kubernetes::master::params::kube_api_bind_address,
  $cert_dir                                     = $kubernetes::master::params::kube_api_cert_dir,
  $client_ca_file                               = $kubernetes::master::params::kube_api_client_ca_file,
  $cloud_config                                 = $kubernetes::master::params::kube_api_cloud_config,
  $cloud_provider                               = $kubernetes::master::params::kube_api_cloud_provider,
  $cors_allowed_origins                         = $kubernetes::master::params::kube_api_cors_allowed_origins,
  $delete_collection_workers                    = $kubernetes::master::params::kube_api_delete_collection_workers,
  $deserialization_cache_size                   = $kubernetes::master::params::kube_api_deserialization_cache_size,
  $enable_garbage_collector                     = $kubernetes::master::params::kube_api_enable_garbage_collector,
  $enable_swagger_ui                            = $kubernetes::master::params::kube_api_enable_swagger_ui,
  $etcd_cafile                                  = $kubernetes::master::params::kube_api_etcd_cafile,
  $etcd_certfile                                = $kubernetes::master::params::kube_api_etcd_certfile,
  $etcd_keyfile                                 = $kubernetes::master::params::kube_api_etcd_keyfile,
  $etcd_prefix                                  = $kubernetes::master::params::kube_api_etcd_prefix,
  $etcd_quorum_read                             = $kubernetes::master::params::kube_api_etcd_quorum_read,
  $etcd_servers                                 = $kubernetes::master::params::kube_api_etcd_servers,
  $etcd_servers_overrides                       = $kubernetes::master::params::kube_api_etcd_servers_overrides,
  $event_ttl                                    = $kubernetes::master::params::kube_api_event_ttl,
  $external_hostname                            = $kubernetes::master::params::kube_api_external_hostname,
  $google_json_key                              = $kubernetes::master::params::kube_api_google_json_key,
  $insecure_bind_address                        = $kubernetes::master::params::kube_api_insecure_bind_address,
  $insecure_port                                = $kubernetes::master::params::kube_api_insecure_port,
  $kubelet_certificate_authority                = $kubernetes::master::params::kube_api_kubelet_certificate_authority,
  $kubelet_client_certificate                   = $kubernetes::master::params::kube_api_kubelet_client_certificate,
  $kubelet_client_key                           = $kubernetes::master::params::kube_api_kubelet_client_key,
  $kubelet_https                                = $kubernetes::master::params::kube_api_kubelet_https,
  $kubelet_timeout                              = $kubernetes::master::params::kube_api_kubelet_timeout,
  $kubernetes_service_node_port                 = $kubernetes::master::params::kube_api_kubernetes_service_node_port,
  $long_running_request_regexp                  = $kubernetes::master::params::kube_api_long_running_request_regexp,
  $master_service_namespace                     = $kubernetes::master::params::kube_api_master_service_namespace,
  $max_connection_bytes_per_sec                 = $kubernetes::master::params::kube_api_max_connection_bytes_per_sec,
  $max_requests_inflight                        = $kubernetes::master::params::kube_api_max_requests_inflight,
  $min_request_timeout                          = $kubernetes::master::params::kube_api_min_request_timeout,
  $profiling                                    = $kubernetes::master::params::kube_api_profiling,
  $repair_malformed_updates                     = $kubernetes::master::params::kube_api_repair_malformed_updates,
  $runtime_config                               = $kubernetes::master::params::kube_api_runtime_config,
  $secure_port                                  = $kubernetes::master::params::kube_api_secure_port,
  $service_account_key_file                     = $kubernetes::master::params::kube_api_service_account_key_file,
  $service_account_lookup                       = $kubernetes::master::params::kube_api_service_account_lookup,
  $service_node_port_range                      = $kubernetes::master::params::kube_api_service_node_port_range,
  $ssh_keyfile                                  = $kubernetes::master::params::kube_api_ssh_keyfile,
  $ssh_user                                     = $kubernetes::master::params::kube_api_ssh_user,
  $storage_backend                              = $kubernetes::master::params::kube_api_storage_backend,
  $storage_media_type                           = $kubernetes::master::params::kube_api_storage_media_type,
  $target_ram_mb                                = $kubernetes::master::params::kube_api_target_ram_mb,
  $tls_cert_file                                = $kubernetes::master::params::kube_api_tls_cert_file,
  $tls_private_key_file                         = $kubernetes::master::params::kube_api_tls_private_key_file,
  $token_auth_file                              = $kubernetes::master::params::kube_api_token_auth_file,
  $watch_cache                                  = $kubernetes::master::params::kube_api_watch_cache,
  $watch_cache_sizes                            = $kubernetes::master::params::kube_api_watch_cache_sizes,
  $verbosity                                    = $kubernetes::master::params::kube_api_verbosity,
  $extra_args                                   = $kubernetes::master::params::kube_api_extra_args,
) inherits kubernetes::master::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)
  validate_re($manage_as, '^(service|pod|container)$')

  case $manage_as {
    'service'   : {
      include ::kubernetes::master

      case $::osfamily {
        'redhat' : {
        }
        'debian' : {
          file { '/etc/default/kube-apiserver':
            ensure  => 'file',
            force   => true,
            content => template("${module_name}/etc/default/api-server.erb"),
            notify  => Service['kube-apiserver'],
          }
        }
        default  : {
          fail("Unsupport OS: ${::osfamily}")
        }
      }

      file { '/etc/kubernetes/apiserver':
        ensure  => 'file',
        content => template("${module_name}/etc/kubernetes/apiserver.erb"),
        notify  => Service['kube-apiserver'],
      }

      service { 'kube-apiserver':
        ensure => $ensure,
        enable => $enable,
      }

      if $journald_forward_enable and $::operatingsystemmajrelease == '7' {
        file { '/etc/systemd/system/kube-apiserver.service.d':
          ensure => 'directory',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        } ->
        file { '/etc/systemd/system/kube-apiserver.service.d/journald.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template("${module_name}/systemd/apiserver_journald.conf.erb"),
        } ~>
        exec { 'reload systemctl daemon for kube-apiserver':
          command     => '/bin/systemctl daemon-reload',
          refreshonly => true,
        } ~> Service['kube-apiserver']
      }
    }
    'pod'       : {
      if $enable {
        $ensure_file = 'file'
      } else {
        $ensure_file = 'absent'
      }

      file { '/etc/kubernetes/manifests/pod_kube-apiserver.yml':
        ensure  => $ensure_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/pods/pod_kube-apiserver.yml.erb"),
        require => Service['kubelet'],
      }
    }
    'container' : {
      if $enable {
        $ensure_container = 'present'
      } else {
        $ensure_container = 'absent'
      }
      $args = inline_template("<%= scope.function_template(['kubernetes/_apiserver.erb']) %>")

      docker::run { 'kube-apiserver':
        ensure           => $ensure_container,
        image            => $container_image,
        command          => '/hyperkube apiserver ${args}',
        volumes          => ['/etc/pki:/etc/pki', '/etc/ssl:/etc/ssl', '/etc/kubernetes:/etc/kubernetes',],
        restart_service  => true,
        net              => 'host',
        privileged       => true,
        detach           => false,
        extra_parameters => ['--restart=always'],
      }
    }
    default     : {
    }
  }
}
