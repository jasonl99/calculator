html
  head
  link rel="stylesheet" type="text/css" href="/css/style.css"
  script src="/js/app.js"
  script
    == BasicCalc.javascript( context.session.id, calculator)
  body
    div.calculator data-item=calculator.dom_id data-subscribe=""
      div.display-rows data-item=calculator.dom_id(%{entries})
        - (1..4).each do |row|
          div.display-row data-item=calculator.dom_id(%{row-#{row}})
            span.row-label =row
            span.data
      div.display-row
        span.row-label 6
        form.calc data-item=calculator.dom_id(%{form}) data-events="submit"
          input.calc-input name="entry" type="text" data-item=calculator.dom_id(%{text-entry}) data-event-attributes="class" data-events="input"
          input type="submit" style="visibility: hidden;"
      div.buttons data-item=calculator.dom_id(%{buttons}) data-events="click"
        div.button-row
          div.button data-item=calculator.dom_id(%{button-7}) 7
          div.button data-item=calculator.dom_id(%{button-8}) 8
          div.button data-item=calculator.dom_id(%{button-9}) 9
          div.button.operator data-item=calculator.dom_id(%{operator-divide}) = "/"
        div.button-row
          div.button data-item=calculator.dom_id(%{button-4}) 4
          div.button data-item=calculator.dom_id(%{button-5}) 5
          div.button data-item=calculator.dom_id(%{button-6}) 6
          div.button.operator data-item=calculator.dom_id(%{operator-multiply}) x

        div.button-row
          div.button data-item=calculator.dom_id(%{button-1}) 1
          div.button data-item=calculator.dom_id(%{button-2}) 2
          div.button data-item=calculator.dom_id(%{button-3}) 3
          div.button.operator data-item=calculator.dom_id(%{operator-minus}) -

        div.button-row
          div.button data-item=calculator.dom_id(%{button-point}) .
          div.button data-item=calculator.dom_id(%{button-0}) 0
          div.button data-item=calculator.dom_id(%{button-del}) del
          div.button.operator data-item=calculator.dom_id(%{operator-plus}) +
