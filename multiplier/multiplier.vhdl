library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MULTI is
    port(
        A,B : in std_logic_vector(1 downto 0);
        result: out std_logic_vector(3 downto 0)
    );
end MULTI;

architecture behav of MULTI is
begin
    process(A,B)
    variable mult1 : std_logic_vector(2 downto 0);
    variable mult2 : std_logic_vector(5 downto 0);
    begin
        mult1 := '0' & A;
        mult2 := "0000" & B;

        for i in 1 to 3 loop
            if mult2(0) = '1' then
                mult2(5 downto 3) := std_logic_vector(unsigned(mult2(5 downto 3)) + unsigned(mult1(2 downto 0)));
            end if;
            mult2(5 downto 0) := '0' & mult2(5 downto 1);
        end loop;

        result <= mult2 (3 downto 0);
    end process;
end behav;

---------
---------
library ieee;
use ieee.std_logic_1164.all;

entity MULTI_TB is
end MULTI_TB;

architecture behav of MULTI_TB is
    signal A,B : std_logic_vector(1 downto 0) := "00";
    signal result : std_logic_vector(3 downto 0);
    constant clk : time := 1 ns;
begin

    MUL0 : entity work.MULTI port map (A,B,result);

    process
    begin
        wait for clk;
        A <= "01";
        B <= "10";
        wait for clk;
        A <= "11";
        B <= "10";
        wait for clk;
        A <= "11";
        B <= "11";
        wait for clk;
        assert false report "EoT" severity note;
        wait;
    end process;
end behav;