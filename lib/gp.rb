module Gp
  require 'byebug'
  require 'gtk3'
  
  require 'gp/version'
  require 'gp/util/data'
  require 'gp/util/report'
  require 'gp/util/default'
  require 'gp/util/env'
  # This is your gem's load point. Require your components here.
  require 'gp/generator/koza_generator'
  require 'gp/generator/oogp_generator'
  require 'gp/koza/node'
  require 'gp/oogp/interface'
  require 'gp/oogp/program'
  require 'gp/ui/new_evo'
  require 'gp/ui/window'
  require 'gp/problem/indv'
  require 'gp/problem/tournament'
  require 'gp/problem/breeding'
  require 'gp/problem/problem'
  require 'gp/problem/regression/oogp'
  require 'gp/problem/regression/koza'
  require 'gp/problem/even-parity/koza'
  require 'gp/problem/even-parity/oogp'
  require 'gp/problem/art/art'
  require 'gp/commands/regression'
  require 'gp/commands/even-parity'
  require 'gp/commands/art'
  
end
