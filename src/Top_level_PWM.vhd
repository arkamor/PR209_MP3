library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Top_Level_PWM IS
    PORT (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        odata  : out STD_LOGIC
    );

END Top_Level_PWM;

architecture Behavioral of Top_Level_PWM is

component ce_44100_gen
PORT (
    clk     : IN STD_LOGIC;
    rst     : IN STD_LOGIC;
    clk_out : OUT STD_LOGIC
);
end component;

component cpt_0_44099
PORT (
    clk     : IN STD_LOGIC;
    rst     : IN STD_LOGIC;
    ce      : IN STD_LOGIC;
    out_cpt : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
);
end component;

component wav_rom
PORT (
    CLOCK    : IN  STD_LOGIC;
    ADDR_R   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
    DATA_OUT : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
);
end component;

component PWM
PORT ( 
    clk   : in STD_LOGIC;
    rst   : in STD_LOGIC; 
    CE    : in STD_LOGIC;
    idata : in STD_LOGIC_VECTOR (10 downto 0);
    odata : out STD_LOGIC
);
end component;

SIGNAL int_ce     : STD_LOGIC;
SIGNAL int_cpt    : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL int_data   : STD_LOGIC_VECTOR(10 DOWNTO 0);

begin
  
    INST_ce_44100_gen: ce_44100_gen 
    port map(
        clk       => clk,
        rst       => rst,
        clk_out   => int_ce
    );

    INST_cpt_0_44099: cpt_0_44099 
    port map(
        clk       => clk,
        rst       => rst,
        ce        => int_ce,
        out_cpt   => int_cpt
    );

    INST_wav_rom: wav_rom 
    port map(
        CLOCK     => clk,
        ADDR_R    => int_cpt,
        DATA_OUT  => int_data
    );

    INST_PWM: PWM 
    port map(
        clk       => clk,
        rst       => rst,
        CE        => int_ce,
        idata     => int_data,
        odata     => odata
    );

end Behavioral;    
