Puppet::Type.type(:kubectl_namespace).provide(:kubectl) do
  commands :kubectl => '/bin/kubectl'
  Puppet.debug "running kubectl_namespace: #{self.inspect}"

  mk_resource_methods
  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def self.get_list_of_resources
    namespaces = kubectl('get', 'namespaces').split("\n")
    namespaces.shift
    namespaces.sort
    Puppet.debug "get_list_of_resources namespaces: #{namespaces.inspect}"
    namespaces
  end

  def self.get_resource_properties(name)
    properties = {}
    properties[:ensure] = :present
    properties[:provider] = :kubectl
    properties[:name] = name
    properties
  end

  def self.instances
    get_list_of_resources.collect do |line|
      instance = get_resource_properties(line.split[0])
      new(instance)
    end
  end

  def create
    @property_flush[:ensure] = :present
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def destroy
    @property_flush[:ensure] = :absent
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  def flush
    Puppet.debug "property_flush: #{@property_flush.inspect}"
    if @property_flush[:ensure] == :absent
      # delete
      kubectl('delete', "namespaces/#{resource[:name]}")
    elsif @property_flush[:ensure] == :present
      # create
      file = Tempfile.new(['namespaces', '.yml'])
      file.write(<<-EOS)
apiVersion: v1
kind: Namespace
metadata:
  name: #{resource[:name]}
  labels:
    name: #{resource[:name]}
EOS
      file.close
      kubectl('create', '-f', file.path)
      file.unlink
    else
      #update
    end

    # Collect the resources again once they've been changed (that way `puppet
    # resource` will show the correct values after changes have been made).
    @property_hash = self.class.get_resource_properties(resource[:name])
  end

end
