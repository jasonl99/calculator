html
  head
  link rel="stylesheet" type="text/css" href="/css/style.css"
  script src="/js/app.js"
  script
    == BasicCalc.javascript( context.session.id, nil)
  body
    == calculator.to_html
