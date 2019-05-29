library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    port(
        a : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        o : out std_logic
    );
end FSM;

architecture behav of FSM is
    type state_t is (S0,S1,S2,S3);
    
begin
    process(clk)
    variable next_state, current_state : state_t;
    begin
        if (clk = '1' and clk'event) then

            if reset = '1' then
                current_state := S0;
            else 
                current_state := next_state;
            end if;
            
            case current_state is
                when S0 =>
                    o <= '0';
                    if a='1' then
                        next_state := S1;
                    else
                        next_state := S0;
                    end if;
                when S1 =>
                    o <= '0';
                    if a='1' then
                        next_state := S2;
                    else
                        next_state := S1;
                    end if;
                when S2 =>
                    o <= '0';
                    if a='1' then
                        next_state := S3;
                    else
                        next_state := S2;
                    end if;
                when S3 =>
                    o <= '1';
                    if a='1' then
                        next_state := S0;
                    else
                        next_state := S3;
                    end if;
                when others =>
                    o <= '0';
                    next_state := S0;
            end case;

            

        end if;
    end process;
end behav;

architecture behav2 of FSM is
    type state_t is (S0,S1,S2,S3);
    signal next_state, current_state : state_t;
    
begin
    p0: process(clk)
    begin
        if (clk = '1' and clk'event) then
            if reset = '1' then
                current_state <= S0;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;

    p1: process(current_state,a)
    begin
        case current_state is
            when S0 =>
                o <= '0';
                if a='1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                o <= '0';
                if a='1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when S2 =>
                o <= '0';
                if a='1' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                o <= '1';
                if a='1' then
                    next_state <= S0;
                else
                    next_state <= S3;
                end if;
            when others =>
                o <= '0';
                next_state <= S0;
        end case;
    end process;
end behav2;


---------------
---------------
library ieee;
use ieee.std_logic_1164.all;

entity FSM_TB is
end FSM_TB;

architecture behav of FSM_TB is
    signal a : std_logic;
    signal clk : std_logic;
    signal reset : std_logic;
    signal o : std_logic;
    constant clk_t : time := 1 ns;

    begin
        FSM0 : entity work.FSM(behav2) port map (a,clk,reset,o);

        clock : process
        begin
            for i in 1 to 20 loop
                clk <= '1';
                wait for clk_t/4;
                clk <= '0';
                wait for clk_t/4;
            end loop;

            assert false report "EoT" severity note;
            wait;
        end process;

        process
        begin
            reset <= '1';
            wait for clk_t;
            reset <= '0';
            a <= '0';
            wait for clk_t;            
            a <= '1';
            wait for 5*clk_t;
            reset <= '1';
            wait for clk_t;
            wait;

            
        end process;

end behav;