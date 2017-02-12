module Calculator
  class BasicCalc < Lattice::Connected::StaticBuffer
    def on_event (event, sender)
      puts "#{self.class} #{event.event_type} #{event.dom_item} #{event.direction} #{event.message}"
    end
  end
end
