# == Class: kubernetes::master
#
# Module to install an up-to-date version of Docker from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the docker package.
#   Defaults to present
#
# [*service_state_apiserver*]
#   Whether you want the apiserver daemon to start up
#   Defaults to running
#
# [*service_enable_apiserver*]
#   Whether you want the apiserver daemon to start up at boot
#   Defaults to true
#
# [*service_state_controller*]
#   Whether you want the control manager daemon to start up
#   Defaults to running
#
# [*service_enable_controller*]
#   Whether you want the control manager daemon to start up at boot
#   Defaults to true
#
# [*service_state_scheduler*]
#   Whether you want the scheduler daemon to start up
#   Defaults to running
#
# [*service_enable_scheduler*]
#   Whether you want the scheduler daemon to start up at boot
#   Defaults to true
#
# [*kube_api_address*]
#   The IP address on which to serve the --insecure-port (set to 0.0.0.0 for all interfaces).
#   Defaults to 127.0.0.1.
#
# [*kube_api_port*]
#   The port on which to serve unsecured, unauthenticated access.
#   It is assumed that firewall rules are set up such that this port is not reachable from outside
#   of the cluster and that port 443 on the cluster's public address is proxied to this port.
#   This is performed by nginx in the default setup.
#   Default 8080.
#
# [*kubelet_port*]
#   Port minions listen on
#   Deafaul 10250
#
# [*kube_etcd_servers*]
#   Comma separated list of nodes in the etcd cluster
#
# [*kube_api_etcd_prefix*]
#   The prefix for all resource paths in etcd.
#   Default /registry
#
# [*kube_service_addresses*]
#   A CIDR notation IP range from which to assign service cluster IPs.
#   This must not overlap with any IP ranges assigned to nodes for pods.
#
# [*kube_admission_control*]
#   Ordered list of plug-ins to do admission control of resources into cluster.
#   Comma-delimited list of: LimitRanger, AlwaysAdmit, ServiceAccount, ResourceQuota,
#   NamespaceExists, NamespaceAutoProvision, DenyExecOnPrivileged, AlwaysDeny, SecurityContextDeny, NamespaceLifecycle
#   Type: string or array with the policies
#
# [*kube_api_allow_privileged*]
#   If true, allow privileged containers.
#   Default false
#
# [*kube_api_bind_address*]
#   The IP address on which to serve the --read-only-port and --secure-port ports.
#   The associated interface(s) must be reachable by the rest of the cluster, and by CLI/web clients.
#   If blank, all interfaces will be used (0.0.0.0).
#   Default 0.0.0.0
#
# [*kube_api_secure_port*]
#   The port on which to serve HTTPS with authentication and authorization. If 0, don't serve HTTPS at all.
#   Default 6443
#
# [*kube_api_cluster_name*]
#   The instance prefix for the cluster
#   Default kubernetes
#
# [*kube_api_external_hostname*]
#   The hostname to use when generating externalized URLs for this master (e.g. Swagger API Docs.)
#   Default undef
#
# [*kube_api_advertise_address*]
#   The IP address on which to advertise the apiserver to members of the cluster. This address must be
#   reachable by the rest of the cluster. If blank, the --bind-address will be used. If --bind-address is unspecified,
#   the host's default interface will be used.
#   Default undef
#
# [*kube_api_args*]
#
# [*kube_controller_manager_args*]
#
# [*kube_scheduler_args*]
#

