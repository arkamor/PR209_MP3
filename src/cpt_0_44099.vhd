library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cpt_0_44099 is
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;

        out_cpt : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
end cpt_0_44099;

architecture Behavioral of cpt_0_44099 is

signal count : unsigned(15 DOWNTO 0) := (others => '0');

begin

   process (clk, rst) is
   begin

      IF (rst = '0') THEN
         count <= (others => '0');
      ELSIF( clk = '1' AND clk'event) THEN
         IF ( ce = '1') THEN
            IF ( count = 44099 ) THEN
                count <= (others => '0');
            ELSE
                count <= count + 1;
            END IF;
         END IF;
      END IF;

   end process;

   out_cpt <= std_logic_vector(count);

end Behavioral;