#' trackJR_clean
#' @description Track cleaning function to solve points in problems. Points selected will have the last previous correct position tracked.
#' @param trackJRgg The function need the trackJR_ggplot generated to select the point.
#'
#' @return The function return two object. A new data frame with points corrected at it previous frame for each point in problems. Also a data frame called "points_in_problem" is created.
#' @export
#'
#' @examples
#' #'mypathDirandFile<-"C:/Users/test/vid.mp4"
#'dataT<-trackJR(mypathDirandFile)
#'graf<-trackJR_ggplot(mypathDirandFile,dataT)
#'
#'new_dataT<-trackJR_clean(graf)
#'
trackJR_clean<-function (trackJRgg){

  cat("select points to solve")

  library(shiny)
  library(miniUI)
  ui=miniPage(
    tags$h1("Select points"),

    fluidRow(
      column(width = 7,
             actionButton("finish_close", "finish"),
             actionButton("exclude_toggle", "select points in problem"),
             plotOutput("plot", brush = "plot_brush", width = "90%", height = '400px'),
             )
    )

  )

  server=function(input, output, session) {
    graph<-trackJRgg[["data"]]

    vals <- reactiveValues(
      keeprows = rep(TRUE, nrow(graph))
    )

    output$plot <- renderPlot({

      exclude <-graph[!vals$keeprows, , drop = FALSE]

      trackJRgg + geom_point(data = exclude,col="red")
      })
    # Toggle points that are brushed, when button is clicked
    observeEvent(input$exclude_toggle, {
      res <- brushedPoints(trackJRgg[["data"]], input$plot_brush, allRows = TRUE)

      vals$keeprows <- xor(vals$keeprows, res$selected_)
    })

    selected<-reactive(input$plot_brush)

    observeEvent(input$plot_brush, {
      points_in_problem <-graph[!vals$keeprows, , drop = FALSE]
      assign("points_in_problem",points_in_problem,envir = .GlobalEnv)
    })

    observeEvent(input$finish_close, {
      stopApp()
    })
    }
  viewer <- paneViewer(200)
  runGadget(ui, server, viewer = viewer)

  datagg<-trackJRgg[["data"]]
  row.names(datagg)<-datagg$fr

    for( i in 1: nrow(datagg)){
    if(datagg$fr[i]%in%points_in_problem$fr){
      datagg[i,c(2:3)]<-datagg[i-1,c(2:3)]
    }
    }
  datanew<-datagg
  return(datanew)
  cat("a new object called 'points_in_problem' was created" )

  }


