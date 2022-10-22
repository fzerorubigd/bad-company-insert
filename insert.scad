include <bit/boardgame_insert_toolkit_lib.2.scad>;

// determines whether lids are output.
g_b_print_lid = f;

// determines whether boxes are output.
g_b_print_box = true; 

// Focus on one box
g_isolated_print_box = ""; 

// Used to visualize how all of the boxes fit together. 
g_b_visualization = f;          
        
// this is the outer wall thickness. 
//Default = 1.5mm
g_wall_thickness = 1.5;

// The tolerance value is extra space put between planes of the lid and box that fit together.
// Increase the tolerance to loosen the fit and decrease it to tighten it.
//
// Note that the tolerance is applied exclusively to the lid.
// So if the lid is too tight or too loose, change this value ( up for looser fit, down for tighter fit ) and 
// you only need to reprint the lid.
// 
// The exception is the stackable box, where the bottom of the box is the lid of the box below,
// in which case the tolerance also affects that box bottom.
//
g_tolerance = 0.15;

// This adjusts the position of the lid detents downward. 
// The larger the value, the bigger the gap between the lid and the box.
g_tolerance_detents_pos = 0.1;
g_lid_solid = true;

lid_attr = [[ LID_SOLID_B, g_lid_solid]];


box_width = 107;
box_height = 288;
box_depth = 47;

heist_width = 68;
heist_height = 89;

gang_width = 44;
gang_height = 69;

money_width = 45;
sleeve_fit = 7;

comp_width = box_height - (money_width+2*g_wall_thickness) - (heist_width+sleeve_fit+2*g_wall_thickness) - (gang_height+sleeve_fit+2*g_wall_thickness);

dice_width = comp_width-2*g_wall_thickness;
dice_height = 19;
car_height = 30;
extra = box_width-5*g_wall_thickness-dice_height-car_height-dice_height;

data =
[
    [   "money_top",
        [
            [ BOX_SIZE_XYZ, [box_width, money_width+2*g_wall_thickness, box_depth/2+g_wall_thickness]],      
            [ BOX_LID,
                lid_attr,
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ box_width-2*g_wall_thickness, money_width,box_depth/2] ],   
                ]
            ]
        ]
    ],
    [   "tick_down",
        [
            [ BOX_SIZE_XYZ, [box_width, money_width+2*g_wall_thickness, box_depth/2+g_wall_thickness] ],
            [ BOX_STACKABLE_B, true],
            [ BOX_NO_LID_B, true],   
            [ BOX_COMPONENT,
                [
                    [CMP_COMPARTMENT_SIZE_XYZ,  [ box_width-2*g_wall_thickness, money_width, box_depth/2]],
                ]
            ],  
        ]
    ],
    [   "heist_cards",
        [
            [ BOX_SIZE_XYZ, [box_width, heist_width+sleeve_fit, box_depth+g_wall_thickness]],      
            [ BOX_LID,
                lid_attr,
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ box_width-2*g_wall_thickness, heist_width+sleeve_fit-2*g_wall_thickness, box_depth] ],  
                   [CMP_CUTOUT_SIDES_4B,                   [f,f,t,t]],
                  
                [ CMP_CUTOUT_TYPE, BOTH ] 
                ]
            ]
        ]
    ],
    [   "small_cards",
        [
            [ BOX_SIZE_XYZ, [box_width, gang_height+sleeve_fit, box_depth+g_wall_thickness]],      
            [ BOX_LID,
                lid_attr,
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ gang_width+sleeve_fit, gang_height+sleeve_fit-2*g_wall_thickness, box_depth] ],
                    [POSITION_XY,                           [0,0]],  
                    [CMP_CUTOUT_SIDES_4B,                   [t,t,f,f]],
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                    [ CMP_COMPARTMENT_SIZE_XYZ, [ gang_width+sleeve_fit, gang_height+sleeve_fit-2*g_wall_thickness, box_depth] ],
                    [POSITION_XY,                           [gang_width+sleeve_fit+g_wall_thickness,0]],  
                    [CMP_CUTOUT_SIDES_4B,                   [t,t,f,f]],
                ]
            ]
        ]
    ],
    [ "components",
        [
            [ BOX_SIZE_XYZ, [box_width, comp_width, box_depth/2+g_wall_thickness]],      
            [ BOX_LID,
                lid_attr,
            ],
            [ BOX_COMPONENT,                             
                [
                   [ CMP_COMPARTMENT_SIZE_XYZ, [ dice_height, dice_width, box_depth-g_wall_thickness] ],  
                   [POSITION_XY,                           [0,CENTER]],   
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                   [ CMP_COMPARTMENT_SIZE_XYZ, [ car_height, dice_width, box_depth-g_wall_thickness] ],  
                   [POSITION_XY,                           [dice_height+g_wall_thickness,CENTER]],   
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                   [ CMP_COMPARTMENT_SIZE_XYZ, [ dice_height, dice_width, box_depth-g_wall_thickness] ],  
                   [POSITION_XY,                           [dice_height+car_height+2*g_wall_thickness,CENTER]],   
                ]
            ],
            [ BOX_COMPONENT,                             
                [
                   [ CMP_COMPARTMENT_SIZE_XYZ, [ extra, dice_width, box_depth-g_wall_thickness] ],  
                   [POSITION_XY,                           [2*dice_height+car_height+3*g_wall_thickness,CENTER]],   
                ]
            ]
        ]],
         [   "components_optional",
        [
            [ BOX_SIZE_XYZ, [box_width, comp_width, box_depth/2+g_wall_thickness] ],
            [ BOX_STACKABLE_B, true],
            [ BOX_NO_LID_B, true],   
            [ BOX_COMPONENT,
                [
                    [CMP_COMPARTMENT_SIZE_XYZ,  [ box_width-2*g_wall_thickness, comp_width-2*g_wall_thickness, box_depth/2+g_wall_thickness ],],
                    [ CMP_CUTOUT_BOTTOM_B, true ],
                ]
            ], 
        ]
    ]
];


MakeAll();