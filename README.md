# SwiftCharts-in-action

The goal of this repository is show features that can be developed through different user cases. At this point I will remark the feature where a chart can be used as input of data (chartOverlay is essencial). Functional programming is also used for manipulating collections of data.

Development was done following TDD hence all logic is validated by unitary tests.

Now, there are two screens. Each of one represents a different user case.

## Interactive stock evolution

This screen represents a user case where user plays a roll in a Supply Chain / Logistic deparment where it is the purchaser. Chart is a cascade bar type, colour shows an input or output of material. Stock level is seen at glance, user can update existing orders or place a new one. Standard procedure would imply select date in a field but I show how using chatOverlay the selection of date is seamless done after napping in the desired point-date. Two ways are developed.

I posted some time ago a video where everything can be seen working: https://www.linkedin.com/feed/update/urn:li:activity:7008369576413433856/

<img width="384" alt="Captura de Pantalla 2023-02-22 a las 10 19 54" src="https://user-images.githubusercontent.com/93383384/220576503-93f870b3-e8c9-44e9-a868-da0c8bf5d7e1.png">

Elecction of colours for the bars is not casual, instead taking mainstream combination red (outputs) & green (inputs) I chose blue instead of green for accesibility concerns with blindness.

Intensive use of funcional programming to manipulate the data.


## Sales

A basic screen where the last years sales of a company are displayed. The header of the chart shows the average sales for the las 4 years, but logic allows custom this scope easily (it's parameter we pass to the view); this average is calculated by functional programming.

<img width="416" alt="Captura de Pantalla 2023-02-22 a las 9 53 50" src="https://user-images.githubusercontent.com/93383384/220570290-01b63498-6ae0-4348-be18-26fb4e2b1f07.png">
