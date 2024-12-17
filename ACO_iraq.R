library(ggplot2)
library(jpeg)
library(grid)
library(httr)
plot_cities <- function(cities, image_path) {
  image <- readJPEG(image_path)  
  
  ggplot(cities, aes(x, y)) +
    annotation_custom(rasterGrob(image, 
                                 width = unit(1, "npc"), 
                                 height = unit(1, "npc")), 
                      -Inf, Inf, -Inf, Inf) + 
    geom_point(size = 3, color = "red") + 
    geom_text(aes(label = governorate), vjust = -1, color = "black", size = 4, fontface = "bold") +  # Add names below the cities
    labs(title = "ACO  افضل مسار بين المحافظات باستخدام ", x = "X محور", y = "Y محور") +
    xlim(0, 100) + 
    ylim(0, 100) +
    theme_minimal() +
    theme(panel.background = element_blank(),  
          plot.background = element_blank())  
}

cities <- data.frame(
  x = c(56, 65, 45, 50, 35, 47, 62, 53, 72, 80, 50, 42, 40, 18, 54, 63, 70, 90),  
  y = c(85, 75, 98, 72, 83, 67, 62, 52, 42, 32, 45, 35, 43, 45, 38, 27, 10, 14), 
  governorate = c("اربيل", "السليمانية", "دهوك", "كركوك", "الموصل",
                  "صلاح الدين", "ديالى", "بغداد", "واسط", "ميسان",
                  "بابل", "النجف الاشرف", "كربلاء", "الانبار", "القادسية", 
                  "ذي قار", "المثنى", "البصرة")  
)

dist_matrix <- as.matrix(dist(cities[, c("x", "y")]))

n_ants <- 10
n_iterations <- 100
alpha <- 1       
beta <- 2         
evaporation_rate <- 0.5
initial_pheromone <- 1
pheromones <- matrix(initial_pheromone, nrow = nrow(cities), ncol = nrow(cities))


best_path <- NULL
best_distance <- Inf

for (iter in 1:n_iterations) {
  paths <- list()
  distances <- numeric(n_ants)
  
  for (ant in 1:n_ants) {
    visited <- sample(1:nrow(cities), 1) 
    path <- visited
    while (length(path) < nrow(cities)) {
      remaining <- setdiff(1:nrow(cities), path) 
      

      pheromone_values <- pheromones[visited[length(visited)], remaining]
      distance_values <- 1 / dist_matrix[visited[length(visited)], remaining]
      
      cat("Ant:", ant, "Iteration:", iter, "\n")
      cat("Remaining cities:", remaining, "\n")
      cat("Pheromone values:", pheromone_values, "\n")
      cat("Distance values:", distance_values, "\n")
      cat("Length of remaining:", length(remaining), "\n")
      cat("Length of pheromone values:", length(pheromone_values), "\n")
      cat("Length of distance values:", length(distance_values), "\n")
      
      probs <- (pheromone_values^alpha) * (distance_values^beta)
      
      if (sum(probs) == 0) {
        probs <- rep(1 / length(remaining), length (remaining))  
      } else {
        probs <- probs / sum(probs)  
      }
      

      if (length(remaining) == 1) {
        next_city <- remaining 
      } else {
        next_city <- sample(remaining, 1, prob = probs)
      }
      
      path <- c(path, next_city)
    }
    path <- c(path, path[1]) 
    paths[[ant]] <- path
    distances[ant] <- sum(dist_matrix[cbind(path[-length(path)], path[-1])])
  }
  

  if (min(distances) < best_distance) {
    best_distance <- min(distances)
    best_path <- paths[[which.min(distances)]]
  }

  pheromones <- pheromones * (1 - evaporation_rate)  
  for (ant in 1:n_ants) {
    path <- paths[[ant]]
    for (i in seq_along(path)[-length(path)]) {
      pheromones[path[i], path[i+1]] <- pheromones[path[i], path[i+1]] + 1 / distances[ant]
    }
  }
}


best_path_df <- data.frame(
  x = cities$x[best_path],
  y = cities$y[best_path]
)
url <- "https://i.ibb.co/KKWLnKw/iq-03.jpg"
response <- GET(url)
img <- readJPEG(content(response, "raw"))
img_grob <- rasterGrob(img, 
                       width = unit(1, "npc"), 
                       height = unit(1, "npc"))
ggplot(cities, aes(x, y)) +
  annotation_custom(img_grob, 
                    xmin = -Inf, xmax = Inf, 
                    ymin = -Inf, ymax = Inf) +  
  geom_point(size = 3, color = "red") +
  geom_path(data = best_path_df, aes(x, y), color = "blue", linewidth = 1) +  
  labs(title = "ACO  افضل مسار بين المحافظات باستخدام ", x = "X محور", y = "Y محور") +
  theme_minimal() +
  geom_text(data = cities, aes(label = governorate), vjust = -1, color = "black", size = 4, fontface = "bold") +  # Add names below the cities
  xlim(0, 100) + 
  ylim(0, 100) + 
  theme(panel.background = element_blank(),  
        plot.background = element_blank()) 
