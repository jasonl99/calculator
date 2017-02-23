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
    context.session.string("e","a1")
    user = Lattice::BasicUser.find_or_create(context.session.id)
    puts "User: #{user}"
    calc = context.params.url["calc"]
    calculator = BasicCalc.find_or_create(name: calc).as(Lattice::Connected::ObjectList)
    render "./src/calculator/page.slang"
  end

  Lattice::Core::Application.run
end
