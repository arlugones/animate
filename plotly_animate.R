# Load libraries
library(plotly)
library(ggplot2)

# Create the plot
p <- ggplot(mydf_filter, aes(fert, life, size = pop, color = continent, frame = year)) +
        geom_point()+ ylim(30,100)  + labs(x="Fertility Rate", y = "Life expectancy at birth (years)", color = 'Continent',size = "Population (millions)") + 
        scale_color_brewer(type = 'div', palette = 'Spectral')

# Generate the Visual and a HTML output
ggp <- ggplotly(p, height = 900, width = 900) %>%
        animation_opts(frame = 100,
                       easing = "linear",
                       redraw = FALSE)
ggp
htmlwidgets::saveWidget(ggp, "index.html")