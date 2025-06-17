library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Types.all;

entity Argmax is
    Port (
        clk     : in  std_logic;
        inputs  : in  integer_vector(0 to 9);
        result  : out integer
    );
end Argmax;

architecture Behavioral of Argmax is
    signal idx     : integer := 0;
    signal max_val : integer := 0;
    signal calculated : boolean := false;
    signal prev_inputs : integer_vector(0 to 9) := (others => 0);
begin
    process(clk)
        variable temp_val : integer;
        variable temp_idx : integer;
    begin
        if rising_edge(clk) then
            -- reset calculation if inputs changed
            if inputs /= prev_inputs then
                calculated <= false;
                prev_inputs <= inputs;
            end if;

            if not calculated then
                temp_val := inputs(0);
                temp_idx := 0;
                for i in 1 to 9 loop
                    if inputs(i) > temp_val then
                        temp_val := inputs(i);
                        temp_idx := i;
                    end if;
                end loop;
                max_val <= temp_val;
                idx <= temp_idx;
                calculated <= true;
            end if;
        end if;
    end process;

    result <= idx;
end Behavioral;