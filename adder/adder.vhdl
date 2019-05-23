library ieee;
use ieee.std_logic_1164.all;

entity BIT_ADDER is
    port (
        A,B : in std_logic;
        sum : out std_logic;
        carry : out std_logic
    );
end BIT_ADDER;

architecture behaviour of BIT_ADDER is
    begin
        sum <= A xor B;
        carry <= A and B;
end behaviour;

------------
------------
library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER_2bit is
    port (
        A,B : in std_logic_vector(1 downto 0);
        sum : out std_logic_vector(1 downto 0);
        carry : out std_logic
    );
end FULL_ADDER_2bit;

architecture behav of FULL_ADDER_2bit is
    signal carry_ha0 : std_logic := '0';
    signal carry_ha1 : std_logic := '0';
    signal carry_ha2 : std_logic := '0';
    signal sum_ha1 : std_logic := '0';

    begin
    HA0: entity work.BIT_ADDER port map(A(0),B(0),sum(0),carry_ha0);
    HA1: entity work.BIT_ADDER port map(A(1),B(1),sum_ha1,carry_ha1);
    HA2: entity work.BIT_ADDER port map(sum_ha1,carry_ha0,sum(1),carry_ha2);

    carry <= carry_ha1 or carry_ha2;
end behav;


--------
--------

library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER_TB is
    port(
        sum : out std_logic_vector(1 downto 0);
        carry : out std_logic
    );
end FULL_ADDER_TB;


architecture behav of FULL_ADDER_TB is
    signal A : std_logic_vector(1 downto 0) := "00";
    signal B : std_logic_vector(1 downto 0) := "00";
    constant clk_period : time := 1 ns;

    begin
        FA: entity work.FULL_ADDER_2bit port map(A,B,sum,carry);

        process
        begin
            wait for clk_period;
            A <= "01";
            B <= "10";
            wait for clk_period;
            A <= "11";
            B <= "11";
            wait for clk_period;
            A <= "01";
            B <= "01";
            wait for clk_period;
            assert false report "end of test" severity note;
            wait;
        end process;
end behav;
