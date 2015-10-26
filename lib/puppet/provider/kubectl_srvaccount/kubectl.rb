Puppet::Type.type(:kubectl_srvaccount).provide(:kubectl) do
  commands :kubectl => '/bin/kubectl'

  def exists?
    srvaccounts = kubectl('get', 'serviceAccounts', '--all-namespaces').split("\n")
    srvaccounts.shift
    srvaccounts.each do |line|
      if resource[:name] == line.split[1] and resource[:namespace] == line.split[0] then
        return true
      end
    end
    return false
  end

  def create
    file = Tempfile.new(['serviceaccount', '.yml'])
    file.write(<<-EOS)
apiVersion: v1
kind: ServiceAccount
metadata:
  name: #{resource[:name]}
EOS
    file.close
    kubectl('create', "--namespace=#{resource[:namespace]}", '-f', file.path)
    file.unlink
  end

  def destroy
    kubectl('delete', "--namespace=#{resource[:namespace]}", "serviceaccount/#{resource[:name]}")
  end

end
