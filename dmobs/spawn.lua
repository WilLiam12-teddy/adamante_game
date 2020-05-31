if dmobs.regulars then
	-- friendlies


	mobs:register_spawn("dmobs:hedgehog", {"default:dirt_with_grass","default:pine_needles"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:owl", {"default:leaves","default:tree"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:gnorm", {"default:dirt_with_grass","default:wood"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:tortoise", {"default:clay","default:sand"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:elephant", {"default:dirt_with_dry_grass","default:desert_sand"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:badger", {"default:dirt_with_grass","default:dirt"}, 20, 10, 15000, 2, 31000)
	mobs:register_spawn("dmobs:pig", {"default:pine_needles","default:leaves", "nyanland:cloudstone"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:panda", {"default:dirt_with_grass","ethereal:bamboo_dirt"}, 20, 10, 15000, 2, 31000)

	-- baddies

	mobs:register_spawn("dmobs:golem", {"default:stone"}, 7, 0, 16000, 2, 31000)
	mobs:register_spawn("dmobs:pig_evil", {"default:pine_needles","default:leaves"}, 20, 10, 32000, 2, 31000)
	mobs:register_spawn("dmobs:fox", {"default:dirt_with_grass","default:dirt"}, 20, 10, 32000, 2, 31000)

	if not dmobs.dragons then
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 15000, 2, 31000)
	else
		mobs:register_spawn("dmobs:orc", {"default:snow","default:snow_block", "default:desert_sand"}, 20, 10, 3500, 2, 31000)
		mobs:register_spawn("dmobs:ogre", {"default:snow","default:dirt_with_dry_grass", "default:desert_sand"}, 20, 10, 350, 2, 31000)
	end
	mobs:register_spawn("dmobs:treeman", {"default:leaves", "default:pine_needles"}, 7, 0, 16000, 2, 31000)
	mobs:register_spawn("dmobs:skeleton", {"default:stone"}, 7, 0, 16000, 2, 31000)
end

