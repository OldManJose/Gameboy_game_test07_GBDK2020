#include <gb/gb.h>
#define FRAMES_TILL_ANIM_UPDATE  2
// Number of animation tiles
// (could use sizeof(animation_tiles), but keeping this simple for now)
#define ANIM_COUNT_TILES  2
#define ENEMY_ANIM_COUNT_TILES  4

uint8_t tile_anim_count, animation_counter, frame_count;

UBYTE onAnim=0;

uint8_t animation_tiles[ANIM_COUNT_TILES] = {4,8};
uint8_t animation_tiles2[ANIM_COUNT_TILES] = {6,10};

void updateAnim(){
    frame_count++;

        // If the frame counter reached the threshold, update the animation
        if (frame_count >= FRAMES_TILL_ANIM_UPDATE) {

            // Reset frame counter
            frame_count = 0;

            // move to next animation tile, wrap around if at the end of the list (zero indexed)
            animation_counter++;
            if (animation_counter >= ANIM_COUNT_TILES){
                animation_counter = 0;}

            // Set the animation frame
            set_sprite_tile(0, animation_tiles[animation_counter]);
            set_sprite_tile(1, animation_tiles2[animation_counter]);
            tile_anim_count++;
        }
        if(tile_anim_count>=3){
            onAnim=0;
            set_sprite_tile(0,0);
            set_sprite_tile(1,2);
            tile_anim_count=0;
        }
        
}