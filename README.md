# Project Title: Ant Colony Optimization for Iraq Governorates

## Description
This project implements an Ant Colony Optimization (ACO) algorithm to determine the optimal path connecting the governorates of Iraq. The algorithm uses a dataset of 18 governorates, their coordinates, and an image of Iraq as the background for visualization. The results are displayed in a plotted map showing the shortest path calculated by the ACO.

## Features
- Visualization of Iraq's governorates using `ggplot2`.
- Integration of a background map image for better context.
- Implementation of the ACO algorithm to calculate the shortest path.
- Customizable parameters for ACO, including pheromone importance, distance importance, and evaporation rate.

## Technologies Used
- R
- Libraries:
  - `ggplot2`
  - `jpeg`
  - `grid`

## Files
- **`aco_project.R`**: Main script containing the implementation of ACO and visualization.
- **`governorates_data.csv`**: Contains the coordinates and names of the 18 governorates.
- **`iq-03.jpg`**: Background map image of Iraq.

## Setup and Usage

### Prerequisites
Ensure the following are installed on your system:
- R (Version 4.0 or higher)
- Required libraries: `ggplot2`, `jpeg`, `grid`

### Steps to Run
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/aco-iraq-governorates.git
   ```
2. Set your working directory to the project folder:
   ```bash
   setwd("path/to/project/folder")
   ```
3. Install the required libraries if not already installed:
   ```R
   install.packages("ggplot2")
   install.packages("jpeg")
   install.packages("grid")
   ```
4. Run the script:
   ```R
   source("aco_project.R")
   ```

### Output
The program will display a plot with the following:
- Red points representing the governorates.
- Names of the governorates labeled in bold text.
- A blue line showing the optimal path calculated by the ACO algorithm.

## Parameters
- **`n_ants`**: Number of ants used in the ACO algorithm.
- **`n_iterations`**: Number of iterations for the algorithm.
- **`alpha`**: Importance of pheromones.
- **`beta`**: Importance of distances.
- **`evaporation_rate`**: Rate at which pheromones evaporate.

These parameters can be adjusted in the script to experiment with the ACO behavior.

## Example
The script is preconfigured with example data for Iraq's governorates:
- X and Y coordinates for 18 cities.
- Background map located at `D:/iq-03.jpg` (adjust path as necessary).


## Author
[Mohammad Abbas Alkifaee](https://github.com/MohammedAlkifaee)

