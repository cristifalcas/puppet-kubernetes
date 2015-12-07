Puppet::Type.type(:kubectl_secret).provide(:kubectl) do
  commands :kubectl => '/bin/kubectl'
  Puppet.debug "running kubectl_secret: #{self.inspect}"

#  apiVersion: v1
#  kind: Secret
#  metadata:
#    name: <%= @name %>-secret
#    annotations: 
#      kubernetes.io/<%= @type %>.name: <%= @name %>
#  type: kubernetes.io/<%= @type %>-token

#  apiVersion: v1
#  kind: Secret
#  metadata:
#    name: mysecret
#  type: Opaque
#  data:
#    password: dmFsdWUtMg0K
#    username: dmFsdWUtMQ0K
end
