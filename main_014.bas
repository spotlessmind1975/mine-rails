REM
REM LET'S MOVE THE WAGON
REM 
REM Follow the course at https://www.facebook.com/groups/867151224158600
REM
REM SPOSTARE IL CARRELLO
REM
REM Segui il corso su at https://www.facebook.com/groups/867151224158600
REM
REM DÉPLACER LE PANIER
REM 
REM Suivez le cours sur https://www.facebook.com/groups/867151224158600

BITMAP ENABLE(16)

wagonImage := LOAD IMAGE( "resources/wagon.png")

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
	PUT IMAGE wagonImage AT 0, 0
	GET IMAGE wagonBackground FROM 0, 0
	CLS BLACK
	
END PROC

PROCEDURE readWagonMovement

	SHARED x, y, dx, dy

	right = JRIGHT(0) OR KEY PRESSED( KEY S )
	left = JLEFT(0) OR KEY PRESSED( KEY A )
	up = JUP(0) OR KEY PRESSED( KEY W )
	down = JDOWN(0) OR KEY PRESSED( KEY Z )

	IF (dx = 0) AND (dy = 0) THEN
		IF right AND ( x < maxWagonX ) THEN
			dx = wagonSpeedX
		ELSE IF left AND ( x > minWagonX ) THEN
			dx = -wagonSpeedX
		ELSE IF down AND ( y < maxWagonY ) THEN
			dy = wagonSpeedY
		ELSE IF up AND ( y > minWagonY ) THEN
			dy = -wagonSpeedY
		ENDIF
	ENDIF
				
END PROC

PROCEDURE drawWagonSprite ON C64, C128, COLECO, MSX, SC3000, SG1000
	
	SHARED x, y
	SHARED wagon

	SPRITE wagon ENABLE AT x, y
	
END PROC

PROCEDURE drawWagonBitmap ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX
	
	SHARED x, y
	SHARED px, py
	SHARED wagonImage
	
	IF ( px <> x ) OR ( py <> y ) THEN
		IF (px<>-1) AND (py<>-1) THEN
			PUT IMAGE wagonBackground AT px, py
		ENDIF
		GET IMAGE wagonBackground FROM x, y
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

prepareBitmaps[] ON CPC, ATARI, ATARIXL, COCO, DRAGON, MO5, PC128OP, ZX

EVERY 5 TICKS CALL drawWagon

CLS BLACK

EVERY ON

DO
	
	readWagonMovement[]
	
LOOP



