library ieee;
use ieee.std_logic_1164.all;

entity COUNT is
    port (
        cnt : in std_logic;
        clear : in std_logic;
        clk : in std_logic;
        Q : out std_logic_vector(1 downto 0)
    );
end COUNT;

architecture behav of COUNT is
    signal pre_Q : std_logic_vector(1 downto 0) := "00";
begin
    process(clk)
    begin
        if (clk = '1' and clk'event) then
            if clear = '1' then
                pre_Q <= "00";
            elsif cnt = '1' then
                -- adds one
                pre_Q(0) <= pre_Q(0) xor '1';
                pre_Q(1) <= pre_Q(1) xor '0' xor (pre_Q(0) and '1');
            end if;
        end if;
    end process;
    
    Q <= pre_Q;

end behav;

--------
--------
library ieee;
use ieee.std_logic_1164.all;

entity COUNT_TB is
end COUNT_TB;

architecture behav of COUNT_TB is    
    signal count, clear, clk : std_logic;
    signal Q : std_logic_vector(1 downto 0);
    constant clk_t : time := 1 ns;
    begin

        CT0: entity work.COUNT port map (count,clear,clk,Q);

        clock : process
        begin
            for i in 1 to 20 loop
                clk <= '1';
                wait for clk_t/4;
                clk <= '0';
                wait for clk_t/4;
                wait for clk_t/2;
            end loop;

            assert false report "EoT" severity note;
            wait;
        end process;

        TB: process
        begin
            wait for clk_t;
            clear <= '1';
            count <= '0';
            wait for clk_t;
            clear <= '0';
            count <= '1';
            wait for 5*clk_t;
            clear <= '1';
            wait for clk_t;
            clear <= '0';
            wait for 5*clk_t;
            wait;
        end process;


end behav;