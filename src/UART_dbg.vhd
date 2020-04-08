library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_dbg is
    Port (
        clk     : in  STD_LOGIC;
        RsTx    : out STD_LOGIC
        --rst     : in STD_LOGIC;

        --in_val   : in STD_LOGIC_VECTOR(7 DOWNTO 0); -- 01100010 b or F
        --in_sta   : in STD_LOGIC
    );
end UART_dbg;

architecture Behavioral of UART_dbg is

signal count  : unsigned(3 DOWNTO 0) := (others => '0');
signal fr_div : unsigned(9 DOWNTO 0) := (others => '0'); --868
signal data   : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01100010";

begin

   process (clk) is
   begin

      --IF (rst = '0') THEN
      --   count <= (others => '0');
      IF( clk = '1' AND clk'event) THEN
          IF(fr_div = 868) THEN
            fr_div <= (others => '0');
          ELSE
            fr_div <= fr_div + 1;
            
            IF(count = 0) THEN
              RsTx <= '0';
              count <= count + 1;
            ELSIF(count = 9) THEN
              RsTx <= '1';
              count <= (others => '1');
            ELSE
              RsTx <= data(to_integer(count));
              count <= count + 1;
            END IF;
          END IF;
      END IF;
   end process;
end Behavioral;
