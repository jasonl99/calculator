div.display-rows data-component="items"
  - (0..4).each do |row|
    div.display-row data-component="delete-#{row}" data-events="click"
      span.delete Click to delete
      span.row-label = row
      span.data data-component="entry-#{row}" = items.values[row]?
div.display-row.input-row
  span.row-label 6
  span
    form.calc data-component="form" data-events="submit"
      input.calc-input autocomplete="off" autofocus="" name="entry" type="text" data-component="text-entry" data-event-attributes="class" data-events="input"
      input type="submit" style="visibility: hidden;"
div.buttons data-component="buttons" data-events="click"
  div.button-row
    div.button data-component="button-7" 7
    div.button data-component="button-8" 8
    div.button data-component="button-9" 9
    div.button.operator data-component="operator-divide" = "/"
  div.button-row
    div.button data-component="button-4" 4
    div.button data-component="button-5" 5
    div.button data-component="button-6" 6
    div.button.operator data-component="operator-multiply" = "*"

  div.button-row
    div.button data-component="button-1" 1
    div.button data-component="button-2" 2
    div.button data-component="button-3" 3
    div.button.operator data-component="operator-minus" = "-"

  div.button-row
    div.button data-component="button-point" .
    div.button data-component="button-0" 0
    div.button data-component="operator-del" del
    div.button.operator data-component="operator-plus" = "+"
  
