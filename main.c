#include <gb/gb.h>

#include "main_sprites.c"
#include "town_t_001.c"
#include "twon_m_001.c"
#include "anim_control.c"

uint8_t pPosX, pPosY,offset=8,arrowS,ePosX, ePosY,joy,ii, eHealth;

UBYTE shot=0,from=0, alive,faceing;

int8_t speedR[5]={
    64,52,32,16,8
};

UBYTE makecollision(uint8_t pX, uint8_t pY, uint8_t eX, uint8_t eY){
    return (pX >= eX && pX <= eX + 16) && (pY >= eY && pY <= eY + 8) || (eX >= pX && eX <= pX + 16) && (eY >= pY && eY <= pY + 16);
}

void shootArrow(){ //necesita correcion, la flecha ya dispara cuando el jugador aprieta el boton. Requiere de aparecer en
//la posicion del jugador y dispararse
    static uint8_t counterR;
    if(shot){
        
        
        if(counterR<5){//Si el contador es menor a 5, se aumenta uno al contador para pasar al siguiente valor del arreglo de SpeedRow
        counterR++;
        }
        if(faceing){ 
            speedR[counterR];
            arrowS = arrowS + speedR[counterR];
            set_sprite_prop(3,get_sprite_prop(3) & ~S_FLIPX);
            move_sprite(3,pPosX + arrowS,pPosY); 
            if(makecollision(pPosX + arrowS,pPosY,ePosX+12,ePosY)){ //Si hace colisi�n con el enemigo, la flecha desaparece y se le hace da�o al enemigo
                shot=0;
                counterR=0;
                move_sprite(3,0,0);
                arrowS=0;
                eHealth++;
                }
            }
        else{//Si faceing es igual a 0, entonces la felcha ir� al lado al que est�
            speedR[counterR];
            arrowS -= speedR[counterR];
            set_sprite_prop(3,S_FLIPX);
            move_sprite(3,pPosX + arrowS,pPosY);
            if(makecollision(pPosX + arrowS,pPosY,ePosX+12,ePosY)){
                shot=0;
                counterR=0;
                move_sprite(3,0,0);
                arrowS=0;
                eHealth++;
                }
            }
    					//en caso contrario de que no ocurra colisi�n, la flecha avanza hasta desaparecer 
        if(counterR>=5){//Si el contador es mayor o igual a 5, el contador se reinicia, junto con el disparo y la velocidad de la flecha, la flecha desparece.
            move_sprite(3,0,0);
            shot=0;
            counterR=0;
            arrowS=0;
        }
    }
}

void enemyHealhState(uint8_t state){
    if(state == 0){
    set_sprite_tile(6,64);
    set_sprite_tile(7,66);
    }
    if(state == 1){
    set_sprite_tile(6,68);
    set_sprite_tile(7,70);
    }
    if(state == 2){
    set_sprite_tile(6,72);
    set_sprite_tile(7,74);
    }
    if(state == 3){
    set_sprite_tile(6,76);
    set_sprite_tile(7,78);
    }
    move_sprite(6,ePosX,ePosY-12);
    move_sprite(7,ePosX+offset,ePosY-12);
    if(state == 4){
        hide_sprite(4);
        hide_sprite(5);
        hide_sprite(6);
        hide_sprite(7);
        ePosX=0;
        ePosY=0;
        alive=0;
    }
    if(eHealth==4){
        eHealth=0;
    }
}

void enemyAttack(UBYTE on){ //necesita correción, el enemigo no alcanza al jugador y se retira después de que pasa cierto limite el jugador
    if(on == 1){
        if(ePosX >= 0 && from == 0){
        set_sprite_prop(4,get_sprite_prop(4) & ~S_FLIPX);
        set_sprite_prop(5,get_sprite_prop(5) & ~S_FLIPX);
        ePosX -= 4;
        move_sprite(4,ePosX,ePosY);
        move_sprite(5,ePosX+offset,ePosY);
        }
        if(from==1){
        set_sprite_prop(4,S_FLIPX);
        set_sprite_prop(5,S_FLIPX);
        ePosX += 4;
        move_sprite(4,ePosX+offset,ePosY);
        move_sprite(5,ePosX,ePosY);

        }

        if(ePosX <= 0){
            from = 1;
         } 
        if(ePosX >= 152){
            from = 0;
            }
    }
}

void performtDelay(uint8_t delay){
    for(ii=0; ii<delay;ii++)
    {
        wait_vbl_done();
    }
}

void main(){
    pPosX = 8;
    pPosY = 120;

    ePosX = 152;
    ePosY = 120;
    speedR[0];
    arrowS=0;

    alive=1;
    faceing=1;
    set_bkg_data(0,75,town_001_t);
    set_bkg_submap(0,0,32,18,town_001_map,town_001_mapWidth);

    SPRITES_8x16;
    set_sprite_data(0,80,Main_sprites);
    set_sprite_tile(0,0);//Player
    set_sprite_tile(1,2);
    set_sprite_tile(2,22);

    set_sprite_tile(4,28);// Enemy
    set_sprite_tile(5,30);

    move_bkg(0,8);
    move_sprite(0,pPosX,pPosY);
    move_sprite(1,pPosX+offset,pPosY);
    move_sprite(2,pPosX+offset,pPosY);

    move_sprite(4,ePosX,ePosY);
    move_sprite(5,ePosX+offset,ePosY);

    SHOW_SPRITES;
    SHOW_BKG;
    wait_vbl_done();

    while(1){
        joy= joypad();
        if(joy & J_RIGHT){
            pPosX++;
            set_sprite_prop(0,get_sprite_prop(0) & ~S_FLIPX);
            set_sprite_prop(1,get_sprite_prop(1) & ~S_FLIPX);
            set_sprite_prop(2,get_sprite_prop(2) & ~S_FLIPX);
            move_sprite(0,pPosX,pPosY);
            move_sprite(1,pPosX+offset,pPosY);
            move_sprite(2,pPosX+offset,pPosY);
            faceing=1;
        }

        if(joy & J_LEFT){
            pPosX--;
            set_sprite_prop(0,S_FLIPX);
            set_sprite_prop(1,S_FLIPX);
            set_sprite_prop(2,S_FLIPX);
            move_sprite(0,pPosX+offset,pPosY);
            move_sprite(1,pPosX,pPosY);
            move_sprite(2,pPosX,pPosY);
            faceing=0;
        }

        if(joy & J_B){
            set_sprite_tile(3,26);
            move_sprite(3,pPosX+offset,pPosY);
            shot=1;
        }
        if(joy & J_A){
            ePosX=152;
            ePosY=120;
            move_sprite(4,ePosX,ePosY);
            move_sprite(5,ePosX+offset,ePosY);
            alive=1;
        }
        shootArrow();
        enemyHealhState(eHealth);
        performtDelay(2);
        enemyAttack(alive);
    }
}
