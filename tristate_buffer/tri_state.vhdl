----
-- Tri-State Buffer
------
library ieee;
use ieee.std_logic_1164.all;

entity TRI_STATE is
    port(
        x: in std_logic_vector (7 downto 0);
        en: in std_logic;
        y: out std_logic_vector (7 downto 0)
    );
end TRI_STATE;

architecture behaviour of TRI_STATE is
    begin
        tri_process: process (x,en)
        begin
            if en='1' then
                y <= x;
            else
                y <= "ZZZZZZZZ";
            end if;
        end process;
end behaviour;

-------------------------------------
-------------------------------------

----
-- Test Bench
----
library ieee;
use ieee.std_logic_1164.all;

entity TRI_STATE_TB is
    port(y: out std_logic_vector(7 downto 0));
end TRI_STATE_TB;

architecture behaviour of TRI_STATE_TB is
    signal x : std_logic_vector(7 downto 0) := "00000000";
    signal en : std_logic := '0';
    constant clk_period : time := 10 ns;
    
begin
    BUFFER1: entity work.TRI_STATE port map(x,en,y);

    TB_process: process
    begin
        x <= "11000011";
        en <= '1';
        wait for clk_period/2;
        en <= '0';
        wait for clk_period/2;
        en <= '1';
        wait for clk_period/2;
        assert false report "end of test" severity note;
        wait;
    end process;
end behaviour;

