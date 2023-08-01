REM [italian and french(*) follows]
REM
REM LET'S DRAW THE MAP!
REM 
REM As anticipated in the previous post, we can start doing something 
REM concrete with this map. I drew the file with the images (tiles.png) 
REM and with Tiled I transformed it into a sheet of tiles. Then, still 
REM with Tiled, I created a map and drew the first level. In Tiled, 
REM map files use the "tmx" extension while tiled sheets use the "tsx" 
REM extension. Finally, we put all the files in the "resources" folder.
REM 
REM Using a folder dedicated to game resources is a very convenient 
REM practice, for more than one reason: in addition to making 
REM everything tidy, it allows you to more easily divide the files 
REM where they were differentiated between the various targets.
REM
REM Follow the course at https://www.facebook.com/groups/867151224158600
REM
REM DISEGNAMO LA MAPPA!
REM Come anticipato nel precedente post, possiamo iniziare a fare qualcosa 
REM di concreto con questa mappa. Ho disegnato il file con le immagini 
REM (tiles.png) e con Tiled l'ho trasformato in un foglio di tiles. Poi, 
REM sempre con Tiled, ho creato una mappa e disegnato il primo livello. 
REM In Tiled i file con le mappe usano l'estensione "tmx" mentre i fogli 
REM con i tiles usano l'estensione "tsx". Abbiamo, infine, messo tutti i 
REM file nella cartella "resources".
REM 
REM Quella di utilizzare una cartella dedicata alle risorse del gioco è 
REM una pratica molto comoda, per più di un motivo: oltre a rendere il 
REM tutto ordinato, permette di suddividere più facilmente i file 
REM laddove fossero differenziati tra i vari target.
REM 
REM Segui il corso su at https://www.facebook.com/groups/867151224158600
REM
REM DESSINONS LA CARTE !
REM 
REM Comme prévu dans le post précédent, nous pouvons commencer à faire 
REM quelque chose de concret avec cette carte. J'ai dessiné le fichier 
REM avec les images (tiles.png) et avec Tiled je l'ai transformé en 
REM une feuille de tuiles. Ensuite, toujours avec Tiled, j'ai créé 
REM une carte et dessiné le premier niveau. Dans Tiled, les fichiers 
REM cartographiques utilisent l'extension "tmx" tandis que les feuilles 
REM tuilées utilisent l'extension "tsx". Enfin, nous mettons tous les 
REM fichiers dans le dossier "resources".
REM
REM Utiliser un dossier dédié aux ressources du jeu est une pratique 
REM très pratique, à plus d'un titre : en plus de tout ranger, cela 
REM permet de répartir plus facilement les fichiers là où ils ont 
REM été différenciés entre les différentes cibles.
REM
REM Suivez le cours sur https://www.facebook.com/groups/867151224158600

REM ------------------------------------

REM First we enable graphics with a fair number of colors. The most 
REM appropriate command, in this case, is BITMAP ENABLE(16). This 
REM command does two things: enable bitmap graphics (if any) and 
REM select the mode with at least 16 different colors on the screen 
REM at the same time (if any). Obviously, the video chipset may not 
REM be able to achieve that many colors. UgBASIC will select the 
REM mode closest to the one required. 

REM Come prima cosa abilitiamo la grafica con un discreto numero di 
REM colori. Il comando più opportuno, in questo caso, è BITMAP ENABLE(16).
REM Questo comando fa due cose: abilita la grafica bitmap (se presente) 
REM e seleziona la modalità con almeno 16 colori diversi 
REM contemporaneamente sullo schermo (se presenti). Ovviamente, il 
REM chipset video può non essere in grado di arrivare a tale numero 
REM di colori. Sarà ugBASIC a selezionare la modalità più vicina a 
REM quella richiesta. 

REM Nous activons d'abord les graphiques avec un bon nombre de
REM couleurs. La commande la plus appropriée, dans ce cas, est 
REM BITMAP ENABLE(16). Cette commande fait deux choses : activer 
REM les graphiques bitmap (le cas échéant) et sélectionner le mode 
REM avec au moins 16 couleurs différentes sur l'écran en même temps 
REM (le cas échéant). De toute évidence, le chipset vidéo peut ne 
REM pas être en mesure d'obtenir autant de couleurs. UgBASIC 
REM, sélectionnera le mode le plus proche de celui requis. 

BITMAP ENABLE(16)

REM Then we clear the screen with the CLS command, thus using the 
REM default colors.

REM Poi cancelliamo lo schermo con il comando CLS, 
REM usando quindi i colori di default.

REM Ensuite, nous effaçons l'écran avec la commande CLS, utilisant 
REM ainsi les couleurs par défaut.

CLS

REM Finally, let's load the map directly with the LOAD TILEMAP 
REM command and draw it on the screen with the PUT TILEMAP command, 
REM starting from the tile (0,0).

REM Carichiamo infine la mappa direttamente con il comando LOAD 
REM TILEMAP e disegnamola sullo schermo con il comando PUT TILEMAP, 
REM a partire dal tile (0,0).

REM Enfin, chargeons la carte directement avec la commande LOAD 
REM TILEMAP et dessinons-la à l'écran avec la commande PUT TILEMAP, 
REM en partant de la tuile (0,0).

level1 := LOAD TILEMAP("resources/level1.tmx")

PUT TILEMAP level1 FROM 0, 0

