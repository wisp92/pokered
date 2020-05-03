Copy over the move_relearner.asm that's in the text folder
Copy over the move_deleter.asm that's in the text folder
In text.asm, put in under SECTION "Text 3"
	INCLUDE "text/move_deleter.asm"
	INCLUDE "text/move_relearner.asm"

Copy over the move_relearner.asm that's in the scripts folder
Copy over the move_deleter.asm that's in the scripts folder
In main.asm under SECTION "bank7" add the following
	INCLUDE "scripts/move_deleter.asm"
	INCLUDE "scripts/move_relearner.asm"

In home.asm modify a part of the DisplayListMenuIDLoop:: function
.skipMultiplying
	ld a, [wListPointer]
	ld l, a
	ld a, [wListPointer + 1]
	ld h, a
	inc hl ; hl = beginning of list entries
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wcf91], a
	ld a, [wListMenuID]
	and a ; is it a PC pokemon list?
	jr z, .pokemonList
	push hl
	call GetItemPrice
	pop hl
	ld a,[wListMenuID]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;needed to make Mateo's move deleter/relearner work
	cp a, MOVESLISTMENU
	jr z, .skipStoringItemName
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cp ITEMLISTMENU
	jr nz, .skipGettingQuantity
; if it's an item menu
	inc hl
	ld a, [hl] ; a = item quantity
	ld [wMaxItemQuantity], a
.skipGettingQuantity
	ld a, [wcf91]
	ld [wd0b5], a
	ld a, BANK(ItemNames)
	ld [wPredefBank], a
	call GetName
	jr .storeChosenEntry
.pokemonList
	ld hl, wPartyCount
	ld a, [wListPointer]
	cp l ; is it a list of party pokemon or box pokemon?
	ld hl, wPartyMonNicks
	jr z, .getPokemonName
	ld hl, wBoxMonNicks ; box pokemon names
.getPokemonName
	ld a, [wWhichPokemon]
	call GetPartyMonName
.storeChosenEntry ; store the menu entry that the player chose and return
	ld de, wcd6d
	call CopyStringToCF4B ; copy name to wcf4b
.skipStoringItemName	;skip here if skipping storing item name
	ld a, CHOSE_MENU_ITEM
	ld [wMenuExitMethod], a
	ld a, [wCurrentMenuItem]
	ld [wChosenMenuItem], a
	xor a
	ld [hJoy7], a ; joypad state update flag
	ld hl, wd730
	res 6, [hl] ; turn on letter printing delay
	jp BankswitchBack
.checkOtherKeys ; check B, SELECT, Up, and Down keys


In the engine/evos_moves.asm file, you need to copy over the function PrepareRelearnableMoveList:

Copy over both saffronhouse1.asm files