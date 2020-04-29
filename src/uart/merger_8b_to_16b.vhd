library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity merger_8b_to_16b is
    port (
      reset      : in  std_logic;
      clock      : in  std_logic;
      enable     : in  std_logic;
      data_in    : in  std_logic_vector ( 7 downto 0);
      
      data_out   : out std_logic_vector (15 downto 0);
      data_ready : out std_logic
      );
end merger_8b_to_16b;

architecture behavioral of merger_8b_to_16b is
    signal merged_data       : std_logic_vector (15 downto 0);
    signal half_packet_ready : std_logic := '0';
    signal packet_ready      : std_logic := '0';
begin

    process (reset, clock)
    begin
        if reset = '1' then
            merged_data       <= (others => '0');
            half_packet_ready <=  '0';
        elsif (clock'event and clock = '1') then
             if enable = '1' then
                 merged_data       <= data_in & merged_data(15 downto 8);
                 half_packet_ready <= not half_packet_ready;
             else
                 merged_data       <= merged_data;
                 half_packet_ready <= half_packet_ready;
             end if;
         end if;
     end process;

    process (reset, clock)
    begin
        if reset = '1' then
            packet_ready      <=  '0';
        elsif (clock'event and clock = '1') then
            packet_ready <= half_packet_ready and enable;
        end if;
    end process;
    
    data_out   <= merged_data;
    data_ready <= packet_ready;

end behavioral;