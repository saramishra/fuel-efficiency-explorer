Fuel Efficiency Explorer
========================================================
subtitle: Classic cars, clear comparisons
author: Course project
date: October 2026
transition: none
font-family: Arial
css: pitch.css

An interactive Shiny app for exploring fuel efficiency and estimating trip fuel.

Built with R and the `mtcars` dataset.

A useful comparison starts with a clear question
========================================================

Which cars meet my engine and transmission preferences, and how much fuel would they use on the same trip?

- Compare 32 historical cars using familiar controls.
- See efficiency alongside vehicle weight.
- Turn miles per gallon into an understandable fuel quantity.

This is a learning tool using 1973-74 cars, not a guide to buying modern vehicles.

Filters turn the dataset into a useful shortlist
========================================================

1. Choose cylinders, transmission and an MPG range.
2. View the matching cars and their mean MPG.
3. Enter a trip distance to calculate each car's fuel use.
4. Export the results as CSV.

The chart and table react immediately. A built-in help tab explains every control, units, formulas and empty results.

A reproducible 300-mile example
========================================================

This R code runs when RStudio Presenter builds the slides.


``` r
car <- datasets::mtcars["Mazda RX4", ]
miles <- 300
data.frame(Car="Mazda RX4", MPG=car$mpg,
           Miles=miles, US_gallons=round(miles/car$mpg, 2))
```

```
##         Car MPG Miles US_gallons
## 1 Mazda RX4  21   300      14.29
```

Fuel = distance / MPG. Doubling the distance doubles the estimate.
The calculation assumes constant MPG throughout the trip.

An accessible way to explore data
========================================================

**Try it:** select 6 cylinders, Manual and a 300-mile trip. Compare the remaining cars, then double the distance.

**Why this app:** a filtered comparison, reactive chart, per-car fuel estimates and CSV export in one simple interface.

**Limits:** a small historical dataset, no causal claims, and no adjustment for road or driving conditions.

Source: R `datasets::mtcars` documentation, Motor Trend road tests (1974).
