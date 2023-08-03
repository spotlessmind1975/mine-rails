REM
REM LET'S DRAW THE MAP!
REM 
REM Follow the course at https://www.facebook.com/groups/867151224158600
REM
REM DISEGNAMO LA MAPPA!
REM
REM Segui il corso su at https://www.facebook.com/groups/867151224158600
REM
REM DESSINONS LA CARTE !
REM 
REM Suivez le cours sur https://www.facebook.com/groups/867151224158600

BITMAP ENABLE(16)

CLS

level1 := LOAD TILEMAP("resources/level1.tmx")

tileset := TILESET(level1)

POSITIVE CONST tileWidth = TILE WIDTH( tileset )
POSITIVE CONST tileHeight = TILE HEIGHT( tileset )
POSITIVE CONST screenWidthInTiles = SCREEN WIDTH / tileWidth 
POSITIVE CONST screenHeightInTiles = SCREEN HEIGHT / tileHeight
POSITIVE CONST maxPageX = ( ( TILEMAP WIDTH( level1 ) - 1 ) / screenWidthInTiles ) + 1
POSITIVE CONST maxPageY = ( ( TILEMAP HEIGHT( level1 ) - 1 ) / screenHeightInTiles ) + 1

DIM actualPageX AS SIGNED BYTE
DIM actualPageY AS SIGNED BYTE
DIM previousPageX AS SIGNED BYTE = -1
DIM previousPageY AS SIGNED BYTE = -1

PROCEDURE drawMap

	SHARED level1
	SHARED actualPageX, actualPageY
	SHARED previousPageX, previousPageY
		
	IF ( previousPageX <> actualPageX ) OR ( previousPageY <> actualPageY ) THEN
		PUT TILEMAP level1 FROM actualPageX * screenWidthInTiles, actualPageY * screenHeightInTiles
		previousPageX = actualPageX
		previousPageY = actualPageY
	ENDIF

END PROC

PROCEDURE readMovement

	SHARED actualPageX, actualPageY
	
	right = JRIGHT(0) OR KEY PRESSED( KEY S )
	left = JLEFT(0) OR KEY PRESSED( KEY A )
	up = JUP(0) OR KEY PRESSED( KEY W )
	down = JDOWN(0) OR KEY PRESSED( KEY Z )

	IF right AND ( (actualPageX+1) < maxPageX ) THEN
		INC actualPageX
	ELSE IF left AND ( (actualPageX-1) >= 0 ) THEN
		DEC actualPageX
	ELSE IF down AND  ( (actualPageY+1) < maxPageY )  THEN
		INC actualPageY
	ELSE IF up AND ( (actualPageY-1) >= 0 ) THEN
		DEC actualPageY
	ENDIF

END PROC

DO

	drawMap[]

	readMovement[]
	
LOOP



