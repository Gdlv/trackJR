# PARA EL BATCH
# SELECCIONAR LA CARPETA DE LOS VIDEOS
# SELECT THE COMMON POINT ON THE FIRST FRAME OF EACH VIDEO
# SELECT OR DRAW A MASK TO USE. POINTS OUTSIDE THE MASK WILL BE SAVED IN THE LIST - OUT OF RANGE-


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
             plotOutput("plot", brush = "plot_brush", width = "100%", height = '600px'),
             )
    )

  )

  server=function(input, output, session) {
    graph<-        trackJRgg[["data"]]

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
      points_in_problem <<-graph[!vals$keeprows, , drop = FALSE]
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
}


