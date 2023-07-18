
## Suitability Plots
dir.create("./4_output/Plots and tables")

# Europe
my_col <- c("#ffffff", "#99d8c9", "#1e854b")
my_comp_type <- "rose"
my_comp_lable <- 3
my_comp_size <- 5
my_comp_pos <- c("right", "top")

final_res_curr <- rast("./4_output/Result/TODAY_Final_map.tif")
final_res_fut <- rast("./4_output/Result/FUTURE_Final_map.tif")
my_bbox <- matrix(c(-1275875, 4470206, 3696405, 7907273), byrow = F, nrow = 2) %>% bbox()

curr_fin <- tm_shape(final_res_curr[["final"]], bbox = my_bbox) + tm_raster(palette = my_col, title = "A) Current suitability") +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2)

fut_fin <- tm_shape(final_res_fut[["final"]], bbox = my_bbox) + tm_raster(palette = my_col, title = "B) Future suitability") +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2)

curr_std <- tm_shape(final_res_curr[["std"]], bbox = my_bbox) + tm_raster(style = "cont", palette = my_col, title = "C) Current prediction \nstandard deviation") +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2)

fut_std <- tm_shape(final_res_fut[["std"]], bbox = my_bbox) + tm_raster(style = "cont", palette = my_col, title = "D) Future prediction \nstandard deviation") +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_compass(type = my_comp_type, show.labels = my_comp_lable, size = my_comp_size, position = my_comp_pos)

tmap_arrange(
    curr_fin,
    fut_fin,
    curr_std,
    fut_std,
    nrow = 2
)


# Germany
final_res_curr <- rast("./4_output/Result/TODAY_Final_map_GERMANY.tif")
final_res_fut <- rast("./4_output/Result/FUTURE_Final_map_GERMANY.tif")

curr_fin <- tm_shape(final_res_curr[["final"]]) + tm_raster(palette = my_col, title = "A) Current suitability") +
    # tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2)

fut_fin <- tm_shape(final_res_fut[["final"]]) + tm_raster(palette = my_col, title = "B) Future suitability") +
    # tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2)

curr_std <- tm_shape(final_res_curr[["std"]]) + tm_raster(style = "cont", palette = my_col, title = "C) Current prediction \nstandard deviation") +
    # tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2)

fut_std <- tm_shape(final_res_fut[["std"]]) + tm_raster(style = "cont", palette = my_col, title = "D) Future prediction \nstandard deviation") +
    # tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2) +
    tm_compass(type = my_comp_type, show.labels = my_comp_lable, size = my_comp_size, position = my_comp_pos)

fut_fin_leg <- fut_fin + tm_layout(legend.only = T)

curr_std_leg <- curr_std + tm_layout(legend.only = T)





library(grid)

grid.newpage()
pushViewport(viewport(layout = grid.layout(nrow = 3, ncol = 3)))

print(
    curr_std + tm_layout(legend.only = T),
    vp = viewport(layout.pos.row = 1, layout.pos.col = 1)
)

print(
    fut_fin + tm_layout(legend.only = T),
    vp = viewport(layout.pos.row = 2, layout.pos.col = 1)
)

print(tmap_grob(curr_fin), vp = viewport(layout.pos.row = 1:2, layout.pos.col = 2:3))
print(curr_std, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(fut_fin, vp = viewport(layout.pos.row = 3, layout.pos.col = 2))
print(fut_std, vp = viewport(layout.pos.row = 3, layout.pos.col = 3))


Ger_arrange <- tmap_arrange(
    fut_fin,
    curr_std,
    fut_std,
    nrow = 1
)






## Predator Plots


wolf_overlap <- rast("./4_output/Predators/wolf_overlap.tif")

wolf_over <- tm_shape(wolf_overlap) + tm_raster(palette = my_col, title = "A) Wolf overlap") +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2) +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_compass(type = my_comp_type, show.labels = my_comp_lable, size = my_comp_size, position = my_comp_pos)

lynx_overlap <- rast("./4_output/Predators/lynx_overlap.tif")

lynx_over <- tm_shape(lynx_overlap) + tm_raster(palette = my_col, title = "B) Lynx overlap") +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2) +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_compass(type = my_comp_type, show.labels = my_comp_lable, size = my_comp_size, position = my_comp_pos)


fox_density <- rast("./4_output/Predators/Fox_density.tif")
fox_breaks <- c(0, 25, 50, 100, 200, 400, 800, Inf)

fox_dens <- tm_shape(fox_density) + tm_raster(palette = my_col, title = "C) Fox density", breaks = fox_breaks) +
    tm_shape(DE_districts$geometry[DE_districts$GF != 8]) + tm_borders(col = "black", lwd = 2) +
    tm_shape(AOI) + tm_borders(col = "black", lwd = 2) +
    tm_compass(type = my_comp_type, show.labels = my_comp_lable, size = my_comp_size, position = my_comp_pos)

tmap_arrange(
    wolf_over,
    lynx_over,
    fox_dens,
    nrow = 1
)
