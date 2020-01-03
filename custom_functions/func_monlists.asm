ListRealPkmn:
	db MEW          ; $15
	db MEWTWO       ; $83
	db MOLTRES      ; $49
	db ARTICUNO     ; $4A
	db ZAPDOS       ; $4B
ListNonLegendPkmn:
	db NIDORAN_M    ; $03
	db CLEFAIRY     ; $04
	db SPEAROW      ; $05
	db VOLTORB      ; $06
	db EXEGGCUTE    ; $0C
	db GRIMER       ; $0D
	db NIDORAN_F    ; $0F
	db CUBONE       ; $11
	db RHYHORN      ; $12
	db SHELLDER     ; $17
	db TENTACOOL    ; $18
	db GASTLY       ; $19
	db STARYU       ; $1B
	db GROWLITHE    ; $21
	db PIDGEY       ; $24
	db SLOWPOKE     ; $25
	db PSYDUCK      ; $2F
	db DROWZEE      ; $30
	db KOFFING      ; $37
	db MANKEY       ; $39
	db SEEL         ; $3A
	db DIGLETT      ; $3B
	db VENONAT      ; $41
	db DODUO        ; $46
	db POLIWAG      ; $47
	db MEOWTH       ; $4D
	db KRABBY       ; $4E
	db VULPIX       ; $52
	db PIKACHU      ; $54
	db DRATINI      ; $58
	db KABUTO       ; $5A
	db HORSEA       ; $5C
	db SANDSHREW    ; $60
	db OMANYTE      ; $62
	db JIGGLYPUFF   ; $64
	db EEVEE        ; $66
	db MACHOP       ; $6A
	db ZUBAT        ; $6B
	db EKANS        ; $6C
	db PARAS        ; $6D
	db WEEDLE       ; $70
	db CATERPIE     ; $7B
	db MAGIKARP     ; $85
	db ABRA         ; $94
	db BULBASAUR    ; $99
	db GOLDEEN      ; $9D
	db PONYTA       ; $A3
	db RATTATA      ; $A5
	db GEODUDE      ; $A9
	db MAGNEMITE    ; $AD
	db CHARMANDER   ; $B0
	db SQUIRTLE     ; $B1
	db ODDISH       ; $B9
	db BELLSPROUT   ; $BC
ListMidEvolvedPkmn:
	db IVYSAUR      ; $09
	db KADABRA      ; $26
	db GRAVELER     ; $27
	db MACHOKE      ; $29
	db POLIWHIRL    ; $6E
	db KAKUNA       ; $71
	db METAPOD      ; $7C
	db HAUNTER      ; $93
	db PIDGEOTTO    ; $96
	db NIDORINO     ; $A7
	db NIDORINA     ; $A8
	db CHARMELEON   ; $B2
	db WARTORTLE    ; $B3
	db GLOOM        ; $BA
	db WEEPINBELL   ; $BD
ListNonEvolvingPkmn:
	db PORYGON      ; $AA
	db AERODACTYL   ; $AB
	db SNORLAX      ; $84
	db DITTO        ; $4C
	db JYNX         ; $48
	db TAUROS       ; $3C
	db FARFETCHD    ; $40
	db MAGMAR       ; $33
	db ELECTABUZZ   ; $35
	db MR_MIME      ; $2A
	db HITMONLEE    ; $2B
	db HITMONCHAN   ; $2C
	db CHANSEY      ; $28
	db ONIX         ; $22
ListMostEvolvedPkmn:
	db CHARIZARD    ; $B4
	db VILEPLUME    ; $BB
	db VICTREEBEL   ; $BE
	db FEAROW       ; $23
	db RATICATE     ; $A6
	db RAPIDASH     ; $A4
	db VENUSAUR     ; $9A
	db TENTACRUEL   ; $9B
	db SEAKING      ; $9E
	db PIDGEOT      ; $97
	db STARMIE      ; $98
	db ALAKAZAM     ; $95
	db MUK          ; $88
	db KINGLER      ; $8A
	db CLOYSTER     ; $8B
	db ELECTRODE    ; $8D
	db CLEFABLE     ; $8E
	db WEEZING      ; $8F
	db PERSIAN      ; $90
	db MAROWAK      ; $91
	db BUTTERFREE   ; $7D
	db MACHAMP      ; $7E
	db GOLDUCK      ; $80
	db HYPNO        ; $81
	db GOLBAT       ; $82
	db BEEDRILL     ; $72
	db DODRIO       ; $74
	db PRIMEAPE     ; $75
	db DUGTRIO      ; $76
	db VENOMOTH     ; $77
	db DEWGONG      ; $78
	db POLIWRATH    ; $6F
	db FLAREON      ; $67
	db JOLTEON      ; $68
	db VAPOREON     ; $69
	db WIGGLYTUFF   ; $65
	db OMASTAR      ; $63
	db SANDSLASH    ; $61
	db SEADRA       ; $5D
	db KABUTOPS     ; $5B
	db DRAGONAIR    ; $59
	db RAICHU       ; $55
	db NINETALES    ; $53
	db DRAGONITE    ; $42
	db GOLEM        ; $31
	db MAGNETON     ; $36
	db ARBOK        ; $2D
	db PARASECT     ; $2E
	db BLASTOISE    ; $1C
	db RHYDON       ; $01
	db NIDOKING     ; $07
	db SLOWBRO      ; $08
	db EXEGGUTOR    ; $0A
	db GENGAR       ; $0E
	db NIDOQUEEN    ; $10
	db ARCANINE     ; $14
	db GYARADOS     ; $16
	db $00

	
