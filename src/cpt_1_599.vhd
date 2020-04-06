library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cpt_1_599 is
    Port (
        clk     : in STD_LOGIC;
        ce      : in STD_LOGIC;
        rst     : in STD_LOGIC;

        in_inc   : in STD_LOGIC;
        in_dec   : in STD_LOGIC;
        in_raz   : in STD_LOGIC;

        out_cpt : out STD_LOGIC_VECTOR (9 downto 0)
    );
end cpt_1_599;

architecture Behavioral of cpt_1_599 is

signal count : unsigned(9 DOWNTO 0) := "0000000000";

begin

   process (clk, rst) is
   begin

      IF (rst = '1') THEN
         count <= (others => '0');
      ELSIF( clk = '1' AND clk'event) THEN
         IF ( ce = '1') THEN
            IF ( in_raz = '1' ) THEN
            count <= (others => '0');
            ELSE
               IF ( in_inc = '1' ) THEN 
                  IF ( in_dec = '0' ) THEN
                     count <= count + 1;
                     IF( count = 600 ) THEN
                        count <= to_unsigned(1,10);
                     END IF;
                  ELSE
                     count <= count - 1;
                     IF( count = 0 ) THEN
                        count <= to_unsigned(599,10);
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;

   end process;

   out_cpt <= std_logic_vector(count);

end Behavioral;
