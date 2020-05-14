---------------------------------------------------------
-- VHDL Counter 1 to 9 for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpt_1_9 is
    Port (
        clk     : in STD_LOGIC;
        ce      : in STD_LOGIC;
        rst     : in STD_LOGIC;

        in_inc   : in STD_LOGIC;
        in_dec   : in STD_LOGIC;
        in_raz   : in STD_LOGIC;

        out_cpt : out STD_LOGIC_VECTOR (3 downto 0)
    );
end cpt_1_9;

architecture Behavioral of cpt_1_9 is

signal count : unsigned(3 DOWNTO 0) := "0101"; 

begin

   process (clk, rst) is
   begin

      IF (rst = '0') THEN
         count <= "0101";
      ELSIF( clk = '1' AND clk'event) THEN
         IF ( in_raz = '1' ) THEN
            count <= "0101";
         ELSIF(ce = '1') THEN
            IF ( in_inc = '1' ) THEN
               IF ( count < 9 ) THEN
                  count <= count + 1;
               END IF;
            ELSIF ( in_dec = '1') THEN
               IF ( count > 1 ) THEN
                  count <= count - 1;
               END IF;
            END IF;
         END IF;
      END IF;

   end process;

   out_cpt <= std_logic_vector(count);

end Behavioral;
