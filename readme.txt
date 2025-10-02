la seguente è una cartella custom per il setup di un container con ubuntu 20.04 e ROS1 per lo sviluppo di applicazioni. La seguente struttura è utiizzata

HOME/
  |_ devdocker/
  	|_ config/
  	|	|_ Dockerfile
  	|_ run.sh
  	|_ build.sh
  	
_Oss_ se serve abilitare i permessi usare il seguente comando
chmod +x <file>


build.sh -> costruisce lìimmagina a partire dal dockerfile

start.sh -> apre il container dal workspace desiderato (decidere se farlo come parametro o in base alla directory corrente, per ora la seconda)
_Oss_ Impostare alias devdocker aggiungendo nel ~/.bashrc la seguente riga: 
	alias devdocker="$HOME/devdocker/run.sh"
_USAGE_
	devdocker 		-> esegue il run del container
	devdocker -b 		-> esegue il build dell'imagine
	devdocker -h 		-> stampa le opzioni del programmaesegue il build dell'imagine



TO DO:
> set nvidia in docker
> add export NO_AT_BRIDGE=1 on container .bashrc (risolve warning terminator)
> add source /opt/ros/$ROS_DISTRO/setup.bash on container .bashrc 
