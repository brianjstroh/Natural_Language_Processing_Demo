# Natural Language Processing Demo
The purpose of this project was to satisfy the final requirements for the [Johns Hopkins University Data Science Specialization](https://www.coursera.org/specializations/jhu-data-science) capstone project.

This repository contains essential files for the development of my shiny NLP application.

The modeling approach is explained in detail in [Capstone_NLP_Presentation.Rmd](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/Capstone_NLP_Presentation.Rmd)

To replicate the model-building process, see the [Model_Dev.R](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/Model_Dev.R) and [contractions.csv](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/contractions.csv) files.

A quick visualization of the SwiftKey source data can be found in the [Capstone_Exploratory_Analysis.Rmd](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/Capstone_Exploratory_Analysis.Rmd) file.

[inidices1](https://github.com/brianjstroh/Natural_Language_Processing_Demo/raw/master/indices1) through [inidices10](https://github.com/brianjstroh/Natural_Language_Processing_Demo/raw/master/indices10), [my_contractions](https://github.com/brianjstroh/Natural_Language_Processing_Demo/raw/master/my_contractions) and [Predict_Next.R](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/Predict_Next.R) are the only needed files to run the NLP *predict_next10* function.
[server.R](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/server.R) and [ui.R](https://github.com/brianjstroh/Natural_Language_Processing_Demo/blob/master/server.R) utilize these files to build a user-friendly interface with which to use the *predict_next10* function.

**The shiny app can be found [*here*](https://bstroh.shinyapps.io/Predict_Next_NLP/).**
