#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
//#include "hUGEDriver.h"

#include "interior_church_tiles.c"
#include "interior_church_L_map.c"
#include "main_sprites.c"

#define camera_max_y ((interior_L_mapHeight-18)*8)
#define camera_max_x ((interior_L_mapWidth-20)*8)

#define MIN(A,B) ((A)<(B)?(A):(B))

uint8_t joy, floorPosition;
uint16_t indexTLx, indexTLy, tileIndexTL;
    // current and old positiones of the camera in pexels
uint16_t camera_x, camera_y, old_camera_x, old_camera_y;
    // current and old position of the map in tiles
uint8_t map_pos_x, map_pos_y, old_map_pos_x, old_map_pos_y;
    // redraw flag, indicates that camera position was changed
uint8_t redraw;
    //tile de plataforma
unsigned char platform[3] = {0x19,0x1A,0x1B};
    //posición del jugador
uint16_t player_posX, player_posY;
    //Arreglos para salto y caida
//uint8_t jump_speed[5]= {-32,-24,-16,-8,-4};
//uint8_t fall_speed[5]= {4,8,16,24,32};
    //habilitar salto y caida
UBYTE jumpE, fallE, collide;
    //contador
uint8_t boost;
    //canción de fondo
//extern const hUGESong_t cathedral_level;

void set_camera(){
    //se actualiza el registro que realiza el scroll de la pantalla
    SCY_REG = camera_y; SCX_REG = camera_x;
    //arriba o abajo
        map_pos_y = (uint8_t)(camera_y >> 3u); //Esta linea es para decir que "map_pos_y= camera_y/8" Estamos actualizando los valores para que coincidan con el indice del tile
    if(map_pos_y != old_map_pos_y){ //cuando se inicializan las variables, map_pos_y es igual a 0 y old_map_pos_y es igual a 255 por lo que permite cumplir la condición
        if(camera_y < old_camera_y){
            set_bkg_submap(map_pos_x, map_pos_y,MIN(21u,interior_L_mapWidth-map_pos_x),1,interior_L_map,interior_L_mapWidth);
        }
        else{
            if((interior_L_mapHeight - 18u) > map_pos_y) set_bkg_submap(map_pos_x, map_pos_y+18u, MIN(21u,interior_L_mapWidth-map_pos_x),1,interior_L_map,interior_L_mapWidth);
        }
        //Actualizamos la posición actual del mapa en Y
        old_map_pos_y = map_pos_y;
    }
    //izquierda o derecha 
        map_pos_x = (uint8_t)(camera_x >> 3u);
    if(map_pos_x != old_map_pos_x){
        if(camera_x < old_camera_x){
            set_bkg_submap(map_pos_x, map_pos_y, 1, MIN(19u, interior_L_mapHeight - map_pos_y), interior_L_map, interior_L_mapWidth);
        }
        else{
            if((interior_L_mapWidth - 20u) > map_pos_x) set_bkg_submap(map_pos_x + 20u, map_pos_y, 1,MIN(19u,interior_L_mapHeight-map_pos_y),interior_L_map,interior_L_mapWidth);
        }
        //Actualizamos la posición del mapa en X
        old_map_pos_x = map_pos_x;
    }
    //Actualizamos la posición de la cámara
    old_camera_x = camera_x, old_camera_y = camera_y;
}

uint16_t index_calculation(uint16_t worldmap_Pos_x, uint16_t worldmap_Pos_y){//usamos esto para calculcar. Probablemente necesitemos un offset para hacer el calculo correcto. 
    //El scroll es más lento que lo que se mueve el personaje, por lo tanto, visualmente el indice no coincide para las colisiones.
    //La camará debe seguir al jugador, no al revés
    indexTLx = worldmap_Pos_x >> 3; //Se divide entre 8 el valor de la posicion del jugador en x 
    indexTLy = worldmap_Pos_y >> 3; //Se divide entre 8 el valor de la posicion del jugador en y
    tileIndexTL = indexTLy + (indexTLx*interior_L_mapWidth); //el 20 representa el ancho del mapa
    
    /*if(indexTLx >= interior_L_mapWidth){
        return TRUE;
    }

    if(indexTLy >= interior_L_mapHeight){
        return TRUE;
    }*/
    return tileIndexTL;
}

/*void jump(){ //¿Cuando se detiene el salto? Cuando se llegue al tamaño del arreglo o cuando haga contacto con una plataforma por debajo de esta.
    player_posY += jump_speed[boost];
    if(jumpE){//Si es habilitada la caída, solo se podrá saltar nuevamente si se hace contacto con el suelo o alguna plataforma
        move_sprite(2,player_posX,player_posY);//esta linea solo ejemplifica lo que debe de hacerse en teoría
    }
    if(boost<5){
        boost++;
    }
}*/

