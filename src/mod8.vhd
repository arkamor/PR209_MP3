---------------------------------------------------------
-- VHDL mod8 for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY mod8 IS
    PORT (
        clk : in std_logic;
        rst : in std_logic;
        ce  : in std_logic;

        an      : out std_logic_vector(7 DOWNTO 0);
        seg_com : out std_logic_vector(2 DOWNTO 0)
    );

END mod8;

architecture Behavioral of mod8 is

    signal counter : unsigned(2 DOWNTO 0) := "000"; 


begin
  
    main:PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF (rst='0') THEN -- asynchronous reset
            counter <= (others => '0');
        ELSIF clk'event AND clk = '1' THEN  -- rising clock edge
            IF ce = '1' THEN
                counter <= counter + 1; 
            END IF;
        END IF;
    END PROCESS main;

    seg_com <= std_logic_vector(counter);

    process(counter)
        variable tmp: std_logic_vector(7 downto 0);
    begin
        tmp := (others => '0');
        tmp(to_integer(counter)) := '1';
        an <= tmp xor "11111111";
    end process;

end Behavioral;