library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
    Port (
        clk     : in STD_LOGIC;
        ce_441  : in STD_LOGIC;
        rst     : in STD_LOGIC;

        i_data : in STD_LOGIC_VECTOR(10 DOWNTO 0);
        
        o_data : out STD_LOGIC;
                
        o_data_en : out STD_LOGIC
    );
end PWM;

architecture Behavioral of PWM is

    signal count   : UNSIGNED(11 DOWNTO 0) := (others => '0');
    signal out_val : STD_LOGIC; 
    
    signal u_data  : STD_LOGIC_VECTOR(11 DOWNTO 0);


begin

   process (clk, rst) is
   begin

      IF (rst = '0') THEN
         count <= (others => '0');
      ELSIF( clk = '1' AND clk'event) THEN
         IF (ce_441 = '1') THEN
            count <= (others => '0');
         ELSE
            IF count > unsigned(u_data) THEN
                out_val <= '0';
            ELSE
                out_val <= '1';
            END IF;
            
            count <= count + 1;
         END IF;
      END IF;

   end process;
   
   process(i_data) is
   begin
      u_data <= std_logic_vector(to_unsigned((to_integer(signed(i_data))+1024)*2267/2048,12));
   end process;

   o_data <= out_val;
   o_data_en <= '1';

end Behavioral;
