---------------------------------------------------------
-- VHDL Volume manager for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Volume_Manager is
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;

        volume  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        idata   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);

        odata   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
        );
end Volume_Manager;

architecture Behavioral of Volume_Manager is

begin

    process(clk, rst) is
    begin
        IF (rst='0') THEN
            odata <= (others => '0');
        ELSIF (clk'event and clk='1') THEN
            IF ( ce = '1') THEN
                odata <= std_logic_vector(signed(idata)/2**(9-to_integer(unsigned(volume))));
            END IF;
        END IF;
    end process;

    
end Behavioral;
