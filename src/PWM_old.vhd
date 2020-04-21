library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
    Port (
        clk     : in STD_LOGIC;
        ce_441  : in STD_LOGIC;
        rst     : in STD_LOGIC;

        i_data : in STD_LOGIC_VECTOR(11 DOWNTO 0);
        
        o_data : out STD_LOGIC
    );
end PWM;

architecture Behavioral of PWM is

    signal count   : UNSIGNED(11 DOWNTO 0) := (others => 'O'); 
    signal out_val : STD_LOGIC; 


begin

   process (clk, rst) is
   begin

      IF (rst = '0') THEN
         count <= (others => 'O');
      ELSIF( clk = '1' AND clk'event) THEN
         IF (ce = '1' ) THEN
            count <= (others => 'O');
         ELSE
            count <= count + 1;
            IF count > unsigned(i_data) THEN
                out_val <= '0';
            ELSE
                out_val <= '1';
            END IF;
         END IF;
      END IF;

   end process;

   o_data <= out_val;

end Behavioral;
