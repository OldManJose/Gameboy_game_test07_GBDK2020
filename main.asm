;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _performtDelay
	.globl _enemyAttack
	.globl _enemyHealhState
	.globl _shootArrow
	.globl _makecollision
	.globl _updateAnim
	.globl _set_sprite_data
	.globl _set_bkg_submap
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _speedR
	.globl _from
	.globl _shot
	.globl _counterR
	.globl _offset
	.globl _animation_tiles2
	.globl _animation_tiles
	.globl _onAnim
	.globl _town_001_map
	.globl _town_001_t
	.globl _Main_sprites
	.globl _faceing
	.globl _alive
	.globl _eHealth
	.globl _ii
	.globl _joy
	.globl _ePosY
	.globl _ePosX
	.globl _arrowS
	.globl _pPosY
	.globl _pPosX
	.globl _frame_count
	.globl _animation_counter
	.globl _tile_anim_count
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_tile_anim_count::
	.ds 1
_animation_counter::
	.ds 1
_frame_count::
	.ds 1
_pPosX::
	.ds 1
_pPosY::
	.ds 1
_arrowS::
	.ds 1
_ePosX::
	.ds 1
_ePosY::
	.ds 1
_joy::
	.ds 1
_ii::
	.ds 1
_eHealth::
	.ds 1
_alive::
	.ds 1
_faceing::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_Main_sprites::
	.ds 1280
_town_001_t::
	.ds 1200
_town_001_map::
	.ds 576
_onAnim::
	.ds 1
_animation_tiles::
	.ds 2
_animation_tiles2::
	.ds 2
_offset::
	.ds 1
_counterR::
	.ds 1
_shot::
	.ds 1
_from::
	.ds 1
