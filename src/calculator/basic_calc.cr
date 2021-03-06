require "digest/sha1"

module Calculator

  # This is an RPN calculator (you enter both numbers then an operand)
  # there are also text commands (in value_entered) where future
  # expansion could happen.
  class BasicCalc < Lattice::Connected::ObjectList
    OPERATORS = {"plus": "+", "minus": "-", "divide": "/", "multiply": "*"}
    @max_items = 5

  
    def after_initialize
      (1..max_items).each {|i| items << ""}
      add_element_class "calculator"
      @items_dom_id = dom_id("items")
    end

    def content
      render "./src/calculator/calculator.slang"
    end

    # when the enter key is pressed on the calculate
    def value_entered( value : String)
      unary = %w(hex sqrt sin cos tan hex digest to_f to_c)
      if unary.includes? value
        case value
        when "digest"
          newval = Digest::SHA1.hexdigest(@items[@items.size-1].to_s)[0..15]
        when "sqrt"
          if (val = @items[@items.size-1].to_s.to_f?)
            newval = Math.sqrt(val).to_s
          end
        when "sin"
          if (val = @items[@items.size-1].to_s.to_f?)
            newval = Math.sqrt(val).to_s
          end
        when "cos"
          if (val = @items[@items.size-1].to_s.to_f?)
            newval = Math.cos(val).to_s
          end
        when "tan"
          if (val = @items[@items.size-1].to_s.to_f?)
            newval = Math.tan(val).to_s
          end
        end
      else
      end
      if newval
        #TODO create a #update_content with an index (-1 last, -2 second to last, etc)
        @items[@items.size-1] = newval.to_s
      else
        puts "Adding #{value}"
        add_content value
      end
    end

    def render_item(obj,index)
      render "./src/calculator/line.slang"
    end

    # a key was pressed in the input box
    def input( value : String, socket)
      operands = %w(+ - / *)
      # immediate calculation
      if operands.includes? value
        if (number = calculate(items.values[4],items.values[3],operator: value)) && socket
          act({"id"=>dom_id("form"), "action"=>"resetForm"},[socket.as(HTTP::WebSocket)])
        end
      end
      if value.size > 1 && value[0..-2].to_f? && operands.includes?(value[-1..-1])
      end
    end

    # Delete one of the rows of entries/results
    def delete_entry(row)
      (1..row).to_a.reverse.each do |idx|
        @items[idx] = @items[idx-1]
      end
      @items[0] = ""
      redraw_items
    end

    def button_pushed(component, index)
      case
      when index == "point"
        append_value({"id"=>dom_id("text-entry"),"value"=>"."}) if index == "point"
      when index
        append_value({"id"=>dom_id("text-entry"),"value"=>index.to_s}) if index
      end
    end

    def operator_pushed(component, index)
      puts "operator: #{component} #{index}"
      unless index == "del"
        calculate(items.values[4],items.values[3],operator: index)
      else
        # this send a command to remove a character from the input box
        act({"id"=>dom_id("text-entry"), "action"=>"chomp"})
      end
    end

    # the big one.  All events come in here.
    def on_event(event)

      action = event.action
      params = event.params
      component = event.component
      index = event.index

      case 
      when action == "click" && component && component.starts_with?("delete")
        delete_entry(index) if index
      when action == "click" && component && component.starts_with?("button")
        button_pushed component, component.split("-").last
      when action == "click" && component && component.starts_with?("operator")
        operator_pushed component, component.split("-").last
      when action == "input" && (socket = event.user.socket)
        input(value: params["value"].as(String), socket: socket)
      when "submit" && ( entry = params["entry"]? )
        puts "Submit: #{component}: #{entry.as(String)}"
        value_entered event.params["entry"].as(String)
        redraw_items
      else 
        puts "Unhandled Event #{action} #{params}"
      end

    end

    def redraw_items
      puts "Redrawing items".colorize(:black).on(:white)
      update({"id"=>items_dom_id.as(String), "value"=>item_content})
    end

    
    # given two strings and an operator, see if we can find an answer
    def calculate(string1, string2, operator)
      puts "Calc: #{string1} #{operator} #{string2}"
      if (num1 = string1.to_s.to_f?) && (num2 = string2.to_s.to_f?)
        result = case operator
        when "+", "plus"; num1 + num2
        when "-","subtract"; num1 - num2
        when "/", "divide"; num1 / num2
        when "*","multiply"; num1 * num2
        end
        @items 
        save = @items[0]
        @items << result.to_s
        @items[3] = @items[1]
        @items[2] = @items[0]
        @items[1] = save
        @items[0] = ""
        redraw_items
        result
      end
    end

  end
end
