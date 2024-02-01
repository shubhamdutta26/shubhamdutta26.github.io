library("rnaturalearth")
library("rnaturalearthdata")
library("sf")

world <- ne_countries(
  scale = "medium",
  returnclass = "sf"
)

new_world_countries <- c("Brazil", "Bolivia", "Colombia", "Peru", "Venezuela", 
                         "Ecuador", "Paraguay", "Mexico", "Panama", "Argentina",
                         "Costa Rica", "El Salvador", "Guatemala", "Honduras", 
                         "Nicaragua", "Panama", "Chile", "Uruguay")
regions <- world |>
  mutate(monkey_species = ifelse(sovereignt %in% new_world_countries,
                                 "new", 
                                 ifelse(continent %in% c("Asia", "Africa"),
                                        "old",
                                        "not applicable")))



map <- ggplot(data = regions) +
  geom_sf(aes(fill = monkey_species)) +
  scale_fill_manual(values = c("tomato1", "white", "seagreen")) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    #plot.background = element_rect(fill = "#F0EEEA", color = NA),
    panel.background = element_rect(fill = "lightblue2")
  )

ggsave(
  filename = "blogs/ntnhp/map.png",
  plot = map,
)
