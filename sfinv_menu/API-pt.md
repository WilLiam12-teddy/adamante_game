API

# Registrando um botão
Esse método registra um botão na aba 'Mais' do inventario

```
sfinv_menu.register_button("meu_mod:nome", {
	title = "Titulo", -- Título exibido no botão
	icon = "imagem.png", -- Arquivo de imagem (precisa ser quadrada)
	privs = {}, -- OPICIONAL | Privilegios requeridos
	func = function(player) end, -- Função executada quando o botao é clicado
})
```
