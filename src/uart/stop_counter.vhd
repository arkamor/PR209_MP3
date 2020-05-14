LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY stop_counter IS
    PORT (
      RESET     : IN  STD_LOGIC;
      CLOCK     : IN  STD_LOGIC;
      ENABLE    : IN  STD_LOGIC;
      DATA_OUT  : OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
      );
END stop_counter;

ARCHITECTURE Behavioral OF stop_counter IS
	CONSTANT MAX_ADDR : INTEGER := 2**18 - 1;
	SIGNAL   COMPTEUR : INTEGER RANGE 0 TO MAX_ADDR := 0;
BEGIN

  --
  -- COMPTEUR POUR L'ECRITURE DU CONTENU AUDIO
  --
    PROCESS (RESET, CLOCK)
    BEGIN
        IF RESET = '1' THEN
            COMPTEUR <= 0;
        ELSIF (CLOCK'event AND CLOCK = '1') THEN
            IF ENABLE = '1' THEN
                IF COMPTEUR = MAX_ADDR THEN
				    COMPTEUR <= MAX_ADDR;
				ELSE
				    COMPTEUR <= COMPTEUR + 1;
				END IF;
		    ELSE
                COMPTEUR <= COMPTEUR;
            END IF;
        END IF;
    END PROCESS;

  DATA_OUT <= STD_LOGIC_VECTOR( TO_UNSIGNED(COMPTEUR, 18) );

END Behavioral;