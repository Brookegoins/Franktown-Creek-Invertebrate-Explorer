#Franktown-Creek-Invertebrate-Explorer

Interactive Shiny Dashboard for Macroinvertebrate Community Analysis in a Sierra Nevada Headwater Stream

Project Overview
The Franktown Creek Invertebrate Explorer is an interactive Shiny application designed to explore aquatic and terrestrial macroinvertebrate communities collected from Franktown Creek within Whittell Forest, a property own by the University of Nevada, Reno.
This tool supports exploratory ecological analysis by allowing users to dynamically filter, summarize, and visualize invertebrate community data across sampling methods, habitats, reaches, and seasons. Rather than producing static outputs, this application enables interactive investigation of community structure, functional composition, and spatial variation in a headwater stream system.
The dashboard is intended for use in ecological research, teaching, and exploratory/monitoring stream applications.

Research Context
Headwater stream ecosystems are highly sensitive to environmental change and provide important insights into biodiversity, food web structure, and ecosystem functioning. This project supports the analysis of macroinvertebrate communities across aquatic and terrestrial interfaces, with emphasis on how sampling method, reach, and habitat influence observed community structure.

Project Objectives
Scientific & Analytical Goals
Explore macroinvertebrate community structure across sampling methods (e.g., surber, drift nets, pan traps)
Compare community composition across stream reaches and habitats
Evaluate functional feeding group structure across spatial and environmental gradients
Examine body size distributions across taxa and sampling contexts
Provide a transparent interface for ecological exploration and hypothesis generation

R Programming
Modular data wrangling using dplyr
Reactive filtering pipeline within Shiny
Reusable transformations for ecological summaries
Dynamic Product
Fully interactive Shiny application
Real-time filtering of ecological data
Linked visualizations and summary statistics
Downloadable filtered datasets

Shiny Application Structure
The dashboard is organized into five interactive tabs:
🐛 Overview Dashboard
Total specimens
Number of families
Mean body size
Aquatic vs terrestrial proportions
Summary visualization of sampling method composition
🌎 Taxonomic Explorer
Family-level community composition
Reach-based comparisons
Summary statistics for selected taxa
🤲 Reach Comparisons
Richness and abundance by stream reach
Dominant families by reach
Spatial community differences
🕸 Functional Feeding Groups
Proportional representation of feeding guilds
Comparison across reaches
Ecosystem function interpretation
📊 Data Explorer & Downloads
Filtered raw dataset viewer
Exportable CSV downloads
Data transparency and validation tools

Data Sources
The dataset includes curated macroinvertebrate observations from Franktown Creek, including:
Aquatic benthic samples (Surber sampling)
Drift net collections
Terrestrial pan trap samples
Taxonomic identification (primarily family-level)
Functional feeding group assignments
Morphological measurements (body length)
Temporal sampling metadata (date, season)
Spatial metadata (reach classification)
All data are pre-processed to ensure consistency prior to integration into the Shiny application.
This tool is designed for:
Ecological data exploration and hypothesis generation
Stream ecology research and teaching
Comparative analysis of sampling methods
Undergraduate and graduate-level training in macroinvertebrate ecology
Long-term monitoring of headwater stream ecosystems

Authors
Brooke Goins
University of Nevada, Reno
Jeff Falke
University of Nevada, Reno
Mark Kolwyck
University of Nevada, Reno
Tanner Morgan
University of Nevada, Reno

Course Information
This project was developed for:
NRES 701B – Reproducible Data Science in Natural Resources
Spring Semester
The project demonstrates applied skills in:
R programming
Shiny application development
Data cleaning and transformation
Reproducible research workflows
Ecological data visualization

Contact
For questions about this project or the Shiny application:
Brooke Goins
University of Nevada, Reno
brookegoins@unr.edu