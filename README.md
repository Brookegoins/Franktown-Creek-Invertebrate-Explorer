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

Alderfly Megaloptera	Sialidae		Larvae	Predator	0.0037	2.753	
Ant	Hymenoptera	Formicidae		Adult	Unknown	0.56	1.56	
Aphid 	Hemiptera	Aphididae		Nymph	Piercer-herbivore	0.005	3.33	
Aquatic earthworm	Annelida	Oligochaeta		Adult	Collector-gatherer	0.008	1.888	
Biting midge	Diptera	Ceratopogonidae		Adult	Predator	0.1	1.57	
Biting midge	Diptera	Ceratopogonidae		Larvae	Predator	0.025	2.469	
Black fly	Diptera	Simuliidae		Adult	Collector-filterer	0.006	3.05	
Black fly	Diptera	Simuliidae		Larvae	Collector-filterer	0.002	3.011	
Northern casemaker caddisfly	Trichoptera	Limnephilidae		Larvae	Shredder	0.004	2.933	
Case maker caddisfly	Trichoptera	Uenoidae		Larvae	Scraper	0.0056	2.839	
Case maker caddisfly	Trichoptera	Lepidostomatidae		Larvae	Scraper	0.0079	2.649	
Common skimmer	Odonata	Libellulidae		Larvae	Predator	0.0078	2.792	Used Order for a, and b.
Cranefly	Diptera	Tipulidae		Larvae	Shredder	0.0029	2.681	
Darkling beetle	Coleoptera	Tenebrionidae		Adult	Detritivore	0.0513	2.669	
Darkling beetle	Coleoptera	Tenebrionidae		Larvae	Detritivore	0.0513	2.669	
Finger-net caddisfly	Trichoptera	Philopotomidae		Larvae	Collector-filterer	0.005	2.511	
Flat-headed mayfly	Ephemeroptera	Heptagenniidae		Nymph	Scaper	0.0108	2.754	
Free living caddisfly	Trichoptera	Rhyacophilidae		Larvae	Predator	0.0099	2.48	
Fungus nats and Gull midges	Diptera	Sciaridae		Larvae	Fungivore			
Giant stonefly	Plecoptera	Pteronarcyidae		Nymph	Shredder	0.0324	2.573	
Golden stonefly	Plecoptera	Perlidae		Nymph	Predator	0.0099	2.879	
Humpless case maker caddisfly	Trichoptera	Brachycentridae		Larvae	Shredder-collector	0.0083	2.818	
Leaf hopper	Hemiptera	Cicadellidae		Adult	Piercer-herbivore	0.0079	2.229	
Little brown stonefly	Plecoptera	Nemouridae		Nymph	Shredder	0.0056	2.762	
Little green stonefly	Plecoptera	Chloroperlidae		Nymph	Predator	0.0065	2.724	
Midge	Diptera	Chironomidae		Larvae	Collector-filterer	0.005098	2.32	
Midge	Diptera	Chironomidae		Adult	Collector-filterer	0.006	3.05	
Minute pirate bug	Hemiptera	Anthocoridae		Adult	Piercer-herbivore			
Mosquito	Diptera	Culicidae		Adult	Predator	0.006	3.035	
Moth fly	Diptera	Psychodidae	Maruini	Larvae	Detritivore	0.0025	2.692	
Nematode	Nemotoda	NA		Larvae	Predator	0.0758	0.75	
Net-spinner caddisfly	Trichoptera	Hydropsychidae		Larvae	Collector-filterer	0.0046	2.926	
Northern case-maker caddisfly	Trichoptera	Limnephilidae		Larvae	Shredder	0.004	2.933	
Pea clam	Mollusca	Bivalvia		Adult				
Prong-gilled mayfly	Ephemeroptera	Leptophlebiidae	Neoleptophlebia	Nymph	Collector-gatherer	0.0047	2.686	
Psyllid	Hemiptera	Psyllidae		Adult	Piercer-herbivore	0.0123	2.995	
Purse-case maker caddisfly	Trichoptera	Hydroptilidae		Larvae	Scraper	0.0056	2.839	
Riffle beetle	Coleoptera	Elmidae	Cleptelmis	Larvae	Collector-gatherer	0.152896	2.18	
Riffle beetle 	Coleoptera	Elmidae	Cleptelmis	Adult	Scraper	0.152896	2.18	
Roach-like stonefly	Plecoptera	Peltoperlidae		Larvae	Shredder	0.017	2.737	
Rolled-wing stonefly	Plecoptera	Leuctridae		Nymph	Shredder	0.0028	2.719	
Small minnow mayfly	Ephemeroptera	Baetidae		Larvae	Collector-gatherer	0.0053	2.87	
Spiny crawler mayfly	Ephemeroptera	Ephemerellidae	Drunella	Larvae	Collector-gatherer	0.0103	2.676	
Thrip	Thysanoptera	Thripidae		Adult	Piercer-herbivore	0.0071	2.537	
Vinegar and fruit fly	Diptera	Drosophilidae		Adult	Piercer-herbivore	0.0025	2.692	
Water mite	Arachnida	Hyrdachnidia		Adult	Predator-Scavanger	0.132655	1.66	
Water penny	Coleoptera	Psephenidae		Adult	Scraper	0.0123	2.906	
Water scavenger beetle	Coleoptera	Hydrophilidae		Adult	Collector-gatherer	0.0074	2.879	

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


