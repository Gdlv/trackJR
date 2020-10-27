#' trackJR_box
#' @description A function to create a coordinates from a box draw in a trackJR_ggplot. While brushing in the plot a box you can move and drag the box until presh the "finish" bottom
#' @param trackJRgg A trackJR_ggplot.
#' @param var_name A character vector with the name of the box wanted (i.e. "box1")
#'
#' @return The function return the object named with the coordinates for the box or region of interest. A data.frame with one observation in four variables (xmin,xmax,ymin,ymax)
#' @export
#'
#' @examples
#' trackJR_box(graf2,"box1")
#' trackJR_box(graf2,"box2")
#' #Use it in a ggplot generated with trackJR_ggplot
#' graf2 + geom_rect(data = box1,mapping=aes(x=NULL,y=NULL,xmax=xmax,ymax=ymax,xmin=xmin,ymin=ymin),fill="red",alpha=0.5) +
#'         geom_rect(data = box2,mapping=aes(x=NULL,y=NULL,xmax=xmax,ymax=ymax,xmin=xmin,ymin=ymin),fill="green",alpha=0.5)


trackJR_box<-function (trackJRgg,var_name){


  library(shiny)
  library(miniUI)
  ui=miniPage(
    tags$h1("Create a Region of Interest"),

    fluidRow(
      column(width = 7,
             actionButton("finish_close", "finish"),
             plotOutput("plot", brush = "plot_brush", width = "90%", height = "400px"),
      )
    )

  )

  server=function(input, output, session) {

    output$plot <- renderPlot({
      namebox<-data.frame(xmin=input$plot_brush$"xmin",
                      ymin=input$plot_brush$"ymin",
                      xmax=input$plot_brush$"xmax",
                      ymax=input$plot_brush$"ymax")

      assign(var_name, namebox, envir = .GlobalEnv)


      trackJRgg + geom_rect(data = namebox,aes(x=NULL,y=NULL,xmin=input$plot_brush$"xmin",
                                              ymin=input$plot_brush$"ymin",
                                              xmax=input$plot_brush$"xmax",
                                              ymax=input$plot_brush$"ymax"),
                              fill="green",alpha=0.5)

        })
    observeEvent(input$finish_close, {
      stopApp()
    })
  }
  viewer <- paneViewer(200)
  runGadget(ui, server, viewer = viewer)
  }


