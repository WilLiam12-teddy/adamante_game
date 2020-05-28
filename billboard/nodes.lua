--[[
    
        ***********************************************
        * Description of an Entry for the Billboards:  *
        ***********************************************
   
            {
                title = Name for the Billboard, 
                If no Name is given: default = bb_item1_item2_item3
                
                Recipe to craft:
                item1 = 1. Item for the recipe
                item2 = 2. Item for the recipe
                item3 = 3. Item for the recipe
                
                If an Item missed, default for:
                item1 = sign_wall_wood
                item2 = white
                item3 = white
            
                Size of the Billboard in Blocks
                scale = number
                If no scale is given, the default number is 1
            
                filename = Filename for the Image
                If no filename is given, the filename = bb_item1_item2_item3
            
                Typ of the taken Image (must be in textures):
                imgtyp = "Typ"
                If no Typ is given, the typ is png.
            
            }

--]]

boardlist = 
        {
            
            {  
                title = "TodoDia", 
                item1 = "green", 
                item2 = "white", 
                item3 = "white", 
                scale = 4.0, 
                filename = "tododia",
                imgtyp = "png" 
            },
            
            {  
                title = "Walmart", 
                item1 = "yellow", 
                item2 = "blue", 
                item3 = "white", 
                scale = 5.0, 
                filename = "walmart",
                imgtyp = "png" 
            },

            {  
                title = "TodoDiaBIG", 
                item1 = "yellow", 
                item2 = "green", 
                item3 = "white", 
                scale = 6.0, 
                filename = "tododiabig",
                imgtyp = "png" 
            },

    } -- bb_boardlist
