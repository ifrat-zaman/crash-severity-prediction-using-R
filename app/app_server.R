# Crash Severity Prediction -  Asif Irfanullah Masum & Ifrat Zaman

library("shiny")
library(ggplot2)
library(gridExtra)

# Define a server function
server <- function(input, output) {
  crash_dataset <- read.csv("project_dataset.csv", header = TRUE)
  natural_factor_crash <-
    subset(
      crash_dataset,
      select = c(
        injy_svty_cd,
        wthr_cd,
        lit_cd,
        rd_cond_cd,
        mdot_regn_cd,
        invl_prty_key
      )
    )
  human_factor_crash <-
    subset(
      crash_dataset,
      select = c(
        injy_svty_cd,
        vehc_dfct_cd,
        rstr_not_used_fail,
        hzrd_actn_cd,
        alch_susp_ind,
        drug_susp_ind,
        invl_prty_key
      )
    )
  natural_factor_crash <- na.omit(natural_factor_crash)
  human_factor_crash <- na.omit(human_factor_crash)
  natural_factor_crash <- unique(natural_factor_crash)
  human_factor_crash <- unique(human_factor_crash)
  
  observeEvent(input$injuryButton, {
    show_only_injuries()
  })
  
  values <- reactiveValues(injuryButtonClicked = FALSE)
  
  # Modify the show_only_injuries function to set the flag when the button is clicked
  show_only_injuries <- function() {
    print("Show injured data only")
    values$injuryButtonClicked <- TRUE
  }
  
  variableChoices <- reactive({
    if (input$factorType == "Natural Factor Subset") {
      c(
        'Injury Severity',
        'Weather Condition',
        'Lighting Condition',
        'Road Condition',
        'MDOT Region'
      )
    } else {
      c(
        'Injury Severity',
        'Vehicle Defect',
        'Restraint Usage',
        'Hazardous Action',
        'Achohol Suspicion',
        'Drug Suspicion'
      )
    }
  })
  
  output$selectVariable <- renderUI({
    selectInput("select_variable",
                label = "Select a variable to show visualization:",
                choices = variableChoices())
  })
  
  output$plot <- renderPlot({
    if (!values$injuryButtonClicked) {   
      if (!is.null(input$select_variable) && input$select_variable == "Injury Severity") {
        if (input$factorType == "Natural Factor Subset") {
          ggplot(natural_factor_crash, aes(x = injy_svty_cd)) +
            geom_bar(color = "cyan", fill = "cyan") +
            labs(title = "Bar plot of Injury Severity Code (Only Injured)")
        } 
        else{
          ggplot(human_factor_crash, aes(x = injy_svty_cd)) +
            geom_bar(color = "cyan", fill = "cyan") +
            labs(title = "Bar plot of Injury Severity Code")
        }
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Weather Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = wthr_cd)) +
          geom_bar(color = "lightblue", fill = "lightblue") +
          labs(title = "Bar plot of Weather Code")
        
        scatter_plot <- ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd , y = wthr_cd),
            color = "lightblue",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Weather Code Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Lighting Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = lit_cd)) +
          geom_bar(color = "lightgreen",
                   fill = "lightgreen") +
          labs(title = "Bar plot of Lighting Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = lit_cd),
            color = "lightgreen",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Lighting Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Road Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = rd_cond_cd)) +
          geom_bar(color = "black", fill = "black") +
          labs(title = "Bar plot of Road Condition Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = rd_cond_cd),
            color = "black",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Road Condition Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "MDOT Region") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = mdot_regn_cd)) +
          geom_bar(color = "yellow", fill = "yellow") +
          labs(title = "Bar plot of MDOT Region Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = mdot_regn_cd),
            color = "yellow",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of MDOT Region Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Vehicle Defect") {
        bar_plot <- ggplot(human_factor_crash, aes(x = vehc_dfct_cd)) +
          geom_bar(color = "lightblue", fill = "lightblue") +
          labs(title = "Bar plot of Vehicle Defect Code")
        
        scatter_plot <- ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd , y = vehc_dfct_cd),
            color = "lightblue",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Vehicle Defect Code Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Restraint Usage") {
        bar_plot <-
          ggplot(human_factor_crash, aes(x = rstr_not_used_fail)) +
          geom_bar(color = "lightgreen",
                   fill = "lightgreen") +
          labs(title = "Bar plot of Restraint Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = rstr_not_used_fail),
            color = "lightgreen",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Restraint Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Hazardous Action") {
        bar_plot <- ggplot(human_factor_crash, aes(x = hzrd_actn_cd)) +
          geom_bar(color = "black", fill = "black") +
          labs(title = "Bar plot of Hazardous Action Code")
        
        scatter_plot <- ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = hzrd_actn_cd),
            color = "black",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Hazardous Action Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Achohol Suspicion") {
        bar_plot <- ggplot(human_factor_crash, aes(x = alch_susp_ind)) +
          geom_bar(color = "yellow", fill = "yellow") +
          labs(title = "Bar plot of Alcohol Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = alch_susp_ind),
            color = "yellow",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Alcohol Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Drug Suspicion") {
        bar_plot <- ggplot(human_factor_crash, aes(x = drug_susp_ind)) +
          geom_bar(color = "orange", fill = "orange") +
          labs(title = "Bar plot of Drugs Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = drug_susp_ind),
            color = "orange",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Drugs Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
    }
    else {
      natural_factor_crash <- natural_factor_crash[natural_factor_crash$injy_svty_cd != 5,]
      human_factor_crash <- human_factor_crash[human_factor_crash$injy_svty_cd != 5,]
      
      if (!is.null(input$select_variable) && input$select_variable == "Injury Severity") {
        if (input$factorType == "Natural Factor Subset") {
          ggplot(natural_factor_crash, aes(x = injy_svty_cd)) +
            geom_bar(color = "cyan", fill = "cyan") +
            labs(title = "Bar plot of Injury Severity Code (Only Injured)")
        } 
        else{
          ggplot(human_factor_crash, aes(x = injy_svty_cd)) +
            geom_bar(color = "cyan", fill = "cyan") +
            labs(title = "Bar plot of Injury Severity Code")
        }
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Weather Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = wthr_cd)) +
          geom_bar(color = "lightblue", fill = "lightblue") +
          labs(title = "Bar plot of Weather Code")
        
        scatter_plot <- ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd , y = wthr_cd),
            color = "lightblue",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Weather Code Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Lighting Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = lit_cd)) +
          geom_bar(color = "lightgreen",
                   fill = "lightgreen") +
          labs(title = "Bar plot of Lighting Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = lit_cd),
            color = "lightgreen",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Lighting Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Road Condition") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = rd_cond_cd)) +
          geom_bar(color = "black", fill = "black") +
          labs(title = "Bar plot of Road Condition Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = rd_cond_cd),
            color = "black",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Road Condition Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "MDOT Region") {
        bar_plot <- ggplot(natural_factor_crash, aes(x = mdot_regn_cd)) +
          geom_bar(color = "yellow", fill = "yellow") +
          labs(title = "Bar plot of MDOT Region Code")
        
        scatter_plot <-   ggplot(data = natural_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = mdot_regn_cd),
            color = "yellow",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of MDOT Region Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Vehicle Defect") {
        bar_plot <- ggplot(human_factor_crash, aes(x = vehc_dfct_cd)) +
          geom_bar(color = "lightblue", fill = "lightblue") +
          labs(title = "Bar plot of Vehicle Defect Code")
        
        scatter_plot <- ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd , y = vehc_dfct_cd),
            color = "lightblue",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Vehicle Defect Code Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Restraint Usage") {
        bar_plot <-
          ggplot(human_factor_crash, aes(x = rstr_not_used_fail)) +
          geom_bar(color = "lightgreen",
                   fill = "lightgreen") +
          labs(title = "Bar plot of Restraint Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = rstr_not_used_fail),
            color = "lightgreen",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Restraint Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Hazardous Action") {
        bar_plot <- ggplot(human_factor_crash, aes(x = hzrd_actn_cd)) +
          geom_bar(color = "black", fill = "black") +
          labs(title = "Bar plot of Hazardous Action Code")
        
        scatter_plot <- ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = hzrd_actn_cd),
            color = "black",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Hazardous Action Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Achohol Suspicion") {
        bar_plot <- ggplot(human_factor_crash, aes(x = alch_susp_ind)) +
          geom_bar(color = "yellow", fill = "yellow") +
          labs(title = "Bar plot of Alcohol Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = alch_susp_ind),
            color = "yellow",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Alcohol Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
      else if (!is.null(input$select_variable) && input$select_variable == "Drug Suspicion") {
        bar_plot <- ggplot(human_factor_crash, aes(x = drug_susp_ind)) +
          geom_bar(color = "orange", fill = "orange") +
          labs(title = "Bar plot of Drugs Usage Code")
        
        scatter_plot <-   ggplot(data = human_factor_crash) +
          geom_point(
            mapping = aes(x = injy_svty_cd, y = drug_susp_ind),
            color = "orange",
            position = "jitter"
          ) +
          labs(title = "Scatter plot of Drugs Usage Code vs. Injury Severity Code")
        
        grid.arrange(bar_plot, scatter_plot, ncol = 2)
      }
    }
  })
}