class kubernetes::master (
  $ensure                       = $kubernetes::master::params::ensure,
  $service_state_apiserver      = $kubernetes::master::params::service_state_apiserver,
  $service_enable_apiserver     = $kubernetes::master::params::service_enable_apiserver,
  $service_state_controller     = $kubernetes::master::params::service_state_controller,
  $service_enable_controller    = $kubernetes::master::params::service_enable_controller,
  $service_state_scheduler      = $kubernetes::master::params::service_state_scheduler,
  $service_enable_scheduler     = $kubernetes::master::params::service_enable_scheduler,
  # api
  $kube_api_address             = $kubernetes::master::params::kube_api_address,
  $kube_api_port                = $kubernetes::master::params::kube_api_port,
  $kube_api_args                = $kubernetes::master::params::kube_api_args,
  $kubelet_port                 = $kubernetes::master::params::kubelet_port,
  $kube_etcd_servers            = $kubernetes::master::params::kube_etcd_servers,
  $kube_api_etcd_prefix         = $kubernetes::master::params::kube_api_etcd_prefix,
  $kube_service_addresses       = $kubernetes::master::params::kube_service_addresses,
  $kube_admission_control       = $kubernetes::master::params::kube_admission_control,
  $kube_api_allow_privileged    = $kubernetes::master::params::kube_api_allow_privileged,
  $kube_api_bind_address        = $kubernetes::master::params::kube_api_bind_address,
  $kube_api_secure_port         = $kubernetes::master::params::kube_api_secure_port,
  $kube_api_cluster_name        = $kubernetes::master::params::kube_api_cluster_name,
  $kube_api_external_hostname   = $kubernetes::master::params::kube_api_external_hostname,
  # controller
  $kube_controller_manager_args = $kubernetes::master::params::kube_controller_manager_args,
  # scheduler
  $kube_scheduler_args          = $kubernetes::master::params::kube_scheduler_args,
) inherits kubernetes::master::params {
  include kubernetes

  class { 'kubernetes::master::install': } ->
  Class['kubernetes'] ->
  class { 'kubernetes::master::config': } ->
  # we notify servicea about restarts from config files
  class { 'kubernetes::master::service': }

  contain 'kubernetes::master::install'
  contain 'kubernetes::master::config'
  contain 'kubernetes::master::service'
}
#      --alsologtostderr=false: log to standard error as well as files
#      --log-dir=: If non-empty, write log files in this directory
#      --log-flush-frequency=5s: Maximum number of seconds between log flushes
#      --logtostderr=true: log to standard error instead of files
#      --api-burst=200: API burst amount for the read only port
#      --api-prefix="/api": The prefix for API requests on the server. Default '/api'.
#      --api-rate=10: API rate limit as QPS for the read only port
#      --authorization-mode="AlwaysAllow": Selects how to do authorization on the secure port.  One of: AlwaysAllow,AlwaysDeny,ABAC
#      --authorization-policy-file="": File with authorization policy in csv format, used with --authorization-mode=ABAC, on the secure port.
#      --basic-auth-file="": If set, the file that will be used to admit requests to the secure port of the API server via http basic authentication.
#      --cert-dir="/var/run/kubernetes": The directory where the TLS certs are located (by default /var/run/kubernetes). If --tls-cert-file and --tls-private-key-file are provided, this flag will be ignored.
#      --client-ca-file="": If set, any request presenting a client certificate signed by one of the authorities in the client-ca-file is authenticated with an identity corresponding to the CommonName of the client certificate.
#      --cors-allowed-origins=[]: List of allowed origins for CORS, comma separated.  An allowed origin can be a regular expression to support subdomain matching.  If this list is empty CORS will not be enabled.
#      --event-ttl=1h0m0s: Amount of time to retain events. Default 1 hour.
#      --kubelet-certificate-authority="": Path to a cert. file for the certificate authority.
#      --kubelet-client-certificate="": Path to a client key file for TLS.
#      --kubelet-client-key="": Path to a client key file for TLS.
#      --kubelet-https=true: Use https for kubelet connections
#      --kubelet-timeout=5s: Timeout for kubelet operations
#      --long-running-request-regexp="(/|^)((watch|proxy)(/|$)|(logs|portforward|exec)/?$)": A regular expression matching long running requests which should be excluded from maximum inflight request handling.
#      --master-service-namespace="default": The namespace from which the kubernetes master services should be injected into pods
#      --max-requests-inflight=400: The maximum number of requests in flight at a given time.  When the server exceeds this, it rejects requests.  Zero for no limit.
#      --min-request-timeout=1800: An optional field indicating the minimum number of seconds a handler must keep a request open before timing it out. Currently only honored by the watch request handler, which picks a randomized value above this number as the connection timeout, to spread out load.
#      --profiling=true: Enable profiling via web interface host:port/debug/pprof/
#      --service-account-key-file="": File containing PEM-encoded x509 RSA private or public key, used to verify ServiceAccount tokens. If unspecified, --tls-private-key-file is used.
#      --service-account-lookup=false: If true, validate ServiceAccount tokens exist in etcd as part of authentication.
#      --service-node-port-range=: A port range to reserve for services with NodePort visibility.  Example: '30000-32767'.  Inclusive at both ends of the range.
#      --ssh-keyfile="": If non-empty, use secure SSH proxy to the nodes, using this user keyfile
#      --ssh-user="": If non-empty, use secure SSH proxy to the nodes, using this user name
#      --stderrthreshold=2: logs at or above this threshold go to stderr
#      --tls-cert-file="": File containing x509 Certificate for HTTPS.  (CA cert, if any, concatenated after server cert). If HTTPS serving is enabled, and --tls-cert-file and --tls-private-key-file are not provided, a self-signed certificate and key are generated for the public address and saved to /var/run/kubernetes.
#      --tls-private-key-file="": File containing x509 private key matching --tls-cert-file.
#      --token-auth-file="": If set, the file that will be used to secure the secure port of the API server via token authentication.
