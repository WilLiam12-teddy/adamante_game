local id=terumet.id
local opts = terumet.options.vulcan

local crys_terumetal = terumet.register_crystal{
    suffix='raw',
    color='#a33d57',
    name='Crystallized Terumetal',
    cooking_result=id('ingot_raw')
}
terumet.register_vulcan_result(id('lump_raw'), crys_terumetal, nil, true) -- 4th arg indicates it is a terumetal specialized recipe
terumet.register_vulcan_result(id('ore_raw'),  crys_terumetal, 1, true)
terumet.register_vulcan_result(id('ore_raw_desert'), crys_terumetal, 2, true)

local crys_copper = terumet.register_crystal{
    suffix='copper',
    color='#ec923a',
    name='Crystallized Copper',
    cooking_result='default:copper_ingot'
}
terumet.register_vulcan_result('default:copper_lump', crys_copper)
terumet.register_vulcan_result('default:stone_with_copper',  crys_copper, 1)

local crys_tin = terumet.register_crystal{
    suffix='tin',
    color='#dddddd',
    name='Crystallized Tin',
    cooking_result='default:tin_ingot'
}
terumet.register_vulcan_result('default:tin_lump', crys_tin  )
terumet.register_vulcan_result('default:stone_with_tin', crys_tin, 1)

local crys_iron = terumet.register_crystal{
    suffix='iron',
    color='#ffdcb5',
    name='Crystallized Iron',
    cooking_result='default:steel_ingot'
}
terumet.register_vulcan_result('default:iron_lump', crys_iron)
terumet.register_vulcan_result('default:stone_with_iron', crys_iron, 1)

local crys_gold = terumet.register_crystal{
    suffix='gold',
    color='#ffcb15',
    name='Crystallized Gold',
    cooking_result='default:gold_ingot'
}
terumet.register_vulcan_result('default:gold_lump', crys_gold)
terumet.register_vulcan_result('default:stone_with_gold', crys_gold, 1)

local crys_ob = terumet.register_crystal{
    suffix='ob',
    color='#351569',
    name='Crystallized Obsidian',
    cooking_result='default:obsidian'
}
if opts.LIMIT_OBSIDIAN then
    terumet.register_vulcan_result('default:obsidian', crys_ob, -1)
else
    terumet.register_vulcan_result('default:obsidian', crys_ob)
end

local crys_mese = terumet.register_crystal{
    suffix='mese',
    color='#fffb81',
    name='Crystallized Mese',
    cooking_result='default:mese_crystal'
}
terumet.register_vulcan_result('default:stone_with_mese', crys_mese)

local crys_dia = terumet.register_crystal{
    suffix='dia',
    color='#66f6ff',
    name='Crystallized Diamond',
    cooking_result='default:diamond'
}
terumet.register_vulcan_result('default:stone_with_diamond', crys_dia)

-- outside mods can access ids of default crystallized materials through terumet.crystal_ids
terumet.crystal_ids = {
    terumetal=crys_terumetal,
    copper=crys_copper,
    tin=crys_tin,
    iron=crys_iron,
    gold=crys_gold,
    obsidian=crys_ob,
    mese=crys_mese,
    diamond=crys_dia
}
