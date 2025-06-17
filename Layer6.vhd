library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.all;
use work.vhdl_constants_all_layers_with_bias.all;
use work.Layer4_6_Weights.all;

entity Layer6 is
    port (
        clk     : in  std_logic;
        inputs  : in  integer_vector(0 to 63);
		weights : in  weight_matrix_layer6_type;
        biases  : in  bias_array_layer6;
        outputs : out integer_vector(0 to 9)
    );
end Layer6;

architecture Behavioral of Layer6 is
    signal sums : integer_vector(0 to 9);
begin
    process(clk)
        variable temp_sum : integer;
    begin
        if rising_edge(clk) then
            for n in 0 to 9 loop
                temp_sum := 0;
                for i in 0 to 63 loop
                    temp_sum := temp_sum + inputs(i) * weights(n)(i);
                end loop;
                temp_sum := temp_sum + biases(n);
                if temp_sum < 0 then
                    sums(n) <= 0;
                else
                    sums(n) <= temp_sum;
                end if;
            end loop;
        end if;
    end process;
    outputs <= sums;
end Behavioral;