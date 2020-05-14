modCorreio.openpapermail = function(playername)
	--if player~=nil and player:is_player() then
	if type(playername)=="string" and playername~="" then
		--local playername = player:get_player_name()
		if modCorreio.mailbox[playername]==nil then
			modCorreio.mailbox[playername] = { }
			modCorreio.mailbox[playername].selmail = 0
		end
		
		local formspecmails = modCorreio.get_formspecmails(playername)
		--print("formspecmails = "..formspecmails)
		local formspec = "size[8,7.5]"
		.."image[2.2,0.0;0.7,0.7;obj_mail.png]"
		.."label[2.75,0;"..minetest.formspec_escape(modCorreio.translate("MAIL LETTER")).."]"
		.."field[0.5,1.0;7.7,1.0;toplayer;"..minetest.formspec_escape(modCorreio.translate("Addressee"))..":;]"
		.."textarea[0.5,2.0;7.7,5.5;message;"..minetest.formspec_escape(modCorreio.translate("Message"))..":;]"
		.."button_exit[3.5,7;1.5,0.5;sendmail;"..minetest.formspec_escape(modCorreio.translate("SEND")).."]"
		
		minetest.show_formspec(playername,"modCorreio.mailmessage",formspec)
	end
end

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "modCorreio.mailmessage"  then
		local sendername = sender:get_player_name()
		--print()
		minetest.log('action',"[modCorreio] fields = "..dump(fields))
		if fields.sendmail then
			if fields.toplayer~=nil and type(fields.toplayer)=="string" and fields.toplayer~="" then
				if fields.message~=nil and type(fields.message)=="string" and fields.message~="" then
					local carta = modCorreio.set_mail(sendername, fields.toplayer, fields.message)
					if carta~=nil then
						local itemWielded = sender:get_wielded_item()
						if itemWielded:get_name()=="correio:papermail" 
							and not core.setting_getbool("creative_mode")
						then
							itemWielded:take_item()
							sender:set_wielded_item(itemWielded)
						end
						--minetest.show_formspec(sendername,"","size[5,1]label[0,0;Sua mensagem foi enviada com sucesso!]") --Infelizmente nao existe metodo para fechar formspec.
						minetest.chat_send_player(sendername, modCorreio.translate("Your message has been sent successfully!"))
					else
						minetest.chat_send_player(sendername, modCorreio.translate("There was an unexpected crash while sending your message! (Please contact the mod's developer mod 'CORREIO'!)"))
					end
				else
					minetest.chat_send_player(sendername, modCorreio.translate("Please enter a message before sending your letter!"))
				end
			else
				minetest.chat_send_player(sendername, modCorreio.translate("Please enter the exact name of the player who received your letter!"))
			end
		end
	end
end)

minetest.register_craftitem("correio:papermail", {
	description = modCorreio.translate("Letter of Mail (Send a letter to other player)"),
	inventory_image = "obj_mail.png",
	--stack_max=16, --Acumula 16 por slot
	groups = { letter=1, mail=1 },
	on_use = function(itemstack, user, pointed_thing)
		modCorreio.openpapermail(user:get_player_name())
	end,
})

if minetest.get_modpath("lunomobs") then
	minetest.register_craft({
		output = 'correio:papermail 4',
		recipe = {
			{"lunomobs:feather"},
			{"group:dye"}, --{"dye:violet"},
			{"default:paper"},
		}
	})
else
	minetest.register_craft({
		output = 'correio:papermail 4',
		recipe = {
			{"default:stick"}, --{"lunorecipes:feather"},
			{"group:dye"}, --{"dye:violet"},
			{"default:paper"},
		}
	})
end


minetest.register_alias("mail"				,"correio:papermail")
minetest.register_alias(modCorreio.translate("letter")			,"correio:papermail")

