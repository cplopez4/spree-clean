# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.



# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value
#server "llamazo.cloudapp.net", user: 'spree', port: 22, password: fetch(:password), roles: %w{web app db}

set :password, ask('Server password:', nil)

role :app, "llamazo.cloudapp.net"
role :web, "llamazo.cloudapp.net"
role :db,  "llamazo.cloudapp.net", :primary => true

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
server 'llamazo.cloudapp.net',
  user: 'llamazo',
  roles: %w{web app db},
  ssh_options: {
    user: 'llamazo', # overrides user setting above
    forward_agent: false,
    auth_methods: %w(password),
    password: 'Llamazo1101'
  }