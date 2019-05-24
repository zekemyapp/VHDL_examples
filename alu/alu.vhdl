library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A,B : in std_logic_vector (3 downto 0);
        opt : in std_logic_vector (1 downto 0);
        res : out std_logic_vector (3 downto 0)
    );
end ALU;

architecture behav of ALU is
begin
    process(A,B,opt)
    begin
        case opt is
            when "00" => -- Add
                res <= std_logic_vector(unsigned(A) + unsigned(B));
            when "01" => -- Substract
                res <= std_logic_vector(unsigned(A) + unsigned((not B)) + 1);
            when "10" => -- AND
                res <= A and B;
            when "11" => -- OR
                res <= A or B;
            when others =>
                res <= "ZZZZ";
        end case;
    end process;
end behav;


------
------
library ieee;
use ieee.std_logic_1164.all;

entity ALU_TB is
end ALU_TB;

architecture behav of ALU_TB is
    signal A : std_logic_vector (3 downto 0) := "0101";
    signal B : std_logic_vector (3 downto 0) := "0011";
    signal opt : std_logic_vector (1 downto 0) := "ZZ";
    signal res : std_logic_vector (3 downto 0);
    constant clk : time := 1 ns;

    begin
        ALU0: entity work.ALU port map (A,B,opt,res);
        process
        begin
            wait for clk;
            opt <= "00";
            wait for clk;
            opt <= "01";
            wait for clk;
            opt <= "10";
            wait for clk;
            opt <= "11";
            wait for clk;
            assert false report "EoT" severity note;
            wait;
        end process;
end behav; 