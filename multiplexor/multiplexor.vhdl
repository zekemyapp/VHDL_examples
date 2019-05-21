----------------
--- Multiplexor
----------------
library ieee;
use ieee.std_logic_1164.all;

entity MUX is
    port(
        x0,x1,x2,x3 : in std_logic_vector(2 downto 0);
        sel : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(2 downto 0)
    );
end MUX;

architecture behaviour of MUX is
begin
    process(x0,x1,x2,x3,sel)
    begin
        case sel is
            when "00" =>    y <= x0;
            when "01" =>    y <= x1;
            when "10" =>    y <= x2;
            when "11" =>    y <= x3;
            when others =>  y <= "ZZZ";
        end case;
    end process;
end behaviour;

---------------
-- Testbench
---------------
library ieee;
use ieee.std_logic_1164.all;

entity MUX_TB is
    port(y : out std_logic_vector(2 downto 0));
end MUX_TB;

architecture behaviour of MUX_TB is
    signal x0 : std_logic_vector(2 downto 0) := "001";
    signal x1 : std_logic_vector(2 downto 0) := "010";
    signal x2 : std_logic_vector(2 downto 0) := "011";
    signal x3 : std_logic_vector(2 downto 0) := "100";
    signal sel : std_logic_vector(1 downto 0) := "UU";
    constant clk_period : time := 1 ns;
begin

    MUX0: entity work.MUX port map(x0,x1,x2,x3,sel,y);

    process
    begin
        wait for clk_period;
        sel <="00";
        wait for clk_period;
        sel <="01";
        wait for clk_period;
        sel <="10";
        wait for clk_period;
        sel <="11";
        wait for clk_period;
        sel <="UU";
        wait for clk_period;
        assert false report "end of test" severity note;
        wait;
    end process;
end behaviour;
