minetest.register_tool("nitro_digger:nitro_digger", {

    description = "Nitro Digger",

    inventory_image = "nitro_digger.png",

    tool_capabilities = {

        full_punch_interval = 0,

        max_drop_level = 1,

        groupcaps = {

            cracky = {

		maxlevel = 3,

		uses = 900,

		times = { [1]=0.1, [2]=0.1, [3]=0.1 }	

	    },				

            crumbly = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.1, [2]=0.1, [3]=0.1 }

            },

            snappy = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.1, [2]=0.1, [3]=0.1 }

            },

	    choppy = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.15, [2]=0.15, [3]=0.15 }

            },

	    fleshy = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.1, [2]=0.1, [3]=0.1 }

            },

	   explody = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.1, [2]=0.1, [3]=0.1 }

            },

	    oddly_breakable_by_hand = {

                maxlevel = 3,

                uses = 900,

                times = { [1]=0.1, [2]=0.1, [3]=0.1 }

            },

        },

    },
})


local function check_protection(pos, name, text)

	if minetest.is_protected(pos, name) then

		return true

	end

	return false

end




minetest.register_craft({

    output = "nitro_digger:nitro_digger 1",

    recipe = {

        {"default:pick_diamond", "default:pick_diamond"                       },

        {"default:pick_diamond", "default:pick_diamond"},

        {"default:pick_diamond", "default:pick_diamond"}

    }

})
