library ieee;
use ieee.std_logic_1164.all;

entity SHIFT_REG is
    port(
        data_in : in std_logic;
        data_out : out std_logic;
        clk : in std_logic
    );
end SHIFT_REG;

architecture behav of SHIFT_REG is
    signal tmp_out : std_logic := 'U';
begin
    process(clk)
    begin
        if(clk = '1' and clk'event) then
            tmp_out <= data_in;
            data_out <= tmp_out;
        end if;

    end process;
end behav;


--------------
--------------
library ieee;
use ieee.std_logic_1164.all;

entity SHIFT_TB is
end SHIFT_TB;

architecture behav of SHIFT_TB is
    signal A : std_logic := '0';
    signal O : std_logic;
    signal clk : std_logic := '0';
    signal clk_t : time := 1 ns;
begin

    REG0: entity work.SHIFT_REG port map (A,O,clk);

    clock : process
    begin
        for i in 1 to 10 loop
            clk <= '1';
            wait for clk_t/4;
            clk <= '0';
            wait for clk_t/4;
            wait for clk_t/2;
        end loop;

        assert false report "EoT" severity note;
        wait;
    end process;

    TB : process
    begin
        wait for clk_t;
        A <= '0';
        wait for clk_t;
        A <= '1';
        wait for 2*clk_t;
        A <= '0';
        wait for clk_t;
        A <= '1';
        wait for clk_t;
        wait;
    end process;


end behav;
