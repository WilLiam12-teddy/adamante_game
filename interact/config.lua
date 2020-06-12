interact = {}

interact.configured = true --Change this to true when you've configured the mod!

--Which screens to show.
interact.screen1 = true --The welcome a first question screen.
interact.screen2 = true --The visit or interact screen.
interact.screen4 = true --The quiz screen.

--The first screen--
--The text at the top.

--interact.s1_header = [[Bem vindo a Adamante!
--Esse e um server para boas construcoes
--Divirta-se.]]

interact.s1_header = [[Bem vindo ao server.]]

--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s1_l2 = "Favor, diga-me se voce vai griffar ou nao?"
interact.s1_l3 = ""
--The buttons. Each can have 15 characters, max.
interact.s1_b1 = "Nao! Eu nao vou."
interact.s1_b2 = "Sim, eu vou!"

--The message to send kicked griefers.
interact.msg_grief = "Tente no singleplayer griffar! Aqui voce nao vai griffar de modo algum."

--Ban or kick griefers? Default is kick, set to true for ban.
interact.grief_ban = false

--The second screen--
--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s2_l1 = "Entao, voce vai jogar? Ou vai so conhecer mesmo?"
interact.s2_l2 = "the server?"
--The buttons. These ones can have a maximum of 26 characters.
interact.s2_b1 = "Sim, eu quero Interact!"
interact.s2_b2 = "Eu so quero conhecer mesmo."

--The message the player is sent if s/he is just visiting.
interact.visit_msg = "Have a nice time looking round! If you want interact just type /rules, and you can go through the process again!"

--The third screen--
--The header for the rules box, this can have 60 characters, max.
interact.s3_header = "Aqui estao as regras:"

--The buttons. Each can have 15 characters, max.
interact.s3_b1 = "Eu respeito"
interact.s3_b2 = "Eu nao respeito"

--The message to send players who disagree when they are kicked for disagring with the rules.
interact.disagree_msg = "Tchau! Voce não vai respeitar as regras, ne?."

--Kick, ban or ignore players who disagree with the rules.
--Options are "kick" "ban" "nothing"
interact.disagree_action = "kick"

--The fouth screen--
--Should there be a back to rules button?
interact.s4_to_rules_button = true
--The back to rules button. 13 characters, max.
interact.s4_to_rules = "Back to rules"

--The header for screen 4. 60 characters max, although this is a bit of a squash. I recomend 55 as a max.
interact.s4_header = "Time for a quiz on the rules!"

--Since the questions are intrinsically connected with the rules, they are to be found in rules.lua
--The trues are limited to 24 characters. The falses can have 36 characters.
interact.s4_question1_true = "Sim."
interact.s4_question1_false = "Nao."
interact.s4_question2_true = "Sim."
interact.s4_question2_false = "Nao."
interact.s4_question3_true = "Sim."
interact.s4_question3_false = "Nao."
interact.s4_question4_true = "Sim."
interact.s4_question4_false = "Nao."

interact.s4_submit = "Submit!"

--What to do on a wrong quiz.
--Options are "kick" "ban" "reshow" "rules" and "nothing"
interact.on_wrong_quiz = "nothing"
--The message to send the player if reshow is the on_wrong_quiz option.
interact.quiz_try_again_msg = "Have another go."
--The message sent to the player if rules is the on_wrong_quiz option.
interact.quiz_rules_msg = "Have another look at the rules:"
--The kick reason if kick is the on_wrong_quiz option.
interact.wrong_quiz_kick_msg = "Pay more attention next time!"
--The message sent to the player if nothing is the on_wrong_quiz option.
interact.quiz_fail_msg = "You got that wrong."

--The messages send to the player after interact is granted.
interact.interact_msg1 = "Obrigado por respeitar as regras."
interact.interact_msg2 = "Boa sorte, espero que goste de jogar aqui!"

--The priv required to use the /rules command. If fast is a default priv, I recomend replacing shout with that.
interact.priv = {shout = true}
