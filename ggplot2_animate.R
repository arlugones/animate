# Load libraries
library(ggplot2)
library(gganimate)
library(gifski)
library(png)

# Add a global theme
theme_set(theme_grey()+ theme(legend.box.background = element_rect(),legend.box.margin = margin(6, 6, 6, 6)) )

# Create the plot with years as frame, limiting y axis from 30 years to 100
p <- ggplot(mydf_filter, aes(fert, life, size = pop, color = continent, frame = year)) +
        labs(x="Fertility Rate", y = "Life expectancy at birth (years)", caption = "(Based on data from Hans Rosling - gapminder.com)", color = 'Continent',size = "Population (millions)") + 
        ylim(30,100) +
        geom_point() +
        scale_color_brewer(type = 'div', palette = 'Spectral') + 
        # gganimate code
        ggtitle("Year: {frame_time}") +
        transition_time(year) +
        ease_aes("linear") +
        enter_fade() +
        exit_fade()

# animate
animate(p, width = 450, height = 450)

# save as a GIF
anim_save("output.gif")