---------------------------------------------------------
-- VHDL Counter RAM for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cpt_RAM is
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;
        
        inc     : IN STD_LOGIC;

        out_cpt : OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
    );
end cpt_RAM;

architecture Behavioral of cpt_RAM is

signal count : unsigned(17 DOWNTO 0) := (others => '0');

begin

    process (clk, rst) is
    begin

        IF (rst = '0') THEN
            count <= (others => '0');
        ELSIF( clk = '1' AND clk'event) THEN
            IF ( ce = '1') THEN
                IF(inc = '1') THEN
                    count <= count + 1;
                    IF (count = 262144) THEN
                        count <= (others => '0');
                    END IF;
                ELSE
                    IF (count = 0) THEN
                        count <= to_unsigned(262144-1,18);
                    END IF;
                    count <= count - 1;
                END IF;
            END IF;
        END IF;

    end process;

    out_cpt <= std_logic_vector(count);

end Behavioral;