library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_divider is
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;

        clk_out : OUT STD_LOGIC
        );
end clk_divider;

architecture Behavioral of clk_divider is

signal count: integer:=0;

begin

    process(clk, rst) is
    begin
        IF (rst='1') THEN
            count<=0;
            clk_out <= '0';
        ELSIF (clk'event and clk='1') THEN
            IF (count = 2266) THEN
                clk_out <= '1';
                count <= 0;
            ELSE 
                clk_out <= '0';
                count <=count+1;
            END IF;
        END IF;
    end process;

end Behavioral;