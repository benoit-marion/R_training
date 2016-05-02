install.packages("plotly")
library(plotly)


a <- ggplot(r_list, aes(tv.cycle, crash_system.time , col = crash_process.name, shape = crash_effect)) +
  geom_point(alpha = 0.5) +
  facet_grid(session_deviceid ~ .,  scales = "free")

a <- ggplot(r_list, aes(tv.cycle, crash_system.time , col = crash_process.name, shape = crash_effect)) +
  geom_point(alpha = 0.5) +
  facet_grid(session_deviceid ~ .)

ggplot(r_list, aes(tv.cycle, crash_system.time, col = crash_process.name)) +
  geom_point(alpha = 0.5) +
  labs(title = "Test Devices crashes", x = "Time", y = "TV cycle") +
  facet_grid(session_deviceid ~ .)

ggplotly()


p <- ggplot(r_list, aes(tv.cycle, crash_system.time , col = crash_process.name, shape = crash_effect)) +
  geom_point(alpha = 0.5) +
  facet_grid(session_deviceid ~ .,  scales = "free_y") +
  theme(axis.text.x = element_text(size = 8),
       axis.text.y = element_text(size = 8))
ggplotly(p) %>% layout(showlegend = FALSE) 
  

r_list$id <- as.integer(r_list$session_deviceid)


f <- list(
  size = 10,
  color = "#7f7f7f")

y <- list(
  title = "System Time",
  titlefont = f,
  tickfont = f)

pl <- plot_ly(r_list, 
        x = tv.cycle, 
        y = crash_system.time,
#        color = crash_process.name,
        text = crash_process.name,
        shapes = crash_effect,
        opacity = 0.6,
        group = session_deviceid,
        yaxis = paste0("y", id), 
        mode = "markers")

subplot(pl) %>% layout(yaxis = y)

