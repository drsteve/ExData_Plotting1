require(ggplot2)
library(datasets)

sp_theme <- ggplot2::theme(panel.background = element_rect(fill = 'grey85'),
    panel.grid.major = element_line(colour = "white", size=1.25),
    axis.text = element_text(color="grey20", size=13),
    axis.title = element_text(color="grey20", size=13),
    axis.ticks = element_line(size = 1.0),
    panel.border = element_rect(fill=NA, size=0.75, colour = "grey20"))


fig <- ggplot2::ggplot(datasets::CO2, aes(conc,uptake)) + geom_point(colour='firebrick') + sp_theme
print(fig)

