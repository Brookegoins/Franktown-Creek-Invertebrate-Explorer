# Franktown-Creek-Invertebrate-Explorer
Workflow for Processing and Analyzing Aquatic and Terrestrial Macroinvertebrate Communities in Franktown Creek

Project Overview

This repository contains a reproducible analytical workflow for processing and analyzing benthic macroinvertebrate data collected from Franktown Creek within Whittell Forest.
The project evaluates multiple dimensions of macroinvertebrate community structure, including:
- Taxonomic composition
- Abundance patterns
- Diversity metrics
- Functional feeding group distribution
- Biotic index calculations

The goal is to generate transparent, script-based analyses that produce publication-quality tables, figures, and spatial products while maintaining clear separation between raw data, processed data, and derived outputs.
All data cleaning, transformation, and analysis steps are conducted in R to ensure reproducibility and transparency.

Project Organization

The repository is organized to separate raw data, processed data, analytical scripts, and final outputs in a logical and reproducible structure.
The literature/ directory contains scientific articles, background materials, and reference documents relevant to macroinvertebrate ecology and study design.
The data_raw/ folder stores original datasets exactly as received or collected. These files remain unchanged to preserve data integrity.
The project_data/ directory contains cleaned and processed datasets used for analysis.
The metadata/ folder includes data dictionaries, field sampling protocols, and site-level metadata necessary for interpreting the datasets.
The scripts/ directory contains all R scripts used for importing, cleaning, analyzing, and visualizing data. Scripts are organized by analytical stage (e.g., data import and cleaning, exploratory analysis, diversity calculations, biotic index computation, visualization).
The outputs/ directory houses all derived products generated from analysis scripts. 
Within this folder:
- figures/ contains publication-quality plots and graphics.
- tables/ includes summary tables in CSV or Excel format.
- maps/ contains spatial and cartographic products, if applicable.
- The website/ folder contains files related to any interactive or web-based visualization components developed from the project.

File Naming Conventions

Scripts

Scripts are named according to their analytical purpose, for example:
- data_import_cleaning
- exploratory_analysis
- diversity_metrics
- biotic_index_calculations

Data Files

Processed datasets include descriptive identifiers and, when appropriate, year or version indicators, for example:
- master_invert_2026
- Outputs

Figures and tables are labeled by number and content:
- fig_5_abundance_estimation
- table_2_mean_metrics

Invertebrate ID Key

Order	Family	Genus	Functional Group	a	b
Megaloptera	Sialidae		Predator	0.003700000	2.753
Hymenoptera	Formicidae		Unknown	0.560000000	1.56
Hemiptera	Aphididae		Piercer-herbivore	0.005000000	3.33
Annelida	Oligochaeta		Collector-gatherer	0.008000000	1.888
Diptera	Empididae		Predator	0.006000000	3.05
Diptera	Ceratopogonidae		Predator	0.100000000	1.57
Diptera	Ceratopogonidae		Predator	0.025000000	2.469
Diptera	Simuliidae		Collector-filterer	0.006000000	3.05
Diptera	Simuliidae		Collector-filterer	0.002000000	3.011
Trichoptera	Uenoidae		Scraper	0.005600000	2.839
Trichoptera	Lepidostomatidae		Scraper	0.007900000	2.649
Odonata	Libellulidae		Predator	0.007800000	2.792
Diptera	Tipulidae		Shredder	0.002900000	2.681
Coleoptera	Chrysomelidae		Defoliator	0.025800000	3.083
Coleoptera	Tenebrionidae		Detritivore	0.051300000	2.669
Coleoptera	Tenebrionidae		Detritivore	0.051300000	2.669
Diptera	Dixidae		Collector-gatherer	0.002500000	2.692
Trichoptera	Philopotomidae		Collector-filterer	0.005000000	2.511
Ephemeroptera	Heptagenniidae		Scaper	0.010800000	2.754
Trichoptera	Rhyacophilidae		Predator	0.009900000	2.48
Diptera	Sciaridae		Fungivore	0.002500000	2.692
Plecoptera	Pteronarcyidae		Shredder	0.032400000	2.573
Plecoptera	Perlidae		Predator	0.009900000	2.879
Trichoptera	Brachycentridae		Shredder-collector	0.008300000	2.818
Hemiptera	Cicadellidae		Piercer-herbivore	0.007900000	2.229
Plecoptera	Nemouridae		Shredder	0.005600000	2.762
Plecoptera	Chloroperlidae		Predator	0.006500000	2.724
Diptera	Chironomidae		Collector-filterer	0.005097526	2.32
Diptera	Chironomidae		Collector-filterer	0.005097526	3.05
Hemiptera	Anthocoridae		Piercer-herbivore	0.034100000	2.688
Diptera	Culicidae		Predator	0.006000000	3.05
Diptera	Psychodidae	Maruini	Detritivore	0.002500000	2.692
Nemotoda	NA		Predator	0.075800000	0.75
Trichoptera	Hydropsychidae		Collector-filterer	0.004600000	2.926
Trichoptera	Limnephilidae		Shredder	0.004000000	2.933
Trichoptera	Limnephilidae		Shredder	0.004000000	2.933
Mollusca	Bivalvia				
Ephemeroptera	Leptophlebiidae	Neoleptophlebia	Collector-gatherer	0.004700000	2.686
Hemiptera	Psyllidae		Piercer-herbivore	0.012300000	2.995
Trichoptera	Hydroptilidae		Scraper	0.005600000	2.839
Coleoptera	Elmidae	Cleptelmis	Collector-gatherer	0.007400000	2.879
Coleoptera	Elmidae	Cleptelmis	Scraper	0.152895591	2.18
Plecoptera	Peltoperlidae		Shredder	0.017000000	2.737
Plecoptera	Leuctridae		Shredder	0.002800000	2.719
Trichoptera	Glossosomatidae		Scraper	0.008200000	2.958
Ephemeroptera	Baetidae		Collector-gatherer	0.005300000	2.87
Ephemeroptera	Ephemerellidae	Drunella	Collector-gatherer	0.010300000	2.676
Thysanoptera	Thripidae		Piercer-herbivore	0.007100000	2.537
Diptera	Drosophilidae		Piercer-herbivore	0.006000000	3.05
Arachnida	Hyrdachnidia		Predator-Scavanger	0.132655465	1.66
Coleoptera	Psephenidae		Scraper	0.012300000	2.906
Coleoptera	Hydrophilidae		Collector-gatherer	0.007400000	2.879
Coleoptera	Coccinellidae		Predator	0.033800000	2.162
Megaloptera	Corydalidae		Predator	0.003700000	2.873
Collembola	Isotomidae		Detritivore	0.005600000	2.809
Coleoptera	Dytiscidae 		Predator	0.152895591	2.18
Arachnida	Lycosidae		Predator	0.050000000	2.74
Hemiptera	Lygaeidae		Piercer-herbivore	0.034100000	2.688

Software Requirements

This workflow was developed using:
- R
- RStudio (recommended development environment)

Commonly used R packages may include (as applicable):
- tidyverse
- ggplot2
- vegan
- dplyr
- sf

Authors:
Brooke Goins 
University of Nevada, Reno

Jeff Falke
University of Nevada, Reno

Mark Kolwyck
University of Nevada, Reno

Tanner Morgan
University of Nevada, Reno
Contact Information

For questions regarding this repository or the Franktown Creek macroinvertebrate project, please contact:

Brooke Goins
University of Nevada, Reno
brookegoins@unr.edu


