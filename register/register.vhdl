library ieee;
use ieee.std_logic_1164.all;

entity REG is
    port(
        data_in : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(3 downto 0);
        load,clear,clk : in std_logic
    );
end REG;

architecture behav of REG is
begin
    process(clk)
    variable load_clear : std_logic_vector(1 downto 0);
    begin
        load_clear := load & clear;

        if(clk = '1' and clk'event) then
            case load_clear is
            when "10" =>
                data_out <= data_in;
            when "01" =>
                data_out <= "0000";
            when others =>
                data_out <= "UUUU";
            end case;
        end if;

    end process;
end behav;


--------------
--------------
library ieee;
use ieee.std_logic_1164.all;

entity REG_TB is
end REG_TB;

architecture behav of REG_TB is
    signal A : std_logic_vector(3 downto 0);
    signal O : std_logic_vector(3 downto 0);
    signal load,clear,clk : std_logic;
    signal clk_t : time := 1 ns;
begin

    REG0: entity work.REG port map (A,O,load,clear,clk);

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
        A <= "0011";
        wait for clk_t;
        load <= '1';
        clear <= '0';
        wait for clk_t;
        load <= '0';
        clear <= '1';
        wait for clk_t;
        wait;
    end process;


end behav;
