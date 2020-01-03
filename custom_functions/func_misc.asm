;Convert the DVs of the ist party pkmn into a normalized BCD-value score stored in wcd6d
Mon1DVsBCDScore:
	push de
	push hl
	push bc
	xor a
	ld [hCoins], a
	ld [hCoins + 1], a
	ld [hItemPrice], a	
	ld [hItemPrice + 1], a	
	ld [hItemPrice + 2], a	
	
	ld de, hCoins + 1
	ld hl, hItemPrice + 1
	
	ld a, [wPartyMon1DVs]	;load first two nybbles of DVs
	srl a	;shift all bits to the right one time
	and $F7	; clear the highest bit of the low nybble in case the high nybble overflowed into the low nybble
	ld [de], a
	
	ld a, [wPartyMon1DVs + 1]	;load second two nybbles of DVs
	srl a	;shift all bits to the right one time
	and $F7	; clear the highest bit of the low nybble in case the high nybble overflowed into the low nybble
	ld [hl], a
	
	ld c, $2
	predef AddBCDPredef	;add value in hl location to value in de location
	;now store in wcd6d buffer
	ld a, [hCoins]
	ld [wcd6d], a
	ld a, [hCoins + 1]
	ld [wcd6d + 1], a

	xor a
	ld [hCoins], a
	ld [hCoins + 1], a
	ld [hItemPrice], a	
	ld [hItemPrice + 1], a	
	ld [hItemPrice + 2], a	
	pop bc
	pop hl
	pop de
	ret


	
;play cry if the 1st pokemon has payday in its move set
LuckySlotDetect:
	push hl
	ld b, NUM_MOVES + 1
	ld hl, wPartyMon1Moves
.loop
	dec b
	jr z, .return
	ld a, [hli]
	cp PAY_DAY
	jr nz, .loop
	ld a, [wPartyMon1Species]
	call PlayCry
.return
	pop hl
	ret
	

	
