## Server script

function(input, output){
  
  observeEvent(input$btn1, {
    ('select_var')
  })
  
  observeEvent(input$btn2, {
    show('select_var')
  })
  
  selected_df <- reactive({
    # req(input$select_var)
    gtd %>% 
      dplyr::select(input$select_var)
  })
  
  selected_df_period <- reactive({
    req(input$period)
    gtd %>% 
      filter(iyear >= input$period[1] & iyear <= input$period[2])
  })
  
  output$barplot <- renderPlot({
    req(input$fill)
    selected_df_period() %>% 
      ggplot(aes_string(x=selected_df_period()$iyear, fill=input$fill)) + geom_bar() + 
      labs(x="YEAR", 
           y= "COUNT",
           fill = "Region Name")
  })
  
  output$map_plot <- renderPlot({
    world <- world %>% filter(region != "Antarctica")
     world %>% 
       ggplot() + geom_map(map = world, 
                           aes(x=long, y=lat, map_id = region),
                           fill="white", colour = "black") + 
       geom_point(data = 
                    selected_df_period() %>% select(longitude, latitude) %>% na.omit(), 
                  aes(x=longitude, y=latitude), 
                  colour = "red", fill = "orange",
                  alpha = 0.2, size=0.4) +
      labs(x = "Longitude", y = "Latitude")
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(
      selected_df(),
      option =
        list(lengthMenu = c(5, 10, 50),
             pageLength = 5),
      rownames = FALSE
    )
  })
}