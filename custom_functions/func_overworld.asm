;This function is for teleporting you home from the start menu if you get stuck
SoftlockTeleport:
	ld a, [hJoyInput]
	cp D_DOWN + B_BUTTON + SELECT
	ret nz
	ld a, [wCurrentMenuItem]
	cp 6 
	ret nz
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	ld a, [wd732]
	set 3, a 
	res 4, a 
	set 6, a 
	ld [wd732], a
	ret
	


TrainerRematch:
	xor a
	CheckEvent EVENT_909
	jr nz, .skip_rematch_choice
	ld hl, RematchTrainerText
	call PrintText
	call NoYesChoice
	ld a, [wCurrentMenuItem]
	and a
	ret nz
.skip_rematch_choice
	ResetEvent EVENT_909
	xor a
	ret


		
;this function handles tracking of how bast to go on or off a bike
;biking ORs with $2
;running by holding B ORs with $1
TrackRunBikeSpeed:
	xor a
	ld[wUnusedD119], a
	ld a, [wWalkBikeSurfState]
	dec a ; riding a bike? (0 value = TRUE)
	call z, IsRidingBike
	ld a, [hJoyHeld]
	and B_BUTTON	;holding B to speed up? (non-zero value = TRUE)
	call nz, IsRunning
	ld a, [wUnusedD119]
	cp 2	;is biking without speedup being done?
	jr z, .skip	;if not make the states a value from 1 to 4 (excluding biking without speedup, which needs to be 2)
	inc a	
.skip
	ld[wUnusedD119], a
	ret
IsRidingBike:
	ld a, [wUnusedD119]
	or $2
	ld[wUnusedD119], a
	ret
IsRunning:
	ld a, [wUnusedD119]
	or $1
	ld[wUnusedD119], a
	ret
	

;joenote - allows for using HMs on the overworld with just a button press
CheckForSmartHMuse:
	;see if A button is being held to use the bike or rod
	ld a, [hJoyHeld]
	bit 0, a ; A button
	jp nz, CheckForRodBike
	
	callba GetTileAndCoordsInFrontOfPlayer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;check for cut
	ld a, [wObtainedBadges]
	bit 1, a ; does the player have the Cascade Badge?
	jr z, .nocut
	;does a party 'mon have CUT?
	ld c, CUT
	call PartyMoveTest
	jr z, .nocut
	;which tileset is being used?
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	;check gym tileset
	cp GYM
	jr nz, .nocut
	ld a, [wTileInFrontOfPlayer]
	cp $50 ; gym cuttable tree
	jr nz, .nocut
	jr .canCut
.overworld
	dec a
	ld a, [wTileInFrontOfPlayer]
	cp $3d ; cuttable tree
	jr z, .canCut
	cp $52 ; grass
	jr nz, .nocut
.canCut
	ld [wCutTile], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	callba InitCutAnimOAM
	ld de, CutTreeBlockSwaps
	callba ReplaceTreeTileBlock
	callba RedrawMapView
	callba AnimCut
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	ld a, SFX_CUT
	call PlaySound
	ld a, $90
	ld [hWY], a
	call UpdateSprites
	callba RedrawMapView
	jp .return
.nocut
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;check for surfing
	ld a, [wObtainedBadges]
	bit 4, a ; does the player have the Soul Badge?
	jp z, .nosurf
	ld a, [wWalkBikeSurfState]
	ld [wWalkBikeSurfStateCopy], a
	cp 2 ; is the player already surfing?
	jp z, .nosurf	
	;surfing not allowed if forced to ride bike
	ld a, [wd732]
	bit 5, a
	jr nz, .nosurf
	;load a 1 into wActionResultOrTookBattleTurn as a marker that we are checking surf from this function
	ld a, $01  
	ld [wActionResultOrTookBattleTurn], a
	callba IsSurfingAllowed
	xor a
	ld [wActionResultOrTookBattleTurn], a
	;now check bit to see of surfing allowed
	ld hl, wd728
	bit 1, [hl]
	res 1, [hl]
	jp z, .nosurf
	callba IsNextTileShoreOrWater	;unsets carry if player is facing water or shore
	jr c, .nosurf
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jr c, .nosurf
	;is the surfboard in the bag?
	ld b, SURFBOARD
	call IsItemInBag
	jr nz, .beginsurfing
	;check if a party member has surf
	ld c, SURF
	call PartyMoveTest
	jp z, .nosurf
.beginsurfing
	;we can now initiate surfing
	ld hl, wd730
	set 7, [hl]
	ld a, 2
	ld [wWalkBikeSurfState], a ; change player state to surfing
	;update sprites
	call LoadPlayerSpriteGraphics
	call PlayDefaultMusic ; play surfing music
	;move player forward
	ld a, [wPlayerDirection] ; direction the player is going
	bit PLAYER_DIR_BIT_UP, a
	ld b, D_UP
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_DOWN, a
	ld b, D_DOWN
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_LEFT, a
	ld b, D_LEFT
	jr nz, .storeSimulatedButtonPress
	ld b, D_RIGHT
