# require "kemal"
# require "kilt/slang"
require "colorize"
require "lattice-core"
require "./calculator/*"

Session.config do |config|
  Session.config.secret = "calculator secret xyz"
end

module Calculator

  get "/:calc" do |context|
    calc = context.params.url["calc"]
    puts "getting calculator #{calc}"
    calculator = BasicCalc.new(name: calc)
    render "./src/calculator/calculator.slang"
  end

  Kemal.run
end
