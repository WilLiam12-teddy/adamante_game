--The actual rules.
interact.rules = [[
Rules:

1. Nao grief.
2. Nao hackear os players.
3. Nao fazer propaganda de outros servers.
4. Nao arranjar briga com os outros.
5. Nao faca brincadeiras de mal gosto.
6. Nao peca coisas e privs de admin.
7. Nao faca racismo/homofobia.
]]

--The questions on the rules, if the quiz is used.
--The checkboxes for the first 4 questions are in config.lua
interact.s4_question1 = "Voce pode fazer racismo/homofobia com os players?"
interact.s4_question2 = "Voce pode pedir por coisas e privs de admin?"
interact.s4_question3 = "Voce vai ser bom com os outros players?"
interact.s4_question4 = "Voce vai pedir por todos privs que quiser?"
interact.s4_multi_question = "Voce vai respeitar as regras?"

--The answers to the multiple choice questions. Only one of these should be true.
interact.s4_multi1 = "Griefing e proibido."
interact.s4_multi2 = "Nao peca por coisas de admin."
interact.s4_multi3 = "Nao seja rude com os outros players."

--Which answer is needed for the quiz questions. interact.quiz1-4 takes true or false.
--True is left, false is right.
--Please, please spell true and false right!!! If you spell it wrong it won't work!
--interact.quiz can be 1, 2 or 3.
--1 is the top one by the question, 2 is the bottom left one, 3 is the bottom right one.
--Make sure these agree with your answers!
interact.quiz1 = false
interact.quiz2 = false
interact.quiz3 = true
interact.quiz4 = false
interact.quiz_multi = 2
