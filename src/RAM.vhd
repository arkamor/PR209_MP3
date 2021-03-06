---------------------------------------------------------
-- VHDL RAM for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RAM IS
PORT (
      CLOCK    : IN  STD_LOGIC;

      W_E      : IN  STD_LOGIC;

      ADDR_W   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      DATA_IN  : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);

      ADDR_R   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      DATA_OUT : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
END RAM;

ARCHITECTURE Behavioral OF RAM IS

  --TYPE ram_type IS ARRAY (RAM_ADDR_BITS-1 DOWNTO 0) OF SIGNED (10 DOWNTO 0);
  TYPE ram_type IS ARRAY (0 TO 2**18-1-1) OF SIGNED (10 DOWNTO 0);
  SIGNAL memory : ram_type := (others => TO_SIGNED(0,11));

  -- QUELQUES PETITES MODIFICATIONS FAITES POUR AIDER VIVADO A FAIRE LES BONS
  -- CHOIX D'IMPLEMENTATION...

  ATTRIBUTE RAM_STYLE : string;
  ATTRIBUTE RAM_STYLE of memory: signal is "BLOCK";

BEGIN

  PROCESS (CLOCK)
  BEGIN
    IF (CLOCK'event AND CLOCK = '1') THEN
        IF (W_E = '1') THEN
            memory(to_integer(UNSIGNED(ADDR_R))) <= signed(DATA_IN);
        ELSE
            DATA_OUT <= std_logic_vector(memory(to_integer(UNSIGNED(ADDR_R))));
        END IF;
    END IF;
  END PROCESS;
  
END Behavioral;