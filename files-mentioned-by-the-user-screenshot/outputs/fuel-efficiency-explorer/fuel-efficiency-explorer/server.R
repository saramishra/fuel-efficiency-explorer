library(shiny)

shinyServer(function(input, output, session) {
  filtered <- reactive({
    d <- datasets::mtcars
    d$model <- rownames(d)
    d <- d[d$cyl %in% as.numeric(input$cyl) &
             d$mpg >= input$mpg[1] & d$mpg <= input$mpg[2], , drop=FALSE]
    if (!is.null(input$am) && input$am != "all")
      d <- d[d$am == as.numeric(input$am), , drop=FALSE]
    d[order(-d$mpg, d$model), , drop=FALSE]
  })
  trip <- reactive({
    x <- input$distance
    validate(need(length(x) == 1 && is.finite(x) && x >= 0 && x <= 100000,
                  "Enter a distance between 0 and 100,000 miles."))
    x
  })
  results <- reactive({
    d <- filtered()
    validate(need(nrow(d) > 0, "No matching cars. Widen your filters or select a cylinder count."))
    data.frame(Model=d$model, Cylinders=d$cyl,
               Transmission=ifelse(d$am == 1, "Manual", "Automatic"),
               MPG=d$mpg, `Weight (1000 lb)`=d$wt,
               `Trip fuel (US gal)`=round(trip()/d$mpg, 2), check.names=FALSE)
  })
  output$summary <- renderText({
    d <- filtered()
    if (!nrow(d)) return("No matching cars. Widen your filters or select a cylinder count.")
    sprintf("%d matching cars | Mean MPG: %.2f | Best observed MPG: %.1f", nrow(d), mean(d$mpg), max(d$mpg))
  })
  output$plot <- renderPlot({
    d <- filtered()
    validate(need(nrow(d) > 0, "No matching cars to plot."))
    colors <- c(`4`="#117c83", `6`="#cf791b", `8`="#6954a2")
    par(mar=c(4.5,4.5,1,1))
    plot(d$wt, d$mpg, pch=19, cex=1.4, col=colors[as.character(d$cyl)],
         xlab="Weight (1,000 lb)", ylab="Miles per US gallon",
         xlim=range(mtcars$wt), ylim=c(10,35))
    legend("topright", legend=paste(c(4,6,8), "cylinders"), col=colors, pch=19, bty="n")
  })
  output$cars <- renderTable(results(), striped=TRUE, spacing="s", digits=2, rownames=FALSE)
  output$download <- downloadHandler(
    filename=function() "fuel-efficiency-cars.csv",
    content=function(file) write.csv(results(), file, row.names=FALSE)
  )
})
