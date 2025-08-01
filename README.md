# Crash Severity Prediction using R

This repository contains a machine learning project developed in R for predicting freeway crash severity using environmental and human-related crash data. It includes data preprocessing, modeling, and an interactive **R-Shiny application** for severity prediction.

## 🚗 Project Overview

Every year, thousands are killed or injured in road crashes. This project aims to:

- **Predict crash injury severity** based on environmental and human behavior factors
- **Assist first responders and transportation agencies** in identifying high-risk conditions
- **Explore ML models** like Support Vector Machine and Multinomial Logistic Regression

## 📊 Key Components

- **Data Source:** Michigan State Police crash records (2013–2017)
- **Models:** SVM, Logistic Regression
- **Tools:** R, R Shiny, tidyverse, caret
- **App:** Interactive web tool to simulate crash scenarios and view predicted severity

## 🛠 Folder Structure

```
app/             # Shiny app script
data/            # Raw and cleaned datasets
notebooks/       # HTML outputs of EDA and modeling
reports/         # Proposal and academic writeup
src/             # Custom utility R scripts
README.md        # Project overview
```

## 🚀 Shiny App Usage

To run the Shiny App locally:

```bash
git clone https://github.com/YOUR_USERNAME/crash-severity-prediction-r.git
cd crash-severity-prediction-r/app
# Open app.R in RStudio and click "Run App"
```

## 📁 Data Dictionary

See [MI_TCRS_DataDictionary.pdf](data/raw/) for full variable definitions used in modeling.

## 📈 Results

- Accuracy ranged between **XX%–YY%** depending on model and features used
- Human behavior factors (alcohol use, hazardous actions) had higher predictive power
- Environmental factors showed moderate correlation with severity

## 🧑‍💻 Team

- Ifrat Zaman
- Asif Irfanullah Masum

## 📄 License

This project is licensed under the MIT License.
