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
        output_k3  : out std_logic

    );

END gestion_freq;

architecture Behavioral of gestion_freq is

    signal count_3k : unsigned(15 DOWNTO 0) := (others => '0'); 
    signal count_10h : unsigned(24 DOWNTO 0) := (others => '0');

    signal out1, out2 : std_logic := '0';
    
begin
  
    PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF (rst = '1') then
            count_3k <= (others => '0');
            count_10h <= (others => '0');
        ELSIF clk'event AND clk = '1' THEN  -- rising clock edge
            IF (count_3k = 33333) THEN -- asynchronous reset
                count_3k <= (others => '0');
                out1 <= not out1;
            ELSIF (count_10h = 10000000) THEN -- asynchronous reset
                count_10h <= (others => '0');
                out2 <= not out2;
            END IF;
        END IF;
    END PROCESS;

    output_10h <= out1;
    output_10h <= out2;

end Behavioral;