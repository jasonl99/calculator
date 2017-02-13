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
    calculator = BasicCalc.find_or_create(name: calc).as(Lattice::Connected::StaticBuffer)
    render "./src/calculator/calculator.slang"
  end

  Kemal.run
end
