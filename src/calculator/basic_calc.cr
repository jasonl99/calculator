module Calculator
  class BasicCalc < Lattice::Connected::StaticBuffer
    def on_event (event, sender)
      if event.direction == "In" && event.message_value("action") == "submit"
        val = event.message_value("params,entry").as(String)
        add_content val, dom_id("entries")
      end
      puts "#{self.class} #{event.event_type} #{event.dom_item} #{event.direction} #{event.message}"
    end
  end
end