_speedR::
	.ds 5
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;anim_control.c:15: void updateAnim(){
;	---------------------------------
; Function updateAnim
; ---------------------------------
_updateAnim::
;anim_control.c:16: frame_count++;
	ld	hl, #_frame_count
	inc	(hl)
;anim_control.c:19: if (frame_count >= FRAMES_TILL_ANIM_UPDATE) {
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00104$
;anim_control.c:22: frame_count = 0;
	ld	(hl), #0x00
;anim_control.c:25: animation_counter++;
	ld	hl, #_animation_counter
	inc	(hl)
;anim_control.c:26: if (animation_counter >= ANIM_COUNT_TILES){
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00102$
;anim_control.c:27: animation_counter = 0;}
	ld	(hl), #0x00
00102$:
;anim_control.c:30: set_sprite_tile(0, animation_tiles[animation_counter]);
	ld	bc, #_animation_tiles+0
	ld	a, c
	ld	hl, #_animation_counter
	add	a, (hl)
	ld	c, a
	jr	NC, 00128$
	inc	b
00128$:
	ld	a, (bc)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;anim_control.c:31: set_sprite_tile(1, animation_tiles2[animation_counter]);
	ld	bc, #_animation_tiles2+0
	ld	a, c
	ld	hl, #_animation_counter
	add	a, (hl)
	ld	c, a
	jr	NC, 00129$
	inc	b
00129$:
	ld	a, (bc)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), c
;anim_control.c:32: tile_anim_count++;
	ld	hl, #_tile_anim_count
	inc	(hl)
00104$:
;anim_control.c:34: if(tile_anim_count>=3){
	ld	a, (#_tile_anim_count)
	sub	a, #0x03
	ret	C
;anim_control.c:35: onAnim=0;
	ld	hl, #_onAnim
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
;anim_control.c:38: tile_anim_count=0;
	ld	hl, #_tile_anim_count
	ld	(hl), #0x00
;anim_control.c:41: }
	ret
;main.c:18: UBYTE makecollision(uint8_t pX, uint8_t pY, uint8_t eX, uint8_t eY){
;	---------------------------------
; Function makecollision
; ---------------------------------
_makecollision::
	add	sp, #-8
;main.c:19: return (pX >= eX && pX <= eX + 16) && (pY >= eY && pY <= eY + 8) || (eX >= pX && eX <= pX + 16) && (eY >= pY && eY <= pY + 16);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	C, 00108$
	pop	de
	push	de
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00152$
	bit	7, d
	jr	NZ, 00153$
	cp	a, a
	jr	00153$
00152$:
	bit	7, d
	jr	Z, 00153$
	scf
00153$:
	jr	C, 00108$
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	C, 00108$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00154$
	bit	7, d
	jr	NZ, 00155$
	cp	a, a
	jr	00155$
00154$:
	bit	7, d
	jr	Z, 00155$
	scf
00155$:
	jr	NC, 00104$
00108$:
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	C, 00103$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00156$
	bit	7, d
	jr	NZ, 00157$
	cp	a, a
	jr	00157$
00156$:
	bit	7, d
	jr	Z, 00157$
	scf
00157$:
	jr	C, 00103$
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	C, 00103$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00158$
	bit	7, d
	jr	NZ, 00159$
	cp	a, a
	jr	00159$
00158$:
	bit	7, d
	jr	Z, 00159$
	scf
00159$:
	jr	NC, 00104$
00103$:
	ld	e, #0x00
	jr	00105$
00104$:
	ld	e, #0x01
00105$:
;main.c:20: }
	add	sp, #8
	ret
;main.c:22: void shootArrow(){ //necesita correcion, la flecha ya dispara cuando el jugador aprieta el boton. Requiere de aparecer en
;	---------------------------------
; Function shootArrow
; ---------------------------------
_shootArrow::
;main.c:24: if(shot==1){
	ld	a, (#_shot)
	dec	a
	ret	NZ
;main.c:27: if(counterR<5){
	ld	hl, #_counterR
	ld	a, (hl)
	sub	a, #0x05
	jr	NC, 00102$
;main.c:28: counterR++;
	inc	(hl)
00102$:
;main.c:32: arrowS = arrowS + speedR[counterR];
	ld	hl, #_arrowS
	ld	c, (hl)
;main.c:30: if(faceing==1){
	ld	a, (#_faceing)
	dec	a
	jr	NZ, 00108$
;main.c:32: arrowS = arrowS + speedR[counterR];
	ld	de, #_speedR+0
	ld	a, e
	ld	hl, #_counterR
	add	a, (hl)
	ld	e, a
	jr	NC, 00158$
	inc	d
00158$:
	ld	a, (de)
	add	a, c
	ld	(#_arrowS),a
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 15) + 0)
;main.c:33: set_sprite_prop(3,get_sprite_prop(3) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 15)
	ld	(hl), c
;main.c:34: move_sprite(3,pPosX + arrowS,pPosY); 
	ld	hl, #_pPosY
	ld	c, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_arrowS
	add	a, (hl)
	ld	b, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:35: if(makecollision(pPosX + arrowS,pPosY,ePosX+12,ePosY)){
	ld	a, (#_ePosX)
	add	a, #0x0c
	ld	b, a
	ld	a, (#_pPosX)
	ld	hl, #_arrowS
	add	a, (hl)
	ld	hl, #_ePosY
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	ld	hl, #_pPosY
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_makecollision
	add	sp, #4
	ld	a, e
	or	a, a
	jp	Z, 00109$
;main.c:36: shot=0;
	ld	hl, #_shot
	ld	(hl), #0x00
;main.c:37: counterR=0;
	ld	hl, #_counterR
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;main.c:39: arrowS=0;
	ld	hl, #_arrowS
	ld	(hl), #0x00
;main.c:40: eHealth++;
	ld	hl, #_eHealth
	inc	(hl)
	jr	00109$
00108$:
;main.c:45: arrowS = arrowS - speedR[counterR];
	ld	de, #_speedR+0
	ld	a, e
	ld	hl, #_counterR
	add	a, (hl)
	ld	e, a
	jr	NC, 00159$
	inc	d
00159$:
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, b
	ld	(#_arrowS),a
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 15)
	ld	(hl), #0x20
;main.c:47: move_sprite(3,pPosX + arrowS,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_arrowS
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:48: if(makecollision(pPosX + arrowS,pPosY,ePosX+12,ePosY)){
	ld	a, (#_ePosX)
	add	a, #0x0c
	ld	b, a
	ld	a, (#_pPosX)
	ld	hl, #_arrowS
	add	a, (hl)
	ld	hl, #_ePosY
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	ld	hl, #_pPosY
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_makecollision
	add	sp, #4
	ld	a, e
	or	a, a
	jr	Z, 00109$
;main.c:49: shot=0;
	ld	hl, #_shot
	ld	(hl), #0x00
;main.c:50: counterR=0;
	ld	hl, #_counterR
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;main.c:52: arrowS=0;
	ld	hl, #_arrowS
	ld	(hl), #0x00
;main.c:53: eHealth++;
	ld	hl, #_eHealth
	inc	(hl)
00109$:
;main.c:56: if(counterR>=5){
	ld	a, (#_counterR)
	sub	a, #0x05
	ret	C
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;main.c:58: shot=0;
	ld	hl, #_shot
	ld	(hl), #0x00
;main.c:59: counterR=0;
	ld	hl, #_counterR
	ld	(hl), #0x00
;main.c:60: arrowS=0;
	ld	hl, #_arrowS
	ld	(hl), #0x00
;main.c:63: }
	ret
;main.c:65: void enemyHealhState(uint8_t state){
;	---------------------------------
; Function enemyHealhState
; ---------------------------------
_enemyHealhState::
;main.c:66: if(state == 0){
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x40
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x42
;main.c:68: set_sprite_tile(7,66);
00102$:
;main.c:70: if(state == 1){
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00104$
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x44
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x46
;main.c:72: set_sprite_tile(7,70);
00104$:
;main.c:74: if(state == 2){
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00106$
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x48
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x4a
;main.c:76: set_sprite_tile(7,74);
00106$:
;main.c:78: if(state == 3){
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00108$
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x4c
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x4e
;main.c:80: set_sprite_tile(7,78);
00108$:
;main.c:82: move_sprite(6,ePosX,ePosY-12);
	ld	a, (#_ePosY)
	add	a, #0xf4
	ld	b, a
	ld	hl, #_ePosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:83: move_sprite(7,ePosX+offset,ePosY-12);
	ld	a, (#_ePosY)
	add	a, #0xf4
	ld	b, a
	ld	a, (#_ePosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 28)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:84: if(state == 4){
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00110$
;c:/gbdk/include/gb/gb.h:1546: shadow_OAM[nb].y = 0;
	ld	hl, #(_shadow_OAM + 16)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 20)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 24)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 28)
	ld	(hl), #0x00
;main.c:89: ePosX=0;
	ld	hl, #_ePosX
	ld	(hl), #0x00
;main.c:90: ePosY=0;
	ld	hl, #_ePosY
	ld	(hl), #0x00
;main.c:91: alive=0;
	ld	hl, #_alive
	ld	(hl), #0x00
00110$:
;main.c:93: if(eHealth==4){
	ld	a, (#_eHealth)
	sub	a, #0x04
	ret	NZ
;main.c:94: eHealth=0;
	ld	hl, #_eHealth
	ld	(hl), #0x00
;main.c:96: }
	ret
;main.c:98: void enemyAttack(UBYTE on){ //necesita correción, el enemigo no alcanza al jugador y se retira después de que pasa cierto limite el jugador
;	---------------------------------
; Function enemyAttack
; ---------------------------------
_enemyAttack::
;main.c:99: if(on == 1){
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	ret	NZ
;main.c:100: if(ePosX >= 0 && from == 0){
	ld	a, (#_from)
	or	a, a
	jr	NZ, 00102$
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 19) + 0)
;main.c:101: set_sprite_prop(4,get_sprite_prop(4) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 19)
	ld	(hl), c
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 23) + 0)
;main.c:102: set_sprite_prop(5,get_sprite_prop(5) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 23)
	ld	(hl), c
;main.c:103: ePosX -= 4;
	ld	hl, #_ePosX
	ld	a, (hl)
	add	a, #0xfc
	ld	(hl), a
;main.c:104: move_sprite(4,ePosX,ePosY);
	ld	hl, #_ePosY
	ld	c, (hl)
	ld	hl, #_ePosX
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:105: move_sprite(5,ePosX+offset,ePosY);
	ld	hl, #_ePosY
	ld	c, (hl)
	ld	a, (#_ePosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	b, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:105: move_sprite(5,ePosX+offset,ePosY);
00102$:
;main.c:107: if(from==1){
	ld	a, (#_from)
	dec	a
	jr	NZ, 00105$
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 19)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 23)
	ld	(hl), #0x20
;main.c:110: ePosX += 4;
	ld	hl, #_ePosX
	ld	a, (hl)
	add	a, #0x04
	ld	(hl), a
;main.c:111: move_sprite(4,ePosX+offset,ePosY);
	ld	hl, #_ePosY
	ld	b, (hl)
	ld	a, (#_ePosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:112: move_sprite(5,ePosX,ePosY);
	ld	hl, #_ePosY
	ld	b, (hl)
	ld	hl, #_ePosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:112: move_sprite(5,ePosX,ePosY);
00105$:
;main.c:116: if(ePosX <= 0){
	ld	a, (#_ePosX)
	or	a, a
	jr	NZ, 00107$
;main.c:117: from = 1;
	ld	hl, #_from
	ld	(hl), #0x01
00107$:
;main.c:119: if(ePosX >= 152){
	ld	a, (#_ePosX)
	sub	a, #0x98
	ret	C
;main.c:120: from = 0;
	ld	hl, #_from
	ld	(hl), #0x00
;main.c:123: }
	ret
;main.c:125: void performtDelay(uint8_t delay){
;	---------------------------------
; Function performtDelay
; ---------------------------------
_performtDelay::
;main.c:126: for(ii=0; ii<delay;ii++)
	ld	hl, #_ii
	ld	(hl), #0x00
00103$:
	ld	a, (#_ii)
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:128: wait_vbl_done();
	call	_wait_vbl_done
;main.c:126: for(ii=0; ii<delay;ii++)
	ld	hl, #_ii
	inc	(hl)
;main.c:130: }
	jr	00103$
;main.c:132: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:133: pPosX = 8;
	ld	hl, #_pPosX
	ld	(hl), #0x08
;main.c:134: pPosY = 120;
	ld	hl, #_pPosY
	ld	(hl), #0x78
;main.c:136: ePosX = 152;
	ld	hl, #_ePosX
	ld	(hl), #0x98
;main.c:137: ePosY = 120;
	ld	hl, #_ePosY
	ld	(hl), #0x78
;main.c:139: counterR=0;
	ld	hl, #_counterR
	ld	(hl), #0x00
;main.c:141: arrowS=0;
	ld	hl, #_arrowS
	ld	(hl), #0x00
;main.c:143: alive=1;
	ld	hl, #_alive
	ld	(hl), #0x01
;main.c:144: faceing=1;
	ld	hl, #_faceing
	ld	(hl), #0x01
;main.c:145: set_bkg_data(0,75,town_001_t);
	ld	de, #_town_001_t
	push	de
	ld	hl, #0x4b00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:146: set_bkg_submap(0,0,32,18,town_001_map,town_001_mapWidth);
	ld	a, #0x20
	push	af
	inc	sp
	ld	de, #_town_001_map
	push	de
	ld	hl, #0x1220
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_submap
	add	sp, #7
;main.c:148: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;main.c:149: set_sprite_data(0,80,Main_sprites);
	ld	de, #_Main_sprites
	push	de
	ld	hl, #0x5000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x16
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x1c
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x1e
;c:/gbdk/include/gb/gb.h:1080: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x08
	ldh	(_SCY_REG + 0), a
;main.c:158: move_sprite(0,pPosX,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	hl, #_pPosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:159: move_sprite(1,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:160: move_sprite(2,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:162: move_sprite(4,ePosX,ePosY);
	ld	hl, #_ePosY
	ld	b, (hl)
	ld	hl, #_ePosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:163: move_sprite(5,ePosX+offset,ePosY);
	ld	hl, #_ePosY
	ld	b, (hl)
	ld	a, (#_ePosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:165: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:166: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:167: wait_vbl_done();
	call	_wait_vbl_done
;main.c:169: while(1){
00110$:
;main.c:170: joy= joypad();
	call	_joypad
	ld	hl, #_joy
	ld	(hl), e
;main.c:171: if(joy & J_RIGHT){
	ld	a, (hl)
	rrca
	jr	NC, 00102$
;main.c:172: pPosX++;
	ld	hl, #_pPosX
	inc	(hl)
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 3) + 0)
;main.c:173: set_sprite_prop(0,get_sprite_prop(0) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), c
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 7) + 0)
;main.c:174: set_sprite_prop(1,get_sprite_prop(1) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), c
;c:/gbdk/include/gb/gb.h:1503: return shadow_OAM[nb].prop;
	ld	a, (#(_shadow_OAM + 11) + 0)
;main.c:175: set_sprite_prop(2,get_sprite_prop(2) & ~S_FLIPX);
	ld	c, a
	res	5, c
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), c
;main.c:176: move_sprite(0,pPosX,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	hl, #_pPosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:177: move_sprite(1,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:178: move_sprite(2,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:179: faceing=1;
	ld	hl, #_faceing
	ld	(hl), #0x01
00102$:
;main.c:182: if(joy & J_LEFT){
	ld	a, (#_joy)
	bit	1, a
	jr	Z, 00104$
;main.c:183: pPosX--;
	ld	hl, #_pPosX
	dec	(hl)
;c:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), #0x20
;main.c:187: move_sprite(0,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:188: move_sprite(1,pPosX,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	hl, #_pPosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:189: move_sprite(2,pPosX,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	hl, #_pPosX
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:190: faceing=0;
	ld	hl, #_faceing
	ld	(hl), #0x00
00104$:
;main.c:193: if(joy & J_B){
	ld	a, (#_joy)
	bit	5, a
	jr	Z, 00106$
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x1a
;main.c:195: move_sprite(3,pPosX+offset,pPosY);
	ld	hl, #_pPosY
	ld	b, (hl)
	ld	a, (#_pPosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:196: shot=1;
	ld	hl, #_shot
	ld	(hl), #0x01
00106$:
;main.c:198: if(joy & J_A){
	ld	a, (#_joy)
	bit	4, a
	jr	Z, 00108$
;main.c:199: ePosX=152;
	ld	hl, #_ePosX
	ld	(hl), #0x98
;main.c:200: ePosY=120;
	ld	hl, #_ePosY
	ld	(hl), #0x78
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, #0x78
	ld	(hl+), a
	ld	(hl), #0x98
;main.c:202: move_sprite(5,ePosX+offset,ePosY);
	ld	hl, #_ePosY
	ld	b, (hl)
	ld	a, (#_ePosX)
	ld	hl, #_offset
	add	a, (hl)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:203: alive=1;
	ld	hl, #_alive
	ld	(hl), #0x01
00108$:
;main.c:205: shootArrow();
	call	_shootArrow
;main.c:206: enemyHealhState(eHealth);
	ld	a, (#_eHealth)
	push	af
	inc	sp
	call	_enemyHealhState
	inc	sp
;main.c:207: performtDelay(2);
	ld	a, #0x02
	push	af
	inc	sp
	call	_performtDelay
	inc	sp
;main.c:208: enemyAttack(alive);
	ld	a, (#_alive)
	push	af
	inc	sp
	call	_enemyAttack
	inc	sp
;main.c:210: }
	jp	00110$
	.area _CODE
	.area _INITIALIZER
__xinit__Main_sprites:
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x07	; 7
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x0d	; 13
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x40	; 64
	.db #0xb0	; 176
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0xb0	; 176
	.db #0xf0	; 240
	.db #0xb8	; 184
	.db #0xe0	; 224
	.db #0xb0	; 176
	.db #0xe0	; 224
	.db #0xb0	; 176
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x05	; 5
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x0d	; 13
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x06	; 6
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x40	; 64
	.db #0xb0	; 176
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0xa0	; 160
	.db #0xf0	; 240
	.db #0xb8	; 184
	.db #0xe0	; 224
	.db #0xb0	; 176
	.db #0xe0	; 224
	.db #0xb0	; 176
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x1f	; 31
	.db #0x1b	; 27
	.db #0x03	; 3
	.db #0x1e	; 30
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x50	; 80	'P'
	.db #0xd2	; 210
	.db #0xaa	; 170
	.db #0xf9	; 249
	.db #0xdd	; 221
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x1c	; 28
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x1f	; 31
	.db #0x1b	; 27
	.db #0x03	; 3
	.db #0x1e	; 30
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x50	; 80	'P'
	.db #0xd2	; 210
	.db #0xea	; 234
	.db #0xf9	; 249
	.db #0xdd	; 221
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x3f	; 63
	.db #0x36	; 54	'6'
	.db #0x07	; 7
	.db #0x3d	; 61
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0xa4	; 164
	.db #0xd4	; 212
	.db #0xf2	; 242
	.db #0xba	; 186
	.db #0xf8	; 248
	.db #0xe8	; 232
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x3f	; 63
	.db #0x36	; 54	'6'
	.db #0x07	; 7
	.db #0x3d	; 61
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0xa4	; 164
	.db #0xd4	; 212
	.db #0xf2	; 242
	.db #0xba	; 186
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x84	; 132
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf3	; 243
	.db #0xdc	; 220
	.db #0xfb	; 251
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x1d	; 29
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x1c	; 28
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x98	; 152
	.db #0xd8	; 216
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xe8	; 232
	.db #0xe8	; 232
	.db #0x70	; 112	'p'
	.db #0x90	; 144
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x64	; 100	'd'
	.db #0x9c	; 156
	.db #0xd8	; 216
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x09	; 9
	.db #0x19	; 25
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xf0	; 240
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xc0	; 192
	.db #0xf8	; 248
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x0e	; 14
	.db #0x05	; 5
	.db #0x1e	; 30
	.db #0x03	; 3
	.db #0x1e	; 30
	.db #0x05	; 5
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x1c	; 28
	.db #0x03	; 3
	.db #0x1d	; 29
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x1c	; 28
	.db #0x03	; 3
	.db #0x3f	; 63
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xb8	; 184
	.db #0xe0	; 224
	.db #0xb0	; 176
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xfa	; 250
	.db #0xfd	; 253
	.db #0xfd	; 253
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__town_001_t:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0xbf	; 191
	.db #0xd3	; 211
	.db #0xcf	; 207
	.db #0xfd	; 253
	.db #0xbf	; 191
	.db #0xd3	; 211
	.db #0xcf	; 207
	.db #0xd1	; 209
	.db #0x8f	; 143
	.db #0xfd	; 253
	.db #0xbf	; 191
	.db #0xd3	; 211
	.db #0xcf	; 207
	.db #0xd1	; 209
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1d	; 29
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xdc	; 220
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0xf3	; 243
	.db #0x0d	; 13
	.db #0xef	; 239
	.db #0x19	; 25
	.db #0xcf	; 207
	.db #0x29	; 41
	.db #0xdf	; 223
	.db #0x29	; 41
	.db #0xbf	; 191
	.db #0x49	; 73	'I'
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0x9b	; 155
	.db #0x49	; 73	'I'
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x1f	; 31
	.db #0x60	; 96
	.db #0xef	; 239
	.db #0x30	; 48	'0'
	.db #0xe7	; 231
	.db #0x28	; 40
	.db #0xf7	; 247
	.db #0x28	; 40
	.db #0xfb	; 251
	.db #0x24	; 36
	.db #0xfb	; 251
	.db #0xfc	; 252
	.db #0x6b	; 107	'k'
	.db #0x24	; 36
	.db #0xbf	; 191
	.db #0x49	; 73	'I'
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0x9b	; 155
	.db #0x49	; 73	'I'
	.db #0xbf	; 191
	.db #0x49	; 73	'I'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xfb	; 251
	.db #0x24	; 36
	.db #0xfb	; 251
	.db #0xfc	; 252
	.db #0xb3	; 179
	.db #0x24	; 36
	.db #0xfb	; 251
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x77	; 119	'w'
	.db #0x80	; 128
	.db #0x29	; 41
	.db #0x80	; 128
	.db #0x2a	; 42
	.db #0x80	; 128
	.db #0x2a	; 42
	.db #0x80	; 128
	.db #0x2c	; 44
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xee	; 238
	.db #0x01	; 1
	.db #0x94	; 148
	.db #0x01	; 1
	.db #0x54	; 84	'T'
	.db #0x01	; 1
	.db #0x54	; 84	'T'
	.db #0x01	; 1
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x24	; 36
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0x24	; 36
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0xf2	; 242
	.db #0x3d	; 61
	.db #0xce	; 206
	.db #0xf1	; 241
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0x62	; 98	'b'
	.db #0x9d	; 157
	.db #0x42	; 66	'B'
	.db #0xa5	; 165
	.db #0xc2	; 194
	.db #0x25	; 37
	.db #0x82	; 130
	.db #0x45	; 69	'E'
	.db #0x82	; 130
	.db #0x7d	; 125
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xc6	; 198
	.db #0x39	; 57	'9'
	.db #0x82	; 130
	.db #0x55	; 85	'U'
	.db #0x82	; 130
	.db #0x7d	; 125
	.db #0x82	; 130
	.db #0x55	; 85	'U'
	.db #0x82	; 130
	.db #0x7d	; 125
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xc7	; 199
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfb	; 251
	.db #0xf2	; 242
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xf6	; 246
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xf7	; 247
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xf6	; 246
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xe6	; 230
	.db #0x85	; 133
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0x86	; 134
	.db #0xe5	; 229
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xf7	; 247
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xf6	; 246
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xf6	; 246
	.db #0xf5	; 245
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xe6	; 230
	.db #0xc5	; 197
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0x87	; 135
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc7	; 199
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x4f	; 79	'O'
	.db #0xbc	; 188
	.db #0x73	; 115	's'
	.db #0x8f	; 143
	.db #0x7c	; 124
	.db #0x83	; 131
	.db #0x46	; 70	'F'
	.db #0xb9	; 185
	.db #0x42	; 66	'B'
	.db #0xa5	; 165
	.db #0x43	; 67	'C'
	.db #0xa4	; 164
	.db #0x41	; 65	'A'
	.db #0xa2	; 162
	.db #0x41	; 65	'A'
	.db #0xbe	; 190
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x63	; 99	'c'
	.db #0x9c	; 156
	.db #0x41	; 65	'A'
	.db #0xaa	; 170
	.db #0x41	; 65	'A'
	.db #0xbe	; 190
	.db #0x41	; 65	'A'
	.db #0xaa	; 170
	.db #0x41	; 65	'A'
	.db #0xbe	; 190
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xe3	; 227
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xdf	; 223
	.db #0x4f	; 79	'O'
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x6f	; 111	'o'
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0xef	; 239
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x6f	; 111	'o'
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x67	; 103	'g'
	.db #0xa1	; 161
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x61	; 97	'a'
	.db #0xa7	; 167
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0xef	; 239
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x6f	; 111	'o'
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x6f	; 111	'o'
	.db #0xaf	; 175
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x67	; 103	'g'
	.db #0xa3	; 163
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0xe1	; 225
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x3f	; 63
	.db #0x3e	; 62
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0xf8	; 248
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x78	; 120	'x'
	.db #0xfc	; 252
	.db #0x7c	; 124
	.db #0x07	; 7
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xdd	; 221
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x0a	; 10
	.db #0xa5	; 165
	.db #0x04	; 4
	.db #0xdb	; 219
	.db #0x24	; 36
	.db #0xdb	; 219
	.db #0x1a	; 26
	.db #0xa5	; 165
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0xa5	; 165
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xd0	; 208
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0xa5	; 165
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x7d	; 125
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x82	; 130
	.db #0x01	; 1
	.db #0x44	; 68	'D'
	.db #0x01	; 1
	.db #0x44	; 68	'D'
	.db #0x01	; 1
	.db #0x44	; 68	'D'
	.db #0x01	; 1
	.db #0x82	; 130
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x24	; 36
	.db #0x81	; 129
	.db #0x24	; 36
	.db #0x81	; 129
	.db #0x24	; 36
	.db #0x81	; 129
	.db #0x42	; 66	'B'
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x09	; 9
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x07	; 7
	.db #0x27	; 39
	.db #0x1f	; 31
	.db #0x2f	; 47
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xca	; 202
	.db #0xe7	; 231
	.db #0xda	; 218
	.db #0xa5	; 165
	.db #0xc2	; 194
	.db #0xbd	; 189
	.db #0xfe	; 254
	.db #0xc3	; 195
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x33	; 51	'3'
	.db #0x4c	; 76	'L'
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x94	; 148
	.db #0x80	; 128
	.db #0x96	; 150
	.db #0x80	; 128
	.db #0x95	; 149
	.db #0x80	; 128
	.db #0x94	; 148
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xa5	; 165
	.db #0x01	; 1
	.db #0xb5	; 181
	.db #0x01	; 1
	.db #0xad	; 173
	.db #0x01	; 1
	.db #0xa5	; 165
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
__xinit__town_001_map:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x02	; 2
	.db #0x46	; 70	'F'
	.db #0x48	; 72	'H'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x46	; 70	'F'
	.db #0x48	; 72	'H'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x46	; 70	'F'
	.db #0x48	; 72	'H'
	.db #0x02	; 2
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x47	; 71	'G'
	.db #0x49	; 73	'I'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x47	; 71	'G'
	.db #0x49	; 73	'I'
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x47	; 71	'G'
	.db #0x49	; 73	'I'
	.db #0x02	; 2
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x11	; 17
	.db #0x18	; 24
	.db #0x1b	; 27
	.db #0x21	; 33
	.db #0x14	; 20
	.db #0x11	; 17
	.db #0x18	; 24
	.db #0x1b	; 27
	.db #0x21	; 33
	.db #0x14	; 20
	.db #0x11	; 17
	.db #0x18	; 24
	.db #0x1b	; 27
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x23	; 35
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x23	; 35
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x15	; 21
	.db #0x12	; 18
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x21	; 33
	.db #0x15	; 21
	.db #0x12	; 18
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x21	; 33
	.db #0x15	; 21
	.db #0x12	; 18
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x24	; 36
	.db #0x29	; 41
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x24	; 36
	.db #0x29	; 41
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x16	; 22
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x16	; 22
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x16	; 22
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1d	; 29
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x39	; 57	'9'
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x39	; 57	'9'
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x17	; 23
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1e	; 30
	.db #0x21	; 33
	.db #0x17	; 23
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1e	; 30
	.db #0x21	; 33
	.db #0x17	; 23
	.db #0x13	; 19
	.db #0x1a	; 26
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
__xinit__onAnim:
	.db #0x00	; 0
__xinit__animation_tiles:
	.db #0x04	; 4
	.db #0x08	; 8
__xinit__animation_tiles2:
	.db #0x06	; 6
	.db #0x0a	; 10
__xinit__offset:
	.db #0x08	; 8
__xinit__counterR:
	.db #0x00	; 0
__xinit__shot:
	.db #0x00	; 0
__xinit__from:
	.db #0x00	; 0
__xinit__speedR:
	.db #0x40	;  64
	.db #0x34	;  52	'4'
	.db #0x20	;  32
	.db #0x10	;  16
	.db #0x08	;  8
	.area _CABS (ABS)