.storeSimulatedButtonPress
	ld a, b
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wWastedByteCD39], a
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	jp .return
.nosurf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;check for flash
	ld a, [wObtainedBadges]
	bit 0, a ; does the player have the Boulder Badge?
	jr z, .noflash
	;check if the map pal offset is not zero
	ld a, [wMapPalOffset]
	and a 
	jr z, .noflash
	;check if a party member has strength
	ld c, FLASH
	call PartyMoveTest
	jr z, .noflash
	;restore the map pal offset to brighten it up
	xor a
	ld [wMapPalOffset], a
	jp .return
.noflash
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;else check for strength and enable it
	ld a, [wObtainedBadges]
	bit 3, a ; does the player have the Rainbow Badge?
	jr z, .nostrength
	;check if a party member has strength
	ld c, STRENGTH
	call PartyMoveTest
	jr z, .nostrength
	;set the usingStrength bit
	ld a, [wd728]
	set 0, a
	ld [wd728], a
	jp .return
.nostrength
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.return
	ret
	

;Check if any pokemon in the party has a certain move
;move ID should be in 'c'
;set zero flag if move not found
;clear zero flag if move found
PartyMoveTest:
	push hl
	push bc
	;;;;;
	ld hl, wPartyMon1Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
	;;;;;
	ld a, [wPartyCount]
	cp 2
	jr c, .return_0
	ld hl, wPartyMon2Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
	;;;;;
	ld a, [wPartyCount]
	cp 3
	jr c, .return_0
	ld hl, wPartyMon3Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
	;;;;;
	ld a, [wPartyCount]
	cp 4
	jr c, .return_0
	ld hl, wPartyMon4Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
	;;;;;
	ld a, [wPartyCount]
	cp 5
	jr c, .return_0
	ld hl, wPartyMon5Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
	;;;;;
	ld a, [wPartyCount]
	cp 6
	jr c, .return_0
	ld hl, wPartyMon6Moves
	ld b, NUM_MOVES + 1
	call MoveTestLoop
	jr nz, .return_1
.return_0
	xor a
.return_1
	pop bc
	pop hl
	ret
	
MoveTestLoop:
	dec b
	jr z, .return
	ld a, [hli]
	cp c
	jr nz, MoveTestLoop
	inc b
.return
	ret
	
	
	


;Overworld female trainer sprite functions
LoadRedSpriteToDE:
	ld de, RedFSprite
	ld a, [wUnusedD721]
	bit 0, a	;check if girl
	jr nz, .donefemale
	ld de, RedSprite
.donefemale
	res 2, a
	ld [wUnusedD721], a
	ret
	
LoadSeelSpriteToDE:
	ld de, SeelSprite
	ld a, [wUnusedD721]
	set 2, a	;regardless if boy or girl, need to set override bit to use the regular sprite bank
	ld [wUnusedD721], a
	ret

LoadRedCyclingSpriteToDE:
	ld de, RedFCyclingSprite
	ld a, [wUnusedD721]
	bit 0, a	;check if girl
	jr nz, .donefemale
	ld de, RedCyclingSprite
.donefemale
	res 2, a
	ld [wUnusedD721], a
	ret


;this function handles quick-use of fishing and biking by piggy-backing off the CheckForSmartHMuse function
CheckForRodBike:
	callba IsNextTileShoreOrWater	;unsets carry if player is facing water or shore
	jr c, .nofishing
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jr c, .nofishing
	;are rods in the bag?
	ld b, SUPER_ROD
	push bc
	call IsItemInBag
	pop bc
	jr nz, .start
	ld b, GOOD_ROD
	push bc
	call IsItemInBag
	pop bc
	jr nz, .start
	ld b, OLD_ROD
	push bc
	call IsItemInBag
	pop bc
	jr nz, .start

.nofishing
	;do nothing if forced to ride bike
	ld a, [wd732]
	bit 5, a
	ret nz
	;else check if bike is in bag
	ld b, BICYCLE
	push bc
	call IsItemInBag
	pop bc
	jr z, .return

.start
	push bc
	;initialize a text box without drawing anything special
	ld a, 1
	ld [wAutoTextBoxDrawingControl], a
	callba DisplayTextIDInit
	pop bc

	;determine item to use
	ld a, b
	ld [wcf91], a	;load item to be used
	ld [wd11e], a	;load item so its name can be grabbed
	call GetItemName	;get the item name into de register
	call CopyStringToCF4B ; copy name from de to wcf4b so it shows up in text
	call UseItem	;use the item

	;use $ff value loaded into hSpriteIndexOrTextID to make DisplayTextID display nothing and close any text
	ld a, $FF
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
.return
	ret