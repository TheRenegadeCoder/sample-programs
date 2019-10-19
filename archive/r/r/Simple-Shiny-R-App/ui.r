library(shiny)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Shiny Test App"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Specification of range within an interval ----
      sliderInput("range", "Year Range:",
                  min = 1990, max = 2019,
                  value = c(2003, 2017)),
      tags$hr(style="border-color: 4F5254;"),
      h3("Clinical Analyses"), 
      h3("CopyNumber Analyses"), 
      h3("Correlations Analyses"), 
      h3("miR Analyses"), 
      h3("miRseq Analyses"), 
      h3("mRNA Analyses"), 
      h3("mRNAseq Analyses"), 
      h3("Mutation Analyses"), 
      h3("Pathway Analyses"), 
      h3("RPPA Analyses"),
      tags$hr(style="border-color: 4F5254;"),
      fileInput("file","Upload the file", multiple = TRUE), # fileinput() function is used to get the file upload contorl option
      verbatimTextOutput("text"),
      uiOutput("selectfile"),
      helpText("Default max. file size is 5MB"),
      helpText("Select the read.table parameters below"),
      checkboxInput(inputId = 'header', label = 'Header', value = TRUE),
      checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),
      radioButtons(inputId = 'sep', label = 'Separator', choices = c(Columns=',', Spaces=' '), selected = ',')
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      uiOutput("tb")
      
    )
  )
)
  

  
  