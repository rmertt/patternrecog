library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Types is

  -- common types
  
  subtype pixel_value is integer range 0 to 255;
  type integer_vector is array (natural range <>) of pixel_value;
  
  type weight_matrix_type is array (natural range <>, natural range <>) of integer;



  -- weight dimensions for all neurons
  type weight_array_784 is array (0 to 783) of integer;  -- Layer 1
  type weight_array_128 is array (0 to 127) of integer;  -- Layer 4
  type weight_array_64  is array (0 to 63)  of integer;  -- Layer 6
  
  type weight_matrix_layer1_type is array (0 to 127) of weight_array_784;
  type weight_matrix_layer4_type is array (0 to 63)  of weight_array_128;
  type weight_matrix_layer6_type is array (0 to 9)   of weight_array_64;

  -- all bias series
  subtype bias_array_layer1 is integer_vector(0 to 127);
  subtype bias_array_layer4 is integer_vector(0 to 63);
  subtype bias_array_layer6 is integer_vector(0 to 9);

  


end package;

package body Types is
end package body;
