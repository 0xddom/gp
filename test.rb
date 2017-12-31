require 'gp'

program = [
  [0, :mul, 0],
  [1, :mul, 1],
  [0, :add, 1]
]

program = Gp::OOGP::Program.new program

input = [2,3]

env = Gp::Environment.new(input.map{ |n| Gp::Problems::Regression::OOGP::MutableNumber.new(n) })
expected = env.vars.map(&:value).map {|x| x*x}.sum

data = Gp::DataContainer.new 0
puts env
program.eval_program env, data

puts "expected = " + expected.to_s
puts "data.get = " + data.get.to_s
puts expected == data.get

