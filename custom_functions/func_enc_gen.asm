;replace random mew encounters with ditto if dex diploma not attained
DisallowMew:
	CheckEvent EVENT_90B
	ret nz	;if event 90B is set, then diploma has been granted so return from this function. mew is allowed.
	ld a, [wcf91]	;else get the current pokemon in question
	cp MEW	;is it mew? zet zero flag if true
	ret nz	;if not mew, then return
	ld a, [wIsInBattle]	;else we have a mew. now load the battle type (1 is wild battle, 2+ is trainer battle)
	dec a	;zero flag set here if in wild battle
	ld a, DITTO	;load the ditto constant
	ld [wcf91], a	;overwrite mew with ditto
	ret nz	
	ld [wEnemyMonSpecies2], a
	ret

	
	

CheckIfPkmnReal:
;set the carry if pokemon number in 'a' is found on the list of legit pokemon
	push hl
	push de
	push bc
	ld hl, ListRealPkmn
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl

;This function loads a random trainer class (value of $01 to $2F)
GetRandTrainer:
.reroll
	call Random
	and $30
	cp $30
	jr z, .reroll
	push bc
	ld b, a
	call Random
	and $0F
	add b
	pop bc
	and a
	jr z, .reroll
	add $C8
	ld [wEngagedTrainerClass], a
	ld a, 1
	ld [wEngagedTrainerSet], a
	ret

;gets a random pokemon and puts its hex ID in register a and wcf91
GetRandMonAny:
	ld de, ListRealPkmn
	;fall through
GetRandMon:
	push hl
	push bc
	ld h, d
	ld l, e
	call Random
	ld b, a
.loop
	ld a, b
	and a
	jr z, .endloop
	inc hl
	dec b
	ld a, [hl]
	and a
	jr nz, .loop
	ld h, d
	ld l, e
	jr .loop
.endloop
	ld a, [hl]
	pop bc
	pop hl
	ld [wcf91], a
	call DisallowMew
	ret
	
;generates a randomized 6-party enemy trainer roster
GetRandRoster:
	push bc
	push de
	ld de, ListRealPkmn
	ld b, 6
	jp GetRandRosterLoop
GetRandRoster3:	;3-mon party
	push bc
	push de
	ld de, ListNonMewPkmn
	ld b, 3
GetRandRosterLoop:
	ld a, [wPartyMon1Level]
	ld [wCurEnemyLVL], a
.loop	
	push bc
	push de
	call GetRandMon
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	
	push hl
	call ScaleTrainer
	pop hl
	
	push hl
	call AddPartyMon
	call Random
	and $01
	ld b, a
	ld a, [wCurEnemyLVL]
	add b
	ld [wCurEnemyLVL], a
	pop hl
	
	pop de
	pop bc
	dec b
	jr nz, .loop
;end of loop
	pop de
	pop bc
	xor a	;set the zero flag before returning
	ret	

	

;implement a function to scale trainer levels
ScaleTrainer:
	CheckEvent EVENT_90C
	ret z
	push bc
	ld a, [wCurEnemyLVL]
	ld b, a
	ld a, [wPartyMon1Level]
	cp b
	jr c, .nolvlincrease
	jr z, .nolvlincrease
	ld [wCurEnemyLVL], a
	call Random
	and $03
	ld b, a
	ld a, [wGymLeaderNo]
	and a
	jr z, .notboss
	ld a, [wCurEnemyLVL]
	add b
	ld [wCurEnemyLVL], a
	call Random
	and $03
	ld b, a
.notboss
	ld a, [wCurEnemyLVL]
	add b
	ld [wCurEnemyLVL], a
.nolvlincrease
	pop bc
	callba EnemyMonEvolve
	ret


; return a = 0 if not in safari zone, else a = 1 if in safari zone
IsInSafariZone:
	ld a, [wCurMap]
	cp SAFARI_ZONE_EAST
	jr c, .notSafari
	cp SAFARI_ZONE_REST_HOUSE_1
	jr nc, .notSafari
	ld a, $01
	jr .return
.notSafari
	ld a, $00
.return
	and a
	ret

;Generate a random mon for an expanded safari zone roster
GetRandMonSafari:
	;return if e4 not yet beaten
	CheckEvent EVENT_908
	ret z	
	;return if not in safari zone
	call IsInSafariZone
	ret z
	;else continue on
	call Random
	cp 26
	ret nc	;only a 26/256 chance to have an expanded encounter
	push hl
	push bc
	call GetSafariList
	call Random
	ld b, a
.loop
	ld a, b
	and a
	jr z, .endloop
	inc hl
	dec b
	ld a, [hl]
	and a
	jr nz, .loop
	call GetSafariList
	jr .loop
.endloop
	ld a, [hl]
	pop bc
	pop hl
	ld [wcf91], a
	ld [wEnemyMonSpecies2], a
	call DisallowMew
	ret	

GetSafariList:	
	ld a, [wCurMap]
	cp SAFARI_ZONE_CENTER
	ld hl, ListNonLegendPkmn
	ret z
	cp SAFARI_ZONE_EAST
	ld hl, ListMidEvolvedPkmn
	ret z
	cp SAFARI_ZONE_NORTH
	ld hl, ListNonEvolvingPkmn
	ret z
	ld hl, ListMostEvolvedPkmn
	ret
	
	
	
