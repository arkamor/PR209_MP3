---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Top_Level_Partie2 IS
    PORT (
        btnCpuReset : in STD_LOGIC;
        
        clk : in  STD_LOGIC;
        
        ampPWM : out STD_LOGIC;
        ampSD  : out STD_LOGIC
        
    );

END Top_Level_Partie2;

architecture Behavioral of Top_Level_Partie2 is


component CE_gen_44100
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;

        clk_out : OUT STD_LOGIC
        );
end component;

component PWM
    Port (
        clk     : in STD_LOGIC;
        ce_441  : in STD_LOGIC;
        rst     : in STD_LOGIC;

        i_data : in STD_LOGIC_VECTOR(10 DOWNTO 0);
        
        o_data : out STD_LOGIC;
                
        o_data_en : out STD_LOGIC
    );
end component;

component cpt_0_44099
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;

        out_cpt : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
end component;

component wav_rom
PORT (
      CLOCK          : IN  STD_LOGIC;
      ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
end component;

--
SIGNAL int_CE_44100  : STD_LOGIC;
SIGNAL int_cpt_44100 : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL int_mem_out   : STD_LOGIC_VECTOR(10 DOWNTO 0);

begin
  
CE_gen_44100_i: CE_gen_44100 
port map(
    clk     => clk,
    rst     => btnCpuReset,
    clk_out => int_CE_44100
);   

cpt_0_44099_i: cpt_0_44099 
port map(
    clk     => clk,
    rst     => btnCpuReset,
    ce      => int_CE_44100,
    out_cpt => int_cpt_44100
);

wav_rom_i: wav_rom 
port map(
    CLOCK    => clk,
    ADDR_R   => int_cpt_44100,
    DATA_OUT => int_mem_out
);

PWM_i: PWM 
port map(
    clk       => clk,
    ce_441    => int_CE_44100,
    rst       => btnCpuReset,
    i_data    => int_mem_out,
    o_data    => ampPWM,
    o_data_en => ampSD
);

end Behavioral;