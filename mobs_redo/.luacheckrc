unused_args = false
allow_defined_top = true
max_line_length = 999

ignore = {
    "NS",
    "min",
    "damage_enabled",
    "node_fire",
    "node_permanent_flame",
    "vel",
    "pos",
    "ent",
    "new_line_of_sight",
    "direction",
    "yaw",
    "sheight",
    "self",
    "p1",
    "s",
    "dist",
    "p",
    "obj",
    "mob",
    "nod",
    "num",
    "punch_interval",
    "v",
    "name",
    "attach_at",
    "eye_offset",
    "new_velo",
    "rot_steer",
    "rot_view",
    "objs",
}

globals = {
    "minetest", "mobs",
    "default",
}

read_globals = {
    string = {fields = {"split", "trim"}},
    table = {fields = {"copy", "getn"}},

    "vector", "ItemStack", 
    "cmi", "tnt", "toolranks",

    "intllib", "lucky_block", "invisibility",
}