/*void fall(){//¿Cuando se detiene la caída? Cuando haga contacto con el suelo o una plataforma.

}*/

/*uint8_t isTochingGrass(uint16_t projectSurf){
    if(projectSurf >= floorPosition){
        return floorPosition;
    }
    return -1;
}*/

void main(){
    DISPLAY_OFF;
        //incializamso registros de audio
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
        //comenzamos canción
    //hUGE_init(&cathedral_level);
    //add_VBL(hUGE_dosound);
    SPRITES_8x16;
    set_sprite_data(0,19, Main_sprites);
    set_sprite_tile(0,0);
    set_sprite_tile(1,2);
    SHOW_BKG;
    SHOW_SPRITES;
    set_bkg_data(0,47u,interior_tiles);
    map_pos_x = player_posX = 0;
    old_map_pos_x = 255;
    old_map_pos_y = 255;
    set_bkg_submap(map_pos_x, map_pos_y, 20,32,interior_L_map,interior_L_mapWidth);
    wait_vbl_done();
    DISPLAY_ON;
    player_posX=28;
    player_posY=120;
    
    camera_x = player_posX-16;
    camera_y = player_posY-8;
    move_sprite(0,player_posX,player_posY);
    move_sprite(1,player_posX+8,player_posY);
    old_camera_x = camera_x; old_camera_y = camera_y;

    redraw = FALSE;

    SCX_REG = camera_x; SCY_REG = camera_y;
    
    set_camera();

    
    
    //Esta variable guarda si hay una colición con el Background en los tiles 25, 26 y 27 correspondientes a las plataformas.
        
        //Se debe evitar que el jugador atraviese la plataforma desde abajo. (Actualizar la posición del jugador en X y X cuando ocurra la colisión, así se sabrá el punto donde toca la plataforma)
        //El jugador, si está en caída libre, no debe traspasar la plataforma. 
        //Si el jugador toca una plataforma, se resetea la capacidad de saltar(Solo si está por encima de la misma).
        //Por lo tanto, la plataforma debe ser un objeto solido. 
        //player_posX = el momento donde hace contacto con la plataforma
        //Todo el tiempo debe estar activa la gravedad, así siempre se estará comprobando si el personaje está cayendo o ha tocado el suelo
    

    while(TRUE){
        joy = joypad();

        if(joy & J_UP){
            if(camera_y){
                camera_y--;
                player_posY--;
                //player_posY = player_posY >> 3u;
                redraw = TRUE;
                //move_sprite(0,player_posX,player_posY);
                //move_sprite(1,player_posX+8,player_posY);
            }
        } else if (joy & J_DOWN){
            if(camera_y < camera_max_y){
                camera_y++;
                player_posY++;
                //player_posY = player_posY >> 3u;
                redraw=TRUE;
                //move_sprite(0,player_posX,player_posY);
                //move_sprite(1,player_posX+8,player_posY);

            }
        }

        if (joy & J_LEFT) {
            if (camera_x) {
                camera_x--;
                player_posX--;
                //player_posX = player_posX >> 3u;
                redraw = TRUE;
                //move_sprite(0,player_posX,player_posY);
                //move_sprite(1,player_posX+8,player_posY);

            }
        } else if (joy & J_RIGHT){
            if(camera_x < camera_max_x){
                camera_x++;
                player_posX++;
                // "player_posX = player_posX >> 3u;" // con esto el personaje se mueve a la misma velocidad que la camara, pero solo genera números enteros positivos. 
                //también no permite que se recorra los valores, se reinician al mismo valor. Probablemente porque lo almacenamos en la misma variable
                redraw = TRUE;
                //move_sprite(0,player_posX,player_posY);
                //move_sprite(1,player_posX+8,player_posY);
            }
        }
        if (interior_L_map[index_calculation(player_posX+16,player_posY+96)] == platform[0] || interior_L_map[index_calculation(player_posX+16,player_posY+96)] == platform[1] || interior_L_map[index_calculation(player_posX+16,player_posY+96)] == platform[2]){
            printf("collision at %u %u %u", (uint16_t)(indexTLx),(uint16_t)(indexTLy),(uint16_t)(tileIndexTL));
        }//Funciona pero de manera inesperada (Hemos decidido no usar la funcion move_sprite)
        if(joy & J_A){
            index_calculation(player_posX+16,player_posY+96);
            printf("EStoy en %u %u %u", (uint16_t)(indexTLx),(uint16_t)(indexTLy),(uint16_t)(tileIndexTL));
        }
        if(redraw){
            wait_vbl_done();
            set_camera();
            redraw=FALSE;
        } else wait_vbl_done();
    }

}
