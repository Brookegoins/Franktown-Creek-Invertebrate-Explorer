# app.R
# Sierra Nevada Headwater Stream Invertebrate Explorer

library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(DT)
library(scales)
library(bslib)
library(plotly)

# Load data
datum <- read_csv("data/bug_clean")

datum <- datum %>%
  mutate(
    source_of_production = factor(source_of_production),
    method = factor(method),
    family = factor(family),
    functional_group = factor(functional_group),
    life_stage = factor(life_stage),
    order = factor(order),
    field_date = as.Date(field_date),
    
    season = case_when(
      format(field_date, "%m") %in% c("06", "07", "08") ~ "🍃 Summer 2025",
      format(field_date, "%m") %in% c("09", "10", "11") ~ "🍂 Fall 2025",
      TRUE ~ "Other"
    ),
    
    reach_label = case_when(
      reach == 1 ~ "Downstream 🌳",
      reach == 2 ~ "Treatment ️☀️",
      reach == 3 ~ "Upstream 🌲",
      TRUE ~ as.character(reach)
    )
  )

# Total specimens
total_specimens <- nrow(datum)

ui <- fluidPage(
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#2C6E49"),
  
  titlePanel(
    div(
      style = "text-align:center;",
      h1("Franktown Creek Invertebrate Explorer"),
      h5("Ecology, Diversity, and Stream Health Dashboard")
    )
  ),
  
  sidebarLayout(
    
    sidebarPanel(
      width = 3,
      
      selectInput("method", "Sampling Method 🪳",
                  c("All", levels(datum$method))),
      
      selectInput("season", "Season 🌤️",
                  c("All", unique(datum$season))),
      
      selectInput("reach", "Reach 📍",
                  c("All", unique(datum$reach_label))),
      
      sliderInput(
        "len",
        "Body Length (mm)",
        min = floor(min(datum$length, na.rm = TRUE)),
        max = ceiling(max(datum$length, na.rm = TRUE)),
        value = range(datum$length, na.rm = TRUE)
      ),
      
      sliderInput(
        "specimen_n",
        "Total Number of Specimens",
        min = 1,
        max = total_specimens,
        value = c(1, total_specimens),
        step = 1
      )
    ),
    
    mainPanel(
      width = 9,
      
      tabsetPanel(
        
        tabPanel(
          "Overview 🐛🐞🦟",
          br(),
          
          fluidRow(
            style = "display:flex; flex-wrap:nowrap; justify-content:center; gap:8px; margin-bottom:12px;",
            
            column(2,
                   wellPanel(
                     style = "padding:10px; min-height:78px; text-align:center; background-color:#e8ffe8;",
                     h6("Specimens"),
                     h5(textOutput("n_total"))
                   )),
            
            column(2,
                   wellPanel(
                     style = "padding:10px; min-height:78px; text-align:center; background-color:#e8ffe8;",
                     h6("Families"),
                     h5(textOutput("n_family"))
                   )),
            
            column(2,
                   wellPanel(
                     style = "padding:10px; min-height:78px; text-align:center; background-color:#e8ffe8;",
                     h6("Aquatic %"),
                     h5(textOutput("aq_pct"))
                   )),
            
            column(2,
                   wellPanel(
                     style = "padding:10px; min-height:78px; text-align:center; background-color:#e8ffe8;",
                     h6("Terrestrial %"),
                     h5(textOutput("ter_pct"))
                   )),
            
            column(2,
                   wellPanel(
                     style = "padding:10px; min-height:78px; text-align:center; background-color:#e8ffe8;",
                     h6("Mean Length"),
                     h5(textOutput("mean_len"))
                   ))
          ),
          
          br(),
          plotlyOutput("overview_plot", height = "520px")
        ),
        
        tabPanel(
          "🌎 Explore Taxa",
          br(),
          
          selectInput(
            "chosen_family",
            "Choose Taxon",
            choices = sort(unique(as.character(datum$family)))
          ),
          
          plotOutput("taxon_plot", height = "350px"),
          tableOutput("taxon_stats")
        ),
        
        tabPanel(
          "🤲 Compare Reaches",
          br(),
          plotOutput("reach_plot", height = "450px"),
          br(),
          tableOutput("reach_table")
        ),
        
        tabPanel(
          "🕸 Food Web Roles️",
          br(),
          plotlyOutput("feed_plot", height = "450px")
        ),
        
        tabPanel(
          "📊 Data & Downloads",
          br(),
          downloadButton("download_data", "Download Filtered CSV"),
          br(),
          br(),
          DTOutput("table")
        ),
        
        tabPanel(
          "🔑 Family Key",
          br(),
          DTOutput("family_key")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  filtered <- reactive({
    
    d <- datum
    
    if (input$method != "All") {
      d <- filter(d, method == input$method)
    }
    
    if (input$season != "All") {
      d <- filter(d, season == input$season)
    }
    
    if (input$reach != "All") {
      d <- filter(d, reach_label == input$reach)
    }
    
    d <- d %>%
      filter(
        length >= input$len[1],
        length <= input$len[2]
      )
    
    d <- d %>%
      slice(1:min(input$specimen_n[2], n()))
    
    if (input$specimen_n[1] > 1) {
      d <- d %>%
        slice(input$specimen_n[1]:n())
    }
    
    d
  })
  
  output$n_total <- renderText(nrow(filtered()))
  
  output$n_family <- renderText(n_distinct(filtered()$family))
  
  output$mean_len <- renderText(
    paste0(round(mean(filtered()$length, na.rm = TRUE), 2), " mm")
  )
  
  output$aq_pct <- renderText(
    paste0(round(mean(filtered()$source_of_production ==
                        "Aquatic", na.rm = TRUE) * 100, 1), "%")
  )
  
  output$ter_pct <- renderText(
    paste0(round(mean(filtered()$source_of_production ==
                        "Terrestrial", na.rm = TRUE) * 100, 1), "%")
  )
  
  # OVERVIEW PLOTLY STACKED BAR
  output$overview_plot <- renderPlotly({
    
    p <- ggplot(
      filtered(),
      aes(
        x = method,
        fill = order,
        text = paste0(
          "Method: ", method,
          "<br>Order: ", order
        )
      )
    ) +
      geom_bar() +
      theme_classic(base_size = 14) +
      labs(
        title = "Specimens by Sampling Method",
        x = "Sampling Method",
        y = "Number of Specimens",
        fill = "Order"
      ) +
      theme(
        axis.text.x = element_text(angle = 25, hjust = 1)
      )
    
    ggplotly(p, tooltip = "text")
  })
  
  output$taxon_plot <- renderPlot({
    
    d <- filtered() %>%
      filter(as.character(family) == input$chosen_family) %>%
      count(reach_label)
    
    ggplot(d,
           aes(reach_label, n, fill = reach_label)) +
      geom_col() +
      theme_classic(base_size = 14) +
      labs(
        title = paste(input$chosen_family, "by Reach"),
        x = "Reach",
        y = "Count"
      )
  })
  
  output$taxon_stats <- renderTable({
    
    d <- filtered() %>%
      filter(as.character(family) == input$chosen_family)
    
    data.frame(
      Metric = c(
        "Records",
        "Mean Length",
        "Reaches Found",
        "Dominant Feeding Group"
      ),
      Value = c(
        nrow(d),
        round(mean(d$length, na.rm = TRUE), 2),
        n_distinct(d$reach_label),
        names(sort(table(d$functional_group), decreasing = TRUE))[1]
      )
    )
  })
  
  output$reach_plot <- renderPlot({
    
    d <- filtered() %>%
      group_by(reach_label) %>%
      summarise(
        Richness = n_distinct(family),
        Abundance = n(),
        .groups = "drop"
      )
    
    ggplot(d,
           aes(reach_label, Richness, fill = reach_label)) +
      geom_col() +
      theme_classic(base_size = 14) +
      labs(
        title = "Family Richness by Reach",
        x = "Reach",
        y = "Richness"
      )
  })
  
  output$reach_table <- renderTable({
    
    d <- filtered()
    
    dom <- d %>%
      count(reach_label, family, sort = TRUE) %>%
      group_by(reach_label) %>%
      slice_head(n = 3) %>%
      summarise(
        `Most Common Families` =
          paste(as.character(family), collapse = ", "),
        .groups = "drop"
      )
    
    dom %>%
      arrange(reach_label) %>%
      rename(Reach = reach_label)
  })
  
  output$feed_plot <- renderPlotly({
    
    # Build summary table first
    d <- filtered() %>%
      count(reach_label, functional_group) %>%
      group_by(reach_label) %>%
      mutate(
        proportion = n / sum(n),
        percent_lab = round(proportion * 100, 1)
      ) %>%
      ungroup()
    
    p <- ggplot(
      d,
      aes(
        x = reach_label,
        y = proportion,
        fill = functional_group,
        text = paste0(
          "Reach: ", reach_label,
          "<br>Group: ", functional_group,
          "<br>Count: ", n,
          "<br>Percent: ", percent_lab, "%"
        )
      )
    ) +
      geom_col() +
      scale_y_continuous(labels = percent) +
      theme_classic(base_size = 14) +
      labs(
        title = "Functional Feeding Groups by Reach",
        x = "Reach",
        y = "Proportion",
        fill = "Group"
      )
    
    ggplotly(p, tooltip = "text")
  })
  
  output$table <- renderDT({
    datatable(filtered(),
              options = list(
                pageLength = 15,
                scrollX = TRUE
              ))
  })
  
  output$download_data <- downloadHandler(
    filename = function() {
      "franktown_filtered_data.csv"
    },
    content = function(file) {
      write.csv(filtered(), file, row.names = FALSE)
    }
  )
  
  output$family_key <- renderDT({
    
    d <- filtered() %>%
      distinct(order, family,
               common_name_clean,
               functional_group) %>%
      arrange(order, family)
    
    datatable(d,
              options = list(
                pageLength = 15,
                scrollX = TRUE
              ))
  })
}

shinyApp(ui, server)
