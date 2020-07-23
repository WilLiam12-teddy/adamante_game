Audio file make per command:

English:
	espeak -v en+f5 -p 60 -a 100 -s 165 -g 10 "Welcome to your ship, Captain!" --stdout > welcome_en.mpc
Portuguese:
	espeak -v pt+f5 -p 60 -a 100 -s 165 -g 10 "Bem vindo a sua nave, Capitão!" --stdout > welcome_pt.mpc

Need a later conversion using audacity for audio from '.mpc' to '.ogg'.