;ListLeastEvolvedPkmn:	;Synced up to the above list in case you need the lease evolution of some pokemon for some reason
;	db MEW          ; $15
;	db MEWTWO       ; $83
;	db MOLTRES      ; $49
;	db ARTICUNO     ; $4A
;	db ZAPDOS       ; $4B
;	db NIDORAN_M    ; $03
;	db CLEFAIRY     ; $04
;	db SPEAROW      ; $05
;	db VOLTORB      ; $06
;	db EXEGGCUTE    ; $0C
;	db GRIMER       ; $0D
;	db NIDORAN_F    ; $0F
;	db CUBONE       ; $11
;	db RHYHORN      ; $12
;	db SHELLDER     ; $17
;	db TENTACOOL    ; $18
;	db GASTLY       ; $19
;	db STARYU       ; $1B
;	db GROWLITHE    ; $21
;	db PIDGEY       ; $24
;	db SLOWPOKE     ; $25
;	db PSYDUCK      ; $2F
;	db DROWZEE      ; $30
;	db KOFFING      ; $37
;	db MANKEY       ; $39
;	db SEEL         ; $3A
;	db DIGLETT      ; $3B
;	db VENONAT      ; $41
;	db DODUO        ; $46
;	db POLIWAG      ; $47
;	db MEOWTH       ; $4D
;	db KRABBY       ; $4E
;	db VULPIX       ; $52
;	db PIKACHU      ; $54
;	db DRATINI      ; $58
;	db KABUTO       ; $5A
;	db HORSEA       ; $5C
;	db SANDSHREW    ; $60
;	db OMANYTE      ; $62
;	db JIGGLYPUFF   ; $64
;	db EEVEE        ; $66
;	db MACHOP       ; $6A
;	db ZUBAT        ; $6B
;	db EKANS        ; $6C
;	db PARAS        ; $6D
;	db WEEDLE       ; $70
;	db CATERPIE     ; $7B
;	db MAGIKARP     ; $85
;	db ABRA         ; $94
;	db BULBASAUR    ; $99
;	db GOLDEEN      ; $9D
;	db PONYTA       ; $A3
;	db RATTATA      ; $A5
;	db GEODUDE      ; $A9
;	db MAGNEMITE    ; $AD
;	db CHARMANDER   ; $B0
;	db SQUIRTLE     ; $B1
;	db ODDISH       ; $B9
;	db BELLSPROUT   ; $BC
;	db BULBASAUR      ; $09
;	db ABRA      ; $26
;	db GEODUDE     ; $27
;	db MACHOP      ; $29
;	db POLIWAG    ; $6E
;	db WEEDLE       ; $71
;	db CATERPIE      ; $7C
;	db GASTLY      ; $93
;	db PIDGEY    ; $96
;	db NIDORAN_M     ; $A7
;	db NIDORAN_F     ; $A8
;	db CHARMANDER   ; $B2
;	db SQUIRTLE    ; $B3
;	db ODDISH        ; $BA
;	db BELLSPROUT   ; $BD
;	db PORYGON      ; $AA
;	db AERODACTYL   ; $AB
;	db SNORLAX      ; $84
;	db DITTO        ; $4C
;	db JYNX         ; $48
;	db TAUROS       ; $3C
;	db FARFETCHD    ; $40
;	db MAGMAR       ; $33
;	db ELECTABUZZ   ; $35
;	db MR_MIME      ; $2A
;	db HITMONLEE    ; $2B
;	db HITMONCHAN   ; $2C
;	db CHANSEY      ; $28
;	db ONIX         ; $22
;	db CHARMANDER    ; $B4
;	db ODDISH    ; $BB
;	db BELLSPROUT   ; $BE
;	db SPEAROW       ; $23
;	db RATTATA     ; $A6
;	db PONYTA     ; $A4
;	db BULBASAUR     ; $9A
;	db TENTACOOL   ; $9B
;	db GOLDEEN      ; $9E
;	db PIDGEY      ; $97
;	db STARYU      ; $98
;	db ABRA     ; $95
;	db GRIMER          ; $88
;	db KRABBY      ; $8A
;	db SHELLDER     ; $8B
;	db VOLTORB    ; $8D
;	db CLEFAIRY     ; $8E
;	db KOFFING      ; $8F
;	db MEOWTH      ; $90
;	db CUBONE      ; $91
;	db CATERPIE   ; $7D
;	db MACHOP      ; $7E
;	db PSYDUCK      ; $80
;	db DROWZEE        ; $81
;	db ZUBAT       ; $82
;	db WEEDLE     ; $72
;	db DODUO       ; $74
;	db MANKEY     ; $75
;	db DIGLETT      ; $76
;	db VENONAT     ; $77
;	db SEEL      ; $78
;	db POLIWAG    ; $6F
;	db EEVEE      ; $67
;	db EEVEE      ; $68
;	db EEVEE     ; $69
;	db JIGGLYPUFF   ; $65
;	db OMANYTE      ; $63
;	db SANDSHREW    ; $61
;	db HORSEA       ; $5D
;	db KABUTO     ; $5B
;	db DRATINI    ; $59
;	db PIKACHU       ; $55
;	db VULPIX    ; $53
;	db DRATINI    ; $42
;	db GEODUDE        ; $31
;	db MAGNEMITE     ; $36
;	db EKANS        ; $2D
;	db PARAS     ; $2E
;	db SQUIRTLE    ; $1C
;	db RHYHORN       ; $01
;	db NIDORAN_M     ; $07
;	db SLOWPOKE      ; $08
;	db EXEGGCUTE    ; $0A
;	db GASTLY       ; $0E
;	db NIDORAN_F    ; $10
;	db GROWLITHE     ; $14
;	db MAGIKARP     ; $16
;	db $00

