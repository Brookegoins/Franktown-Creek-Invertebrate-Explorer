# app.R
# Sierra Nevada Headwater Stream Invertebrate Explorer

#Load zee packages
library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(DT)
library(scales)


# Import zee data
datum <- read_csv("data/bug_clean")

# convert to factors + make season + prettier reach labels
datum <- datum %>%
  mutate(
    source_of_production = as.factor(source_of_production),  
    method               = as.factor(method),                
    family               = as.factor(family),
    functional_group     = as.factor(functional_group),
    life_stage           = as.factor(life_stage),
    order                = as.factor(order),
    
    # season labels from sampling dates
    season = case_when(
      format(field_date, "%m") %in% c("06","07","08") ~ "Summer",
      format(field_date, "%m") %in% c("09","10","11") ~ "Fall",
      TRUE ~ "Other"
    ),
    
    # prettier reach labels
    reach_label = case_when(
      reach == 1 ~ "1 - Downstream",
      reach == 2 ~ "2 - Treatment",
      reach == 3 ~ "3 - Upstream",
      TRUE ~ as.character(reach)
    )
  )

################################################################
# userinterface "ui"
################################################################
ui <- fluidPage(
  
  titlePanel("Sierra Nevada Invertebrate Explorer"),
  
  sidebarLayout(
    
    sidebarPanel(
      width = 3,
      
      h4("Filters"),
      
      selectInput(
        "method",
        "Sampling Method",
        choices = c("All", levels(datum$method)),
        selected = "All"
      ),
      
      selectInput(
        "habitat",
        "Aquatic vs Terrestrial",
        choices = c("All", levels(datum$source_of_production)),
        selected = "All"
      ),
      
      selectInput(
        "season",
        "Season",
        choices = c("All", unique(datum$season)),
        selected = "All"
      ),
      
      selectInput(
        "reach",
        "Reach",
        choices = c("All", unique(datum$reach_label)),
        selected = "All"
      ),
      
      selectInput(
        "stage",
        "Life Stage",
        choices = c("All", levels(datum$life_stage)),
        selected = "All"
      ),
      
      selectInput(
        "feed",
        "Functional Feeding Group",
        choices = c("All", levels(datum$functional_group)),
        selected = "All"
      ),
      
      sliderInput(
        "len",
        "Body Length (mm)",
        min = floor(min(datum$length, na.rm = TRUE)),
        max = ceiling(max(datum$length, na.rm = TRUE)),
        value = c(
          floor(min(datum$length, na.rm = TRUE)),
          ceiling(max(datum$length, na.rm = TRUE))
        )
      )
    ),
    
    mainPanel(
      width = 9,
      
      tabsetPanel(
        #############
        #Making Tab 1 - Overview 
        #############
        tabPanel(
          "Overview",
          
          br(),
          
          fluidRow(
            column(3, wellPanel(
              h5("Total Specimens"),
              textOutput("n_total")
            )),
            
            column(3, wellPanel(
              h5("Families"),
              textOutput("n_family")
            )),
            
            column(3, wellPanel(
              h5("Mean Length"),
              textOutput("mean_len")
            )),
            
            column(3, wellPanel(
              h5("Aquatic %"),
              textOutput("aq_pct")
            ))
          ),
          
          br(),
          plotOutput("overview_bar", height = "400px")
        ),
        
        #############
        #Tab 2 - Taxa
        #############
        tabPanel(
          "Taxa",
          br(),
          plotOutput("family_plot", height = "500px")
        ),
        
        #############
        #Tab 3 - feeding groups
        #############
        tabPanel(
          "Feeding Groups",
          br(),
          plotOutput("feed_plot", height = "500px")
        ),
        
        #############
        # Tab 4 - body size
        #############
        tabPanel(
          "Body Size",
          br(),
          plotOutput("size_plot", height = "500px")
        ),
        
        #############
        # Tab 5 - data table
        #############
        tabPanel(
          "Data Table",
          br(),
          DTOutput("table")
        )
      )
    )
  )
)

###################################################
#Make that server man 
###################################################
server <- function(input, output, session) {
  
  #filtering
  filtered <- reactive({
    
    d <- datum
    
    if(input$method != "All"){
      d <- d %>% filter(method == input$method)
    }
    
    if(input$habitat != "All"){
      d <- d %>% filter(source_of_production == input$habitat)
    }
    
    if(input$season != "All"){
      d <- d %>% filter(season == input$season)
    }
    
    if(input$reach != "All"){
      d <- d %>% filter(reach_label == input$reach)
    }
    
    if(input$stage != "All"){
      d <- d %>% filter(life_stage == input$stage)
    }
    
    if(input$feed != "All"){
      d <- d %>% filter(functional_group == input$feed)
    }
    
    d <- d %>%
      filter(
        length >= input$len[1],
        length <= input$len[2]
      )
    
    d
  })
  
  ###################################################
  #summary time 😌
  ###################################################
  
  output$n_total <- renderText({
    nrow(filtered())
  })
  
  output$n_family <- renderText({
    n_distinct(filtered()$family)
  })
  
  output$mean_len <- renderText({
    paste0(round(mean(filtered()$length, na.rm = TRUE), 2), " mm")
  })
  
  output$aq_pct <- renderText({
    d <- filtered()
    pct <- mean(d$source_of_production == "Aquatic", na.rm = TRUE) * 100
    paste0(round(pct, 1), "%")
  })
  
  ###################################################
  #Tab 1 - 📊
  ###################################################
  
  output$overview_bar <- renderPlot({
    
    d <- filtered()
    
    ggplot(d, aes(method, fill = source_of_production)) +
      geom_bar(position = "dodge") +
      theme_classic(base_size = 14) +
      labs(
        x = "Sampling Method",
        y = "Count",
        fill = "Habitat"
      )
  })
  
  ###################################################
  #Tab 2 - 🐞
  ###################################################
  
  output$family_plot <- renderPlot({
    
    d <- filtered() %>%
      count(family, sort = TRUE) %>%
      slice_head(n = 15)
    
    ggplot(d, aes(reorder(family, n), n)) +
      geom_col(fill = "steelblue") +
      coord_flip() +
      theme_classic(base_size = 14) +
      labs(
        x = "Family",
        y = "Abundance"
      )
  })
  
  ###################################################
  #Tab - 3 🍔
  ###################################################
  
  output$feed_plot <- renderPlot({
    
    d <- filtered()
    
    ggplot(d, aes(method, fill = functional_group)) +
      geom_bar(position = "fill") +
      scale_y_continuous(labels = percent) +
      theme_classic(base_size = 14) +
      labs(
        x = "Method",
        y = "Proportion",
        fill = "Functional Group"
      )
  })
  
  ###################################################
  # Tab 4 - 🧍📏
  ###################################################
  
  output$size_plot <- renderPlot({
    
    d <- filtered()
    
    ggplot(d, aes(source_of_production, length, fill = source_of_production)) +
      geom_boxplot(alpha = 0.8) +
      theme_classic(base_size = 14) +
      labs(
        x = "Habitat Type",
        y = "Length (mm)"
      )
  })
  
  ###################################################
  # Tab 5 - 📉
  ###################################################
  
  output$table <- renderDT({
    datatable(filtered(), options = list(pageLength = 15))
  })
  
}

###################################################
#Runz zee app 
###################################################
shinyApp(ui, server)
