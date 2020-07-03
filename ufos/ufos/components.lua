minetest.register_craftitem("ufos:steel_wire", {
	description = modUFO.translate("Steel Wire"),
	inventory_image = "obj_steel_wire_64.png",
})
minetest.register_craft({
	output = "ufos:steel_wire",
	recipe = {
		{"", 				"",		"default:steel_ingot"},
		{"", 						"default:diamond", 	""},
		{"default:steel_ingot", 	"", 					""}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:steel_spiral", {
	description = modUFO.translate("Steel Spiral"),
	inventory_image = "obj_steel_spiral_64.png",
})
minetest.register_craft({
	output = "ufos:steel_spiral",
	recipe = {
		{"ufos:steel_wire", "ufos:steel_wire", "ufos:steel_wire"},
		{"ufos:steel_wire", "ufos:steel_wire", "ufos:steel_wire"},
		{"ufos:steel_wire", "ufos:steel_wire", "ufos:steel_wire"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:eletric_lamp", {
	description = modUFO.translate("Eletric Lamp"),
	inventory_image = "obj_eletric_lamp_64.png",
})
minetest.register_craft({
	output = "ufos:eletric_lamp",
	recipe = {
		{"default:glass",		"default:glass", 				""},
		{"default:glass", 	"default:mese_crystal", 	"default:glass"},
		{"", 						"default:glass", 				"ufos:steel_spiral"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:gauge", {
	description = modUFO.translate("Gauge"),
	inventory_image = "obj_gauge_64.png",
})
minetest.register_craft({
	output = "ufos:gauge",
	recipe = {
		{"default:glass",		"default:glass", 			"default:stick"},
		{"default:glass", 	"default:steel_ingot", 	"default:glass"},
		{"default:glass", 	"default:glass",			"default:glass"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:cylinder", {
	description = modUFO.translate("Cylinder"),
	inventory_image = "obj_cylinder_64.png",
})
minetest.register_craft({
	output = "ufos:cylinder",
	recipe = {
		{"ufos:gauge",				"", 		""},
		{"default:steelblock", 	"", 		""},
		{"default:steelblock", 	"",		""}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:steel_pipe", {
	description = modUFO.translate("Steel Pipe"),
	inventory_image = "obj_steel_pipe_96.png",
})
minetest.register_craft({
	output = "ufos:steel_pipe",
	recipe = {
		{"default:steel_ingot",		"", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"",		"default:steel_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:steel_core", {
	description = modUFO.translate("Steel Core"),
	inventory_image = "obj_steel_core_64.png",
})
minetest.register_craft({
	output = "ufos:steel_core",
	recipe = {
		{"default:steel_ingot",		"default:steel_ingot", 		"default:steel_ingot"},
		{"",		 						"default:steelblock", 		""},
		{"default:steel_ingot", 	"default:steel_ingot",		"default:steel_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:copper_wire", {
	description = modUFO.translate("Copper Wire"),
	inventory_image = "obj_copper_wire_64.png",
})
minetest.register_craft({
	output = "ufos:copper_wire",
	recipe = {
		{"",				"",		 		"default:copper_ingot"},
		{"",				"default:copper_ingot", 	""},
		{"default:copper_ingot", 	"",				""}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:copper_coil", {
	description = modUFO.translate("Copper Coil"),
	inventory_image = "obj_copper_coil_64.png",
})
minetest.register_craft({
	output = "ufos:copper_coil",
	recipe = {
		{"ufos:copper_wire", 	"ufos:steel_core",	"ufos:copper_wire"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:eletric_pump", {
	description = modUFO.translate("Eletric Pump"),
	inventory_image = "obj_eletric_pump_64.png",
})
minetest.register_craft({
	output = "ufos:eletric_pump",
	recipe = {
		{"ufos:copper_wire",		"ufos:capacitor",			"ufos:steel_pipe"},
		{"ufos:switch_button",	"ufos:copper_coil",		"default:steelblock"},
		{"ufos:copper_wire",		"ufos:printed_circuit",	"ufos:steel_pipe"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:bioresin", {
	description = core.colorize("#00FF00", 
		modUFO.translate("Bioresin")
	)
	.."\n * "..modUFO.translate("Extracted from pine wood."),
	inventory_image = "obj_bioresin_16.png",
})
-- Dig 'ufos:bioresin' in 'default:pine_tree'
modUFO.addDrops("default:pine_tree", 1, 'default:pine_tree') -- rarity:1 = 1/1 = 100%
modUFO.addDrops("ufos:bioresin", 5, 'default:pine_tree') -- rarity:5 = 1/5 = 20%

--########################################################################################################################

minetest.register_craftitem("ufos:ionized_bioresin", {
	description = modUFO.translate("Ionized Bioresin"),
	inventory_image = "obj_ionized_bioresin_32.png",
})
minetest.register_craft({
	output = "ufos:ionized_bioresin 9",
	recipe = {
		{"ufos:bioresin",	"ufos:bioresin",			"ufos:bioresin"},
		{"ufos:bioresin", 	"default:mese_crystal_fragment", 	"ufos:bioresin"},
		{"ufos:bioresin", 	"ufos:bioresin",			"ufos:bioresin"}
	}
})




--########################################################################################################################

minetest.register_craftitem("ufos:bioplastic_mass", {
	description = modUFO.translate("Bioplastic Mass"),
	inventory_image = "obj_bioplastic_mass_16.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "ufos:bioplastic_mass",
	recipe = {"ufos:bioresin",	"default:coal_lump"}
})

--########################################################################################################################

minetest.register_craftitem("ufos:bioplastic_ingot", {
	description = modUFO.translate("Bioplastic Ingot"),
	inventory_image = "obj_bioplastic_ingot_16.png",
})
minetest.register_craft({
    type = "cooking",
    output = "ufos:bioplastic_ingot",
    recipe = "ufos:bioplastic_mass",
    cooktime = 10,
})

--########################################################################################################################

minetest.register_craftitem("ufos:speaker", {
	description = modUFO.translate("Speaker"),
	inventory_image = "obj_speaker_64.png",
})
minetest.register_craft({
	output = "ufos:speaker",
	recipe = {
		{"default:paper",	"ufos:bioplastic_ingot",	"ufos:bioplastic_ingot"},
		{"", 			"default:paper", 		"ufos:copper_coil"},
		{"default:paper", 	"ufos:bioplastic_ingot",	"ufos:bioplastic_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:printed_circuit", {
	description = modUFO.translate("Printed Circuit"),
	inventory_image = "obj_printed_circuit_96.png",
})
minetest.register_craft({
	output = "ufos:printed_circuit",
	recipe = {
		{"default:copper_ingot",	"ufos:bioplastic_ingot", 	"default:copper_ingot"},
		{"ufos:bioplastic_ingot", 	"default:copper_ingot", 	"ufos:bioplastic_ingot"},
		{"default:copper_ingot", 	"ufos:bioplastic_ingot",	"default:copper_ingot"}
	}
})


--########################################################################################################################

minetest.register_craftitem("ufos:oxigen_system", {
	description = modUFO.translate("Oxigen System"),
	inventory_image = "obj_oxigen_system_64.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "ufos:oxigen_system",
	recipe = {"ufos:cylinder",	"ufos:eletric_pump", 	"ufos:printed_circuit"}

})

--########################################################################################################################

minetest.register_craftitem("ufos:switch_button", {
	description = modUFO.translate("Switch Button"),
	inventory_image = "obj_switch_button_on_96.png",
})
minetest.register_craft({
	output = "ufos:switch_button",
	recipe = {
		{"default:steel_ingot",			"", 								""},
		{"ufos:bioplastic_ingot", 		"ufos:bioplastic_ingot", 	"ufos:bioplastic_ingot"},
		{"ufos:copper_wire", 			"default:copper_ingot",		"ufos:copper_wire"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:panel", {
	description = modUFO.translate("Panel"),
	inventory_image = "obj_panel_96.png",
})
minetest.register_craft({
	output = "ufos:panel",
	recipe = {
		{"ufos:gauge",					"ufos:gauge", 					"ufos:gauge"},
		{"ufos:switch_button", 		"ufos:switch_button", 		"ufos:switch_button"},
		{"ufos:speaker", 				"ufos:computer",				"default:key"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:pilot_manche", {
	description = modUFO.translate("Pilot Manche"),
	inventory_image = "obj_pilot_manche_96.png",
})
minetest.register_craft({
	output = "ufos:pilot_manche",
	recipe = {
		{"ufos:bioplastic_ingot",	"", 								"ufos:bioplastic_ingot"},
		{"default:steel_ingot", 	"default:steelblock", 		"default:steel_ingot"},
		{"", 								"default:steelblock",		""}
	}
})



--########################################################################################################################

minetest.register_craftitem("ufos:upholstered_chair", {
	description = modUFO.translate("Upholstered Chair"),
	inventory_image = "obj_upholstered_chair_96.png",
})
minetest.register_craft({
	output = "ufos:upholstered_chair",
	recipe = {
		{"",	"", 				"wool:red"},
		{"", 	"", 				"wool:red"},
		{"", 	"wool:red",		"default:steel_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:steel_ring", {
	description = modUFO.translate("Steel Ring"),
	inventory_image = "obj_steel_ring_32.png",
})
minetest.register_craft({
	output = "ufos:steel_ring",
	recipe = {
		{"",								"default:steel_ingot", 	""},
		{"default:steel_ingot", 	"",						 	"default:steel_ingot"},
		{"",							 	"default:steel_ingot",	""}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:copper_coil_toroidal", {
	description = modUFO.translate("Toroidal Copper Coil"),
	inventory_image = "obj_cooper_coil_toroidal_64.png",
})
minetest.register_craft({
	output = "ufos:copper_coil_toroidal",
	recipe = {
		{"ufos:copper_wire",		"ufos:copper_wire", 	"ufos:copper_wire"},
		{"ufos:copper_wire", 	"ufos:steel_ring", 	"ufos:copper_wire"},
		{"ufos:copper_wire", 	"ufos:copper_wire",	"ufos:copper_wire"}
	}
})


--########################################################################################################################

--[[
Microwave Resonance Chamber: 
 1 2 1	 ← 1 = Steel Ingot*
 1 3 1	 ← 2 = Copper Coil*
 1 2 1	 ← 3 = Mese Crystal*
--]]

minetest.register_craftitem("ufos:microwave_resonance_chamber", {
	description = modUFO.translate("Microwave Resonance Chamber"),
	inventory_image = "obj_microwave_resonance_chamber_96.png",
})
minetest.register_craft({
	output = "ufos:microwave_resonance_chamber",
	recipe = {
		{"default:steel_ingot",		"ufos:copper_coil",		 	"default:steel_ingot"},
		{"default:steel_ingot", 	"default:mese_crystal", 	"default:steel_ingot"},
		{"default:steel_ingot", 	"ufos:copper_coil",			"default:steel_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:emdrive", {
	description = core.colorize("#00FF00", 
		modUFO.translate("Emdrive")
	)
	.."\n * "..modUFO.translate(
		"Engine for producing impulse from an electromagnetic field within a cavity, without the need to eject mass."
	),
	inventory_image = "obj_emdrive_96.png",
})
minetest.register_craft({
	output = "ufos:emdrive",
	recipe = {
		{"default:steel_ingot",		"default:steel_ingot", 	"ufos:printed_circuit"},
		{"", 								"default:steel_ingot", 	"ufos:microwave_resonance_chamber"},
		{"default:steel_ingot", 	"default:steel_ingot",	"ufos:power_cell"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:cockpit", {
	description = modUFO.translate("Cockpit"),
	inventory_image = "obj_cockpit_128.png",
})

minetest.register_craft({
	output = "ufos:cockpit",
	recipe = {
		{"",							"", 							""},
		{"ufos:panel", 			"ufos:pilot_manche", 	"ufos:upholstered_chair"},
		{"default:steelblock", 	"default:steelblock",	"default:steelblock"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:microprocessor", {
	description = modUFO.translate("Microprocessor"),
	inventory_image = "obj_microprocessor_96.png",
})
minetest.register_craft({
	output = "ufos:microprocessor",
	recipe = {
		{"ufos:bioplastic_ingot",	"ufos:gold_wire",		"ufos:bioplastic_ingot"},
		{"ufos:bioplastic_ingot", 	"default:diamond",	"ufos:bioplastic_ingot"},
		{"ufos:bioplastic_ingot", 	"ufos:gold_wire",		"ufos:bioplastic_ingot"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:power_cell", {
	description = modUFO.translate("Power Cell (Type Omega)"),
	inventory_image = "obj_power_cell_96.png",
})
minetest.register_craft({
	output = "ufos:power_cell",
	recipe = {
		{"default:steelblock",		"default:steelblock", 		"default:steelblock"},
		{"ufos:batery", 				"ufos:batery", 				"ufos:batery"},
		{"default:diamondblock", 	"default:diamondblock",		"default:diamondblock"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:batery", {
	description = modUFO.translate("Batery (Type D)"),
	inventory_image = "obj_batery_96.png",
})
minetest.register_craft({
	output = "ufos:batery",
	recipe = {
		{"default:obsidian_glass",		"default:tin_ingot", 		"default:obsidian_glass"},
		{"default:obsidian_glass", 	"ufos:bioresin", 				"default:obsidian_glass"},
		{"default:obsidian_glass", 	"default:copper_ingot",		"default:obsidian_glass"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:resistance_electrical", {
	description = modUFO.translate("Electrical Resistance"),
	inventory_image = "obj_resistor_96.png",
})
minetest.register_craft({
	output = "ufos:resistance_electrical",
	recipe = {
		{"",								"ufos:bioplastic_ingot", 	"ufos:copper_wire"},
		{"ufos:bioplastic_ingot", 	"default:coalblock",			"ufos:bioplastic_ingot"},
		{"ufos:copper_wire", 		"ufos:bioplastic_ingot",	""}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:capacitor", {
	description = modUFO.translate("Capacitor"),
	inventory_image = "obj_capacitor_96.png",
})
minetest.register_craft({
	output = "ufos:capacitor",
	recipe = {
		{"ufos:bioplastic_ingot",	"default:paper", 	"ufos:bioplastic_ingot"},
		{"ufos:bioplastic_ingot", 	"default:paper", 	"ufos:bioplastic_ingot"},
		{"ufos:steel_wire", 			"",					"ufos:steel_wire"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:ram_memory", {
	description = modUFO.translate("RAM Memory"),
	inventory_image = "obj_ram_memory_96.png",
})
minetest.register_craft({
	output = "ufos:ram_memory",
	recipe = {
		{"ufos:switch_button",		"ufos:switch_button", 	"ufos:switch_button"},
		{"ufos:microprocessor", 	"ufos:microprocessor", 	"ufos:microprocessor"},
		{"ufos:printed_circuit", 	"ufos:printed_circuit",	"ufos:printed_circuit"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:gold_wire", {
	description = modUFO.translate("Gold Wire"),
	inventory_image = "obj_gold_wire_64.png",
})

minetest.register_craft({
	output = "ufos:gold_wire",
	recipe = {
		{"",							"",						 	"default:gold_ingot"},
		{"",					 		"default:gold_ingot", 	""},
		{"default:gold_ingot", 	"",							""}
	}
})


--########################################################################################################################

minetest.register_craftitem("ufos:dna_checker", {
	description = modUFO.translate("DNA Checker"),
	description = core.colorize("#00FF00", 
		modUFO.translate("DNA Checker")
	)
	.."\n * "..modUFO.translate(
		"It allows an electronic device to check its owner."
	),
	inventory_image = "obj_dna_checker_96.png",
})
minetest.register_craft({
	output = "ufos:dna_checker",
	recipe = {
		{"default:obsidian_glass",	"default:diamond", 				"default:obsidian_glass"},
		{"ufos:gold_wire", 			"ufos:copper_coil_toroidal",	"ufos:gold_wire"},
		{"ufos:printed_circuit", 	"ufos:printed_circuit",			"ufos:printed_circuit"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:computer", {
	description = core.colorize("#00FF00", 
		modUFO.translate("Computer")
	)
	.."\n * "..modUFO.translate(
		"An embedded system is a microprocessor system in which the computer is completely encapsulated or dedicated to the device or system it controls."
	),
	inventory_image = "obj_computer_128.png",
})
minetest.register_craft({
	output = "ufos:computer",
	recipe = {
		{"ufos:resistance_electrical",	"ufos:copper_coil_toroidal",		"ufos:capacitor"},
		{"ufos:dna_checker",				 	"ufos:microprocessor", 				"ufos:switch_button"},
		{"ufos:copper_wire",					"ufos:printed_circuit",				"ufos:ram_memory"}
	}
})

--########################################################################################################################

minetest.register_craft( {
	output = 'ufos:ship',
	recipe = {
		{ "", 							"default:glass", 		""},
		{ "default:glass", 			"ufos:cockpit", 		"default:glass"},
		{ "ufos:eletric_lamp", 		"ufos:emdrive", 		"ufos:oxigen_system"},
	},
})
--########################################################################################################################

minetest.register_craftitem("ufos:quartzo_crystal_pink", {
	description = modUFO.translate("Pink Quartzo Crystal"),
	inventory_image = "obj_quartzo_crystal_pink_64.png",
})
-- Dig 'ufos:quartzo_crystal_pink' in 'default:gravel'
modUFO.addDrops("ufos:quartzo_crystal_pink", 20, 'default:gravel') -- rarity:20 = 1/20 = 05%

--########################################################################################################################

minetest.register_craftitem("ufos:transistor", {
	description = modUFO.translate("Transistor"),
	inventory_image = "obj_transistor_96.png",
})

--[[
 * Transistor:
5 5 5	<- 1. Quartzo Crystal
3 1 4	<- 2. Copper Wire
2 x 2	<- 3. Capacitor
		<- 4. Electrical Resistance
		<- 5. Bioplastic Ingot
--]]

minetest.register_craft({
	output = "ufos:transistor",
	recipe = {
		{"ufos:bioplastic_ingot",	"ufos:bioplastic_ingot",		"ufos:bioplastic_ingot"},
		{"ufos:capacitor",			"ufos:quartzo_crystal_pink",	"ufos:resistance_electrical"},
		{"ufos:steel_wire",			"ufos:steel_wire",				"ufos:steel_wire"}
	}
})

--########################################################################################################################

minetest.register_craftitem("ufos:artif_inteligency", {
	description = core.colorize("#00FF00", 
		modUFO.translate("Upgrade - Artificial Inteligency")
	)
	.."\n * "..modUFO.translate("Allows to your UFO talk to you."),
	groups = {upgrades=1},
	inventory_image = "obj_artif_inteligency_96.png",
})

--[[
 * Upgrade - Artificial Inteligency: Allows to your UFO talk to you.
 1 2 1	<- 1. Toroidal Copper Coil
 3 4 5	<- 2. Horse Egg (If not exist mod "mobs_redo" do use a "Red Mushroom"
 6 7 8	<- 3. MicroProcessor
			<- 4. Diamond
			<- 5. Transistor
			<- 6. Capacitor
			<- 7. Bioplastic Ingot
 			<- 8. Electrical Resistance
--]]


minetest.register_craft({
	output = "ufos:artif_inteligency",
	recipe = {
		{"ufos:copper_coil_toroidal",		"flowers:mushroom_red",		"ufos:copper_coil_toroidal"},
		{"ufos:microprocessor",				"default:diamond",			"ufos:transistor"},
		{"ufos:capacitor",					"ufos:bioplastic_ingot",	"ufos:resistance_electrical"}
	}
})
--]]


--[[
minetest.register_craft({
	output = "ufos:xxxxxxxxxx",
	recipe = {
		{"",	"",	""},
		{"",	"",	""},
		{"",	"",	""}
	}
})
--]]
