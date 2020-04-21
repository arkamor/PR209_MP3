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

signal tmp : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');

begin

    process(clk, rst) is
    begin
        IF (rst='0') THEN
            tmp <= (others => '0');
        ELSIF (clk'event and clk='1') THEN
            IF ( ce = '1') THEN
                tmp <= (others => '0');
                tmp <= idata(10-to_integer(unsigned(volume)) DOWNTO to_integer(unsigned(volume)));
            END IF;
        END IF;
    end process;
    
    odata <= tmp;

end Behavioral;
