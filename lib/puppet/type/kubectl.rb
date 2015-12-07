Puppet::Type.newtype(:kubectl) do
  @doc = <<-EOT
    doc 
  EOT

  ensurable do
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "name of the resource"
  end

  # kubectl settings
  newparam(:api_version) do
    desc "The API version to use when talking to the server"
  end

  newparam(:certificate_authority) do
    desc "Path to a cert. file for the certificate authority."
  end

  newparam(:certificate_certificate) do
    desc "Path to a client key file for TLS."
  end

  newparam(:certificate_key) do
    desc "Path to a client key file for TLS."
  end

  newparam(:cluster) do
    desc "The name of the kubeconfig cluster to use"
  end

  newparam(:context) do
    desc "The name of the kubeconfig context to use"
  end

  newparam(:insecure_skip_tls_verify) do
    desc "If true, the server's certificate will not be checked for validity. This will make your HTTPS connections insecure."
    defaultto false
  end

  newparam(:password) do
    desc "Password for basic authentication to the API server."
  end

  newparam(:username) do
    desc "Username for basic authentication to the API server."
  end

  newparam(:server) do
    desc "The address and port of the Kubernetes API server"
  end

  newparam(:token) do
    desc "Bearer token for authentication to the API server."
  end

end
