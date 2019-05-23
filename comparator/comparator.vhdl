library ieee;
use ieee.std_logic_1164.all;

entity COMP is
    port(
        A,B : in std_logic_vector (3 downto 0);
        eq,gt,lt : out std_logic
    );
end COMP;

architecture behav of COMP is
    begin
        process(A,B)
        begin
            eq <= '0';
            gt <= '0';
            lt <= '0';

            if B=A then
                eq <= '1';
            elsif B<A then
                lt <= '1';
            else
                gt <= '1';
            end if;
        end process;
end behav;

-----------------
-----------------
library ieee;
use ieee.std_logic_1164.all;

entity COMP_TB is
end COMP_TB;

architecture behav of COMP_TB is
    signal A,B : std_logic_vector(3 downto 0) := "ZZZZ" ;
    signal eq,gt,lt : std_logic := '0';
    constant clk : time := 1 ns;

    begin
        CP: entity work.COMP port map (A,B,eq,gt,lt);

        process
        begin
            wait for clk;
            A <= x"3";
            B <= x"0";
            wait for clk;
            B <= x"1";
            wait for clk;
            B <= x"2";
            wait for clk;
            B <= x"3";
            wait for clk;
            B <= x"4";
            wait for clk;
            A <= x"6";
            B <= x"0";
            wait for clk;
            assert false report "EoT" severity note;
            wait;
        end process;

end behav;