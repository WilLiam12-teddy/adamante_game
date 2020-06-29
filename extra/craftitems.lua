-- extra mod
-- by dhausmig
-- consisting of many different things
---------------------------------------------------------------

if extra.oil_mod then
-- COTTONSEED OIL
   minetest.register_craftitem("extra:cottonseed_oil", {
      description = S("Oleo de semente de algodao"),
      inventory_image = "extra_cottonseed_oil.png",
      groups = {vessel = 1}
   })

   minetest.register_craftitem("extra:potato_crisps", {
      description = S("Batatas fritas"),
      inventory_image = "extra_potato_crisps.png",
      on_use = minetest.item_eat(2),
   })

   minetest.register_craftitem("extra:french_fries", {
      description = S("French Fries"),
      inventory_image = "extra_french_fries.png",
      on_use = minetest.item_eat(2),
   })

   minetest.register_craftitem("extra:onion_rings", {
      description = S("Aneis de cebola"),
      inventory_image = "extra_onion_rings.png",
      on_use = minetest.item_eat(3),
   })

   minetest.register_craftitem("extra:blooming_onion", {
      description = S("Cebola florescendo"),
      inventory_image = "extra_blooming_onion.png",
      on_use = minetest.item_eat(10),
   })

   minetest.register_craftitem("extra:fish_sticks", {
      description = S("Fish Sticks"),
      inventory_image = "extra_fish_sticks.png",
      on_use = minetest.item_eat(3),
   })
end

minetest.register_craftitem("extra:ground_meat", {
   description = S("Carne moida"),
   inventory_image = "extra_ground_meat.png",
   on_use = minetest.item_eat(4),
})

minetest.register_craftitem("extra:meat_patty", {
   description = S("Rissol de carne moida"),
   inventory_image = "extra_meat_patty.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craftitem("extra:grilled_patty", {
   description = S("Rissol de carne grelhada"),
   inventory_image = "extra_grilled_patty.png",
   on_use = minetest.item_eat(2),
})

minetest.register_craftitem("extra:tomato_slice", {
   description = S("Fatia de tomate"),
   inventory_image = "extra_tomato_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craftitem("extra:onion_slice", {
   description = S("Fatia de cebola"),
   inventory_image = "extra_onion_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craftitem("extra:potato_slice", {
   description = S("Fatia de batata"),
   inventory_image = "extra_potato_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craftitem("extra:hamburger", {
   description = S("Hamburger"),
   inventory_image = "extra_hamburger.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:cheeseburger", {
   description = S("Duplo Cheeseburger"),
   inventory_image = "extra_cheeseburger.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craftitem("extra:corn_dog_raw", {
   description = S("Cao de milho cru"),
   inventory_image = "extra_corn_dog_raw.png",
})

minetest.register_craftitem("extra:corn_dog", {
   description = S("Corn_dog"),
   inventory_image = "extra_corn_dog.png",
   on_use = minetest.item_eat(3, "default:stick"),
})

minetest.register_craftitem("extra:meatloaf_raw", {
   description = S("Bolo de carne crua"),
   inventory_image = "extra_meatloaf_raw.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:meatloaf", {
   description = S("Rolo de carne"),
   inventory_image = "extra_meatloaf.png",
   on_use = minetest.item_eat(5),
})

minetest.register_craftitem("extra:flour_tortilla", {
   description = S("Tortilla de farinha"),
   inventory_image = "extra_flour_tortilla.png",
   on_use = minetest.item_eat(1),
})

-- TACOS
minetest.register_craftitem("extra:taco", {
   description = S("Taco"),
   inventory_image = "extra_taco.png",
   on_use = minetest.item_eat(4),
})

minetest.register_craftitem("extra:super_taco", {
   description = S("Super Taco"),
   inventory_image = "extra_taco.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:quesadilla", {
   description = S("Quesadilla"),
   inventory_image = "extra_flour_tortilla.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:pasta", {
   description = S("Massa"),
   inventory_image = "extra_pasta.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craftitem("extra:pepperoni", {
   description = S("Pepperoni"),
   inventory_image = "extra_pepperoni.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craftitem("extra:garlic_dough", {
   description = S("Massa de pao de alho "),
   inventory_image = "extra_garlic_dough.png",
})

minetest.register_craftitem("extra:garlic_bread", {
   description = S("Pao de Alho"),
   inventory_image = "extra_garlic_bread.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:marinara", {
   description = S("Pote de molho Marinara"),
   inventory_image = "extra_marinara.png",
   groups = {vessel = 1},
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:spaghetti", {
   description = S("Spaghetti"),
   inventory_image = "extra_spaghetti.png",
   on_use = minetest.item_eat(3),
})

minetest.register_craftitem("extra:lasagna", {
   description = S("Lasanha"),
   inventory_image = "extra_lasagna.png",
   on_use = minetest.item_eat(4),
})

minetest.register_craftitem("extra:cheese_pizza", {
   description = S("Pizza de Queijo"),
   inventory_image = "extra_cheese_pizza.png",
   on_use = minetest.item_eat(3),
})

minetest.register_craftitem("extra:salsa", {
   description = S("Jarra de Salsa"),
   inventory_image = "extra_salsa.png",
   groups = {vessel = 1},
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("extra:pepperoni_pizza", {
   description = S("Pizza de Pepperoni"),
   inventory_image = "extra_pepperoni_pizza.png",
   on_use = minetest.item_eat(5),
})

minetest.register_craftitem("extra:deluxe_pizza", {
   description = S("Pizza Completa"),
   inventory_image = "extra_deluxe_pizza.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craftitem("extra:pineapple_pizza", {
   description = S("Pizza de Abacaxi"),
   inventory_image = "extra_pineapple_pizza.png",
   on_use = minetest.item_eat(5),
})

minetest.register_craftitem("extra:cornmeal", {
   description = S("Fuba"),
   inventory_image = "extra_cornmeal.png",
})

minetest.register_craftitem("extra:cornbread", {
   description = S("Pao de milho"),
   inventory_image = "extra_cornbread.png",
   on_use = minetest.item_eat(8),
})

