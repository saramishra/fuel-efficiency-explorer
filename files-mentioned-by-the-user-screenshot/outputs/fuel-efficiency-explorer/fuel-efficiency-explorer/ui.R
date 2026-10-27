library(shiny)

shinyUI(fluidPage(
  tags$head(tags$style(HTML("body {background:#f5f8fb;color:#183047;} .container-fluid{max-width:1200px;} h1,h2,h3{color:#126b75;} .well{background:white;border-color:#dce6ec;} .tab-content{padding-top:20px;}"))),
  titlePanel("Fuel Efficiency Explorer"),
  p("Explore classic cars and estimate fuel for your next example trip."),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("cyl", "Cylinders", c(4, 6, 8), selected=c(4, 6, 8), inline=TRUE),
      selectInput("am", "Transmission", c("All"="all", "Automatic"="0", "Manual"="1")),
      sliderInput("mpg", "Fuel efficiency (miles per US gallon)", min=10, max=35, value=c(10,35), step=0.1),
      numericInput("distance", "Trip distance (miles)", value=300, min=0, max=100000, step=10),
      helpText("Filters update all results immediately. Trip distance updates the fuel estimates."),
      downloadButton("download", "Download matching cars")
    ),
    mainPanel(tabsetPanel(
      tabPanel("Explore", h3("Your selection"), textOutput("summary"),
               plotOutput("plot", height="360px"), h3("Cars and estimated trip fuel"),
               tableOutput("cars")),
      tabPanel("How to use",
        h3("Start here"),
        tags$ol(tags$li("Select one or more cylinder counts. Leave all checked to include all engines."),
                tags$li("Choose a transmission, or leave All selected."),
                tags$li("Move the MPG range handles to narrow the results."),
                tags$li("Enter a trip distance in miles. Read the estimated US gallons in the table."),
                tags$li("Download the filtered table as CSV if you want to keep it.")),
        h3("What the results mean"),
        p("Higher MPG means less fuel per mile. The chart compares MPG with vehicle weight in thousands of pounds. Each point is one matching car. The summary reports the number of matches and their arithmetic mean MPG."),
        p("For each car: trip fuel (US gallons) = trip distance (miles) / MPG. The table is sorted from highest to lowest MPG. Calculations use full precision and display two decimal places for fuel."),
        h3("An example"),
        p("Select 6 cylinders, Manual, and the full MPG range. At 300 miles, Mazda RX4 has 21 MPG and uses about 14.29 US gallons. Change the distance to 600 miles and fuel doubles to 28.57 gallons."),
        h3("No matches?"),
        p("Select at least one cylinder count, widen the MPG range, or choose All transmissions. Distance must be a finite number from 0 to 100,000 miles."),
        h3("Data and limitations"),
        p("Source: R's built-in datasets::mtcars, 32 automobiles from 1973-74 reported in the 1974 Motor Trend magazine. These historical observations are for learning, not modern vehicle recommendations. Trip estimates assume constant observed MPG and ignore traffic, terrain and driving conditions. Associations in this small dataset do not establish causation."),
        p("No upload or account is required to use this app. All documentation is included here.")
      )
    ))
  )
))
