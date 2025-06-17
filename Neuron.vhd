library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.all;



entity Neuron is
    generic (
        N : integer := 784  
    );
    port (
        clk     : in  std_logic;
        inputs  : in  integer_vector(0 to N-1);
        weights : in  integer_vector(0 to N-1);
        bias    : in  integer;
        output_y : out integer  
    );
end Neuron;

architecture Behavioral of Neuron is
    signal sum : integer := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            sum <= 0;
            for i in 0 to N-1 loop
                sum <= sum + inputs(i) * weights(i);
            end loop;
            sum <= (sum + bias);
            if sum < 0 then
                output_y <= 0;
            else
                output_y <= sum;
            end if;
        end if;
    end process;
end Behavioral;
