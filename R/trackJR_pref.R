#' trackJR_pref
#'
#' @param graf the ggplot plot generated with `trackJR_ggplot`
#' @param var_name the name added to the reference point.
#'
#' @return the reference points
#' @export
#'
#' @examples
#' it is used internally in `trackJR_refpoint`
trackJR_pref<-function (graf,var_name){


  library(shiny)
  library(miniUI)
  ui=miniPage(
    tags$h1("Create a Reference Point"),

    fluidRow(
      column(width = 7,
             actionButton("finish_close", "finish"),
             plotOutput("plot", click = clickOpts(id = "plot_click"), width = "90%", height = "400px"),
             verbatimTextOutput("click_info"),
      )
    )

  )

  server=function(input, output, session) {
    coordsref <- reactiveValues(xy=data.frame(x=c(0),  y=c(0)))

    observeEvent(input$plot_click, {
      coordsref$xy[1,] <- c(input$plot_click$x, input$plot_click$y)
    })



    output$plot <- renderPlot({
      graf + geom_point(data=coordsref$xy,aes(x=x,y=y),col=2)
    })

    observeEvent(input$finish_close, {
      assign(var_name, coordsref$xy,envir = .GlobalEnv)
      stopApp()

    })
  }
  viewer <- paneViewer(200)
  runGadget(ui, server, viewer = viewer)

}


