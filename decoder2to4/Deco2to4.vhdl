library ieee;
use ieee.std_logic_1164.all;

entity Decoder2_4 is
    port(
        x0, x1 : in std_logic;
        cs : in std_logic;
        y0, y1, y2, y3 : out std_logic
    );
end Decoder2_4;

-- Static behavior not process
architecture behaviour of Decoder2_4 is
    begin
        y0 <= (not x1) and (not x0) and cs;
        y1 <= (not x1) and (x0) and cs;
        y2 <= (x1) and (not x0) and cs;
        y3 <= x1 and x0 and cs;
end behaviour;


------------
------------

library ieee;
use ieee.std_logic_1164.all;

entity DecoderTB is
    port (y0, y1, y2, y3 : out std_logic);
end DecoderTB;

architecture behaviour of DecoderTB is
    signal x0 : std_logic := '0';
    signal x1 : std_logic := '0';
    signal cs : std_logic := '0';
    constant clk_period : time := 1 ns;

    begin

        D0 : entity work.Decoder2_4 port map (x0,x1,cs,y0,y1,y2,y3);

        process
        begin
            wait for clk_period;
            cs <= '1';
            wait for clk_period;
            x0 <= '1';
            wait for clk_period;
            x0 <= '0';
            x1 <= '1';
            wait for clk_period;
            x0 <= '1';
            wait for clk_period;
            assert false report "end of test" severity note;
            wait;
        end process;

end behaviour;