# Crash Severity Prediction -  Asif Irfanullah Masum & Ifrat Zaman

# Load libraries
library("shiny")


intro_panel <- tabPanel(
  title = "Introduction",
  titlePanel("Introduction"),
  p(
    "Road traffic crashes are a significant public health issue and a major cause of death worldwide. According to some statistics, approximately 1.25 million people die and 50 million people are injured every year due to vehicular crashes [1]. The economic and social burden associated with these crashes is enormous, and the costs and consequences of the losses are significant. Therefore, it is essential to develop effective interventions to prevent, or at least minimize crash-related fatalities and injuries."
  ),
  p(
    "To address this issue, several government agencies, including police, health departments, and education institutions, have implemented many strategies to improve road safety. A few examples of these interventions are designing safer infrastructure, integrating road safety features in transport planning, improving vehicle safety features and driver behavior. These strategies are formulated using road traffic crash data sourced from various organizations."
  ),
  p(
    " One such crash data was used to devise a machine learning model to predict real-time crashes in freeway work zones [2]. The study compared Convolutional Neural Network and Binary Logistic Regression using crash and traffic data from several freeways in the Los Angeles region. The Convolutional Neural Network displayed promising results with a global accuracy of 79.50% in predicting these crashes. This study shows that machine learning techniques are revolutionizing the way crash datasets are analyzed and interpreted, providing potential insights to improve road safety and inform the development of more effective interventions and policies to prevent future accidents."
  ),
  p(
    "One potential area of improvement in road safety is predicting freeway crash injury severity based on a number of environmental and human factors. Accurate predictions can assist first responders and medical personnels to prioritize the most seriously injured victims and provide them with the necessary medical care. These predictions can also be used by local transportation agencies to identify hazardous conditions and strategize accordingly to avoid severe road crash incidents. Therefore, the proposed project aims to develop a machine learning model that predicts freeway crash injury severity using a crash dataset. By predicting injury severity, this model will provide valuable insights to improve post-crash care for victims of road crashes and help develop accurate diagnosis and remedial measures for road traffic operational problems."
  )
)
objective_panel <- tabPanel(
  title = "Project Objective",
  titlePanel("Project Objective"),
  p("The project is divided into two components:"),
  tags$ul(
    tags$li(
      "i. Creating a machine learning prediction model that predicts road crash injury severity based on environmental factors such as weather condition, lighting condition, and road condition"
    ),
    tags$li(
      "ii. Creating a machine learning prediction model that predicts road crash injury severity based on human factors such as alcohol and drug consumption, and hazardous actions taken by the driver"
    ),
  ),
  p(
    "The decision to divide the project into two separate components was based on the different end users of the models. For example, the first component can be used by local transportation agencies and police to take necessary precautions to make roads safer in suboptimal environmental conditions (like snowy road conditions and strong winds). The second component can be developed and deployed as a consumer application that predicts whether it is safe for an individual to drive based on a few Q&As within the application interface."
  ),
)

architecture_panel <-
  tabPanel(
    title = "Architecture and Methodology",
    titlePanel("Architecture and Methodology"),
    p(
      "Machine learning techniques will be implemented to complete this project. The following is a flowchart architecture for this project:"
    ),
    img(
      src = "flowchart.jpeg",
      height = 200,
      width = 1600
    ),
    tags$ul(
      tags$li(
        "Data Cleaning and Preprocessing: The first step of the project is to prepare the dataset for the rest of the sections. The dataset will be processed and cleaned to remove any irrelevant information and eliminate data discrepancies to ensure accurate data analysis. The dataset is checked for missing values, outliers, and errors. The clean dataset will be divided into two subsets, each with its respective feature variables; environmental factors subset and human factors subset."
      ),
      tags$li(
        "Data Exploration: This section will involve the analysis of the clean data to identify patterns and relationships between variables. This will be the majority part of the project since it is crucial to understand the effect of the feature variables in crash predictions. Most of this section will involve descriptive statistics and visualization techniques, like scatter plots, histograms, and correlation matrices. Furthermore, the dataset will be split into train and test sets to enable the evaluation of the machine learning model. "
      ),
      tags$li(
        "Model Training: Using the Multinomial Logistic Regression algorithm, the model will be trained using the cleaned, processed training dataset for each subset."
      ),
      tags$li(
        "Model Evaluation: Using the test dataset, the trained model will be evaluated in terms of accuracy scores."
      )
    )
  )

preprocessing_panel <- tabPanel(title = "Data Preprocessing",
                                titlePanel("Data Preprocessing"),
                                div(includeHTML("Data Preprocessing.html")))

exploration_panel <- tabPanel(
  title = "Data Exploration",
  titlePanel("Data Exploration"),
  selectInput(
    "factorType",
    "Select the factor type:",
    choices = c(
      "Natural Factor Subset",
      "Human Factor Subset"
    )
  ),
  uiOutput("selectVariable"),
  plotOutput("plot"),
  actionButton("injuryButton", "Show injured data only")
)

model_evaluation_panel <- tabPanel(title = "Model Evaluation",
                                   titlePanel("Model Evaluation"),
                                   div(includeHTML("Model Evaluation.html")))

conclusion_panel <- tabPanel(
  title = "Conclusion",
  titlePanel("Conclusion"),
  p(
    "In this project, a machine learning model was developed using the Multinomial Logistic Regression algorithm to predict freeway crash injury severity based on various environmental and human factors. The model achieved an accuracy score of 87.43% for the environmental factors subset whereas the accuracy score achieved for the human factors subset is 87.45%; therefore, demonstrating its potential to accurately predict the severity of freeway crashes and provide valuable insights to improve post-crash care for victims of road crashes. The results indicate that machine learning techniques can be used to analyze and interpret crash datasets effectively, providing insights to improve road safety and inform the development of more effective interventions and policies to prevent future accidents. By predicting injury severity, the model can assist first responders and medical personnel in prioritizing the most seriously injured victims and providing them with the necessary medical care.  In conclusion, this project highlights the potential of machine learning techniques in predicting freeway crash injury severity and improving road safety. Future work could involve exploring other machine learning algorithms and ensembling methods to further improve the accuracy and robustness of the model. Overall, this project has shown that machine learning techniques can play a vital role in enhancing road safety and saving lives."
  )
)

ui <- navbarPage(
  title = "Crash Severity Prediction",
  intro_panel,
  objective_panel,
  architecture_panel,
  preprocessing_panel,
  exploration_panel,
  model_evaluation_panel,
  conclusion_panel
)