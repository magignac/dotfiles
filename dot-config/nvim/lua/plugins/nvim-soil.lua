return { 
    'javiorfo/nvim-soil',
    dependencies = { 'javiorfo/nvim-nyctophilia' },

    lazy = true,
    ft = "plantuml",
    opts = {
        actions = {
            redraw = true
        },

        -- If you want to use Plant UML jar version instead of the installed version
        -- puml_jar = "/usr/share/java/plantuml/plantuml.jar",
        
        image = {
            darkmode = false,
            format = "png",
            execute_to_open = function(img) 
                return "feh " .. img
            end
        }
    }
}
