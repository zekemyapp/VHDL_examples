library ieee;
use ieee.std_logic_1164.all;

entity LATCH is
    port(
        input : in std_logic;
        output : out std_logic;
        clk : in std_logic
    );
end LATCH;

architecture behav of LATCH is
begin
    process(input, clk)
    begin
        if clk = '1' then -- if we add "and clk'event" it works as a D Flip-Flop
            output <= input;
        end if;
    end process;
end behav;


library ieee;
use ieee.std_logic_1164.all;

entity LATCH_TB is
end LATCH_TB;

architecture behav of LATCH_TB is
    signal input : std_logic;
    signal output : std_logic;
    signal clk : std_logic;
    constant clk_t : time := 1 ns;
begin

    L0 : entity work.LATCH port map (input,output,clk);

    process
    begin
        wait for clk_t;
        input <= '0';
        clk <= '1';
        wait for clk_t;
        input <= '1';
        wait for clk_t;
        clk <= '0';
        wait for clk_t;
        input <= '0';
        wait for clk_t;
        clk <= '1';
        wait for clk_t;
        clk <= '0';
        wait for clk_t;
        assert false report "EoT" severity note;
        wait;
    end process;
end behav;
