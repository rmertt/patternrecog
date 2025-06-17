library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.all;
use work.vhdl_constants_all_layers_with_bias.all;
use work.Layer1_Weights.all;

entity Layer1 is
    port (
        clk     : in  std_logic;
        inputs  : in  integer_vector(0 to 783);
        biases  : in  bias_array_layer1;
        outputs : out integer_vector(0 to 127)
    );
end Layer1;

architecture Behavioral of Layer1 is
begin
    process(clk)
        variable sum : integer;
    begin
        if rising_edge(clk) then
            for n in 0 to 127 loop
                sum := 0;
                for i in 0 to 783 loop
                    sum := sum + inputs(i) * weight_matrix_layer1(n)(i);
                end loop;
                sum := sum + biases(n);
                
                if sum < 0 then
                    outputs(n) <= 0;
                else
                    outputs(n) <= sum;
                end if;
            end loop;
        end if;
    end process;
end Behavioral;
