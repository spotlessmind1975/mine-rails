REM
REM WE PUT TRACKS AND WAGONS TOGETHER
REM 
REM Follow the course at https://www.facebook.com/groups/867151224158600
REM
REM METTIAMO INSIEME BINARI E VAGONI
REM
REM Segui il corso su at https://www.facebook.com/groups/867151224158600
REM
REM NOUS ASSEMBLONS LES CHENILLES ET LES WAGONS
REM 
REM Suivez le cours sur https://www.facebook.com/groups/867151224158600

BITMAP ENABLE(16)

CLS

wagonImage := LOAD IMAGE( "resources/wagon.png")

level1 := LOAD TILEMAP("resources/level1.tmx")

tileset := TILESET(level1)

POSITIVE CONST tileWidth = TILE WIDTH( tileset )
POSITIVE CONST tileHeight = TILE HEIGHT( tileset )
POSITIVE CONST screenWidthInTiles = SCREEN WIDTH / tileWidth 
POSITIVE CONST screenHeightInTiles = SCREEN HEIGHT / tileHeight
POSITIVE CONST maxPageX = ( ( TILEMAP WIDTH( level1 ) - 1 ) / screenWidthInTiles ) + 1
POSITIVE CONST maxPageY = ( ( TILEMAP HEIGHT( level1 ) - 1 ) / screenHeightInTiles ) + 1

POSITIVE CONST wagonSpeed = 4
POSITIVE CONST wagonSpeedX = ( wagonSpeed * SCREEN SPRITE RATIO X ) / 100
POSITIVE CONST wagonSpeedY = ( wagonSpeed * SCREEN SPRITE RATIO Y ) / 100

POSITIVE CONST wagonImageWidth = IMAGE WIDTH( wagonImage )
POSITIVE CONST wagonImageHeight = IMAGE HEIGHT( wagonImage )

POSITIVE CONST minWagonX = SCREEN BORDER X
POSITIVE CONST minWagonY = SCREEN BORDER Y
POSITIVE CONST screenWidthInWagonCoords = ( SCREEN WIDTH * SCREEN SPRITE RATIO X ) / 100
POSITIVE CONST screenHeightInWagonCoords = ( SCREEN HEIGHT * SCREEN SPRITE RATIO Y ) / 100
POSITIVE CONST maxWagonX = SCREEN BORDER X + screenWidthInWagonCoords - wagonImageWidth
POSITIVE CONST maxWagonY = SCREEN BORDER Y + screenHeightInWagonCoords - wagonImageHeight

DIM actualPageX AS SIGNED BYTE
DIM actualPageY AS SIGNED BYTE
DIM previousPageX AS SIGNED BYTE = -1
DIM previousPageY AS SIGNED BYTE = -1
DIM x AS POSITION = minWagonX
DIM y AS POSITION = minWagonY
DIM px AS POSITION = -1
DIM py AS POSITION = -1
DIM dx AS POSITION = 0
DIM dy AS POSITION = 0

wagon = CSPRITE( wagonImage )

PROCEDURE prepareBitmaps ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX

	SHARED wagonImage
	SHARED wagonBackground
	
	wagonBackground := NEW IMAGE( wagonImageWidth, wagonImageHeight )
	
END PROC

PROCEDURE readWagonMovement

	SHARED x, y, dx, dy
	SHARED actualPageX, actualPageY

	right = JRIGHT(0) OR KEY PRESSED( KEY S )
	left = JLEFT(0) OR KEY PRESSED( KEY A )
	up = JUP(0) OR KEY PRESSED( KEY W )
	down = JDOWN(0) OR KEY PRESSED( KEY Z )

	IF (dx = 0) AND (dy = 0) THEN
		IF right THEN
			IF ( ( x + wagonSpeedX ) <= maxWagonX ) THEN
				dx = wagonSpeedX
			ELSE IF ( (actualPageX+1) < maxPageX ) THEN
				x = minWagonX
				INC actualPageX
			ENDIF
		ELSE IF left THEN
			IF ( ( x ) > minWagonX ) THEN
				dx = -wagonSpeedX
			ELSE IF ( actualPageX > 0 ) THEN
				x = maxWagonX - 1
				DEC actualPageX
			ENDIF
		ELSE IF down THEN
			IF ( ( y + wagonSpeedY ) < maxWagonY ) THEN
				dy = wagonSpeedY
			ELSE IF ( (actualPageY+1) < maxPageY ) THEN
				y = minWagonY
				INC actualPageY		
			ENDIF
		ELSE IF up THEN
			IF ( y > minWagonY ) THEN
				dy = -wagonSpeedY
			ELSE IF ( actualPageY > 0) THEN
				y = maxWagonY - 1
				DEC actualPageY
			ENDIF
		ENDIF
	ENDIF
				
END PROC

PROCEDURE drawWagonSprite ON C64, C128, COLECO, MSX, SC3000, SG1000
	
	SHARED x, y
	SHARED wagon

	SPRITE wagon ENABLE AT x, y
	
END PROC

PROCEDURE saveWagonBackground ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX
	
	SHARED x, y
	SHARED wagonBackground
	
	GET IMAGE wagonBackground FROM x, y

END PROC

PROCEDURE drawWagonBitmap ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX
	
	SHARED x, y
	SHARED px, py
	SHARED wagonImage
	
	IF ( px <> x ) OR ( py <> y ) THEN
		IF (px<>-1) AND (py<>-1) THEN
			PUT IMAGE wagonBackground AT px, py
		ENDIF
		saveWagonBackground[] ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX
		PUT IMAGE wagonImage AT x,y WITH TRANSPARENCY
		px = x
		py = y
	ENDIF		

END PROC

PROCEDURE drawWagon
	
	SHARED x, y, dx, dy
	SHARED wagon
	
	ADD x, dx
	IF x < minWagonX THEN
		x = minWagonX
	ENDIF
	IF x > maxWagonX THEN
		x = maxWagonX
	ENDIF
	
	ADD y, dy
	IF y < minWagonY THEN
		y = minWagonY
	ENDIF
	IF y > maxWagonY THEN
		y = maxWagonY
	ENDIF
	
	drawWagonSprite[] ON C64, C128, COLECO, MSX, SC3000, SG1000
	drawWagonBitmap[] ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX
	
	dx = 0
	dy = 0
	
	EVERY ON
	
END PROC

PROCEDURE drawMap

	SHARED level1
	SHARED actualPageX, actualPageY
	SHARED previousPageX, previousPageY
	SHARED px, py
	SHARED wagonBackground
		
	IF ( previousPageX <> actualPageX ) OR ( previousPageY <> actualPageY ) THEN
		EVERY OFF
		PUT TILEMAP level1 FROM actualPageX * screenWidthInTiles, actualPageY * screenHeightInTiles
		GET IMAGE wagonBackground FROM px, py
		EVERY ON
		previousPageX = actualPageX
		previousPageY = actualPageY
	ENDIF

END PROC

prepareBitmaps[] ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX

EVERY 5 TICKS CALL drawWagon

CLS BLACK

EVERY ON

DO

	drawMap[]
	
	readWagonMovement[]

LOOP







