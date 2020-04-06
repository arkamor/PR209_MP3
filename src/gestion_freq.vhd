---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY gestion_freq IS
    PORT (
        
        clk : in std_logic;
        rst : in std_logic;
        
        output_10h : out std_logic;
        output_3k  : out std_logic

    );

END gestion_freq;

architecture Behavioral of gestion_freq is

    signal count_3k : unsigned(15 DOWNTO 0); 
    signal count_10h : unsigned(24 DOWNTO 0);

    signal out1, out2 : std_logic := '0';
    
begin
  
    PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF (rst = '1') then
            count_3k <= (others => '0');
            count_10h <= (others => '0');
        ELSIF clk'event AND clk = '1' THEN  -- rising clock edge
        
            count_3k  <= count_3k  + 1;
            count_10h <= count_10h + 1;
            
            IF (count_3k = 33332) THEN -- asynchronous reset
                count_3k <= (others => '0');
                IF (out2='0') THEN
                     out2 <= '1';
                ELSE
                     out2 <= '0';
                END IF;
            END IF;
            IF (count_10h = 9999999) THEN -- asynchronous reset
                count_10h <= (others => '0');
                IF (out1='0') THEN
                     out1 <= '1';
                ELSE
                     out1 <= '0';
                END IF;
                     
            END IF;
        END IF;
    END PROCESS;

    output_10h <= out1;
    output_3k <= out2;

end Behavioral;