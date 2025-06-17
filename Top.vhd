library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.all;
use work.vhdl_constants_all_layers_with_bias.all;
use work.Layer1_Weights.all;
use work.Layer4_6_Weights.all;

entity Top is
    Port (
        clk         : in  std_logic;
        input_data  : in  integer_vector(0 to 783);
        result      : out integer;
        layer6_out  : out integer_vector(0 to 9);
		layer1_out_dbg : out integer_vector(0 to 127);
		layer4_out_dbg : out integer_vector(0 to 63)
    );
end Top;

architecture Behavioral of Top is

    signal layer1_out : integer_vector(0 to 127);
    signal layer4_out : integer_vector(0 to 63);
    signal layer6_out_internal : integer_vector(0 to 9);
    signal argmax_result : integer;
    signal argmax_calculated : boolean := false;

    component Layer1
        Port (
            clk     : in  std_logic;
            inputs  : in  integer_vector(0 to 783);
            biases  : in bias_array_layer1;
            outputs : out integer_vector(0 to 127)
        );
    end component;

    component Layer4
        Port (
            clk     : in  std_logic;
            inputs  : in  integer_vector(0 to 127);
            weights : in weight_matrix_layer4_type;
            biases  : in bias_array_layer4;
            outputs : out integer_vector(0 to 63)
        );
    end component;

    component Layer6
        Port (
            clk     : in  std_logic;
            inputs  : in  integer_vector(0 to 63);
            weights : in weight_matrix_layer6_type;
            biases  : in bias_array_layer6;
            outputs : out integer_vector(0 to 9)
        );
    end component;

    component Argmax
        Port (
            clk     : in  std_logic;
            inputs  : in  integer_vector(0 to 9);
            result  : out integer
        );
    end component;

begin

    L1: Layer1
        Port map (
            clk     => clk,
            inputs  => input_data,
            biases  => layer1_biases,
            outputs => layer1_out
        );

    L4: Layer4
        Port map (
            clk     => clk,
            inputs  => layer1_out,
            weights => weight_matrix_layer4,
            biases  => layer4_biases,
            outputs => layer4_out
        );

    L6: Layer6
        Port map (
            clk     => clk,
            inputs  => layer4_out,
            weights => weight_matrix_layer6,
            biases  => layer6_biases,
            outputs => layer6_out_internal
        );

    A1: Argmax
        Port map (
            clk    => clk,
            inputs => layer6_out_internal,
            result => argmax_result
        );

    layer6_out <= layer6_out_internal;
    layer1_out_dbg <= layer1_out;
    layer4_out_dbg <= layer4_out;
    result <= argmax_result;

end Behavioral;
