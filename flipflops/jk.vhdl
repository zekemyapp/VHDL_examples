library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is
    port(
        J,K : in std_logic;
        Q : out std_logic;
        clk : in std_logic
    );
end JK_FF;

architecture behav of JK_FF is
    signal buff_out : std_logic := '0';
begin
    process(J,K,clk)
    begin
        if (clk = '1' and clk'event) then
            if (J='1' and K='0') then
                buff_out <= '1';
            elsif (J='0' and K='1') then
                buff_out <= '0';
            elsif (J='1' and K='1') then
                buff_out <= not buff_out;
            end if;
        end if;
    end process;

    Q <= buff_out;
    
end behav;


library ieee;
use ieee.std_logic_1164.all;

entity JK_TB is
end JK_TB;

architecture behav of JK_TB is
    signal J,K : std_logic := 'Z';
    signal Q : std_logic;
    signal clk : std_logic := '0';
    constant clk_t : time := 1 ns;
begin

    JK0 : entity work.JK_FF port map (J,K,Q,clk);

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
        wait for clk_t/4;
        J <= '1';
        K <= '0';
        wait for clk_t;
        J <= '0';
        K <= '1';
        wait for clk_t;
        J <= '1';
        K <= '1';
        wait for clk_t;
        J <= '0';
        K <= '0';
        wait for clk_t;
        wait;
    end process;
end behav;
