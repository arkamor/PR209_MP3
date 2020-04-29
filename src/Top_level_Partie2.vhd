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
        
        RsRx : in STD_LOGIC;
        
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

component cpt_RAM
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;

        out_cpt : OUT STD_LOGIC_VECTOR (21 DOWNTO 0)
    );
end component;

component RAM
PORT (
      CLOCK          : IN  STD_LOGIC;

      W_E      : IN  STD_LOGIC;
      
      ADDR_W         : IN  STD_LOGIC_VECTOR(21 DOWNTO 0);
      DATA_IN        : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);

      ADDR_R         : IN  STD_LOGIC_VECTOR(21 DOWNTO 0);
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
end component;

component full_UART_recv
    PORT (
        clk_100MHz  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        rx          : in  STD_LOGIC;

        memory_addr : out STD_LOGIC_VECTOR (21 downto 0);
        data_value  : out STD_LOGIC_VECTOR (15 downto 0);
        memory_wen  : out STD_LOGIC
    );
end component;

component Volume_Manager
    Port (
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        ce      : IN STD_LOGIC;

        volume  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        idata   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);

        odata   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
        );
end component;


--
SIGNAL int_CE_44100  : STD_LOGIC;
SIGNAL int_cpt_44100 : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL int_mem_out   : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL int_vol_out   : STD_LOGIC_VECTOR(10 DOWNTO 0);

SIGNAL int_mem_in    : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL int_addr_mem  : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL int_we        : STD_LOGIC;

SIGNAL int_vol       : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_vol_cpt   : unsigned(3 DOWNTO 0);

SIGNAL counter       : unsigned(27 DOWNTO 0) := (others => '0');
SIGNAL counter_vct   : STD_LOGIC_VECTOR(27 DOWNTO 0);



begin
  
CE_gen_44100_i: CE_gen_44100 
port map(
    clk     => clk,
    rst     => btnCpuReset,
    clk_out => int_CE_44100
);

cpt_RAM_i: cpt_RAM
port map(
    clk     => clk,
    rst     => btnCpuReset,
    ce      => int_CE_44100,
    out_cpt => int_cpt_44100
);

RAM_i: RAM
port map(
    CLOCK    => clk,
    
    W_E      => int_we,
    
    ADDR_W   => int_addr_mem,
    DATA_IN  => int_mem_in(10 DOWNTO 0),
    
    ADDR_R   => int_cpt_44100,
    DATA_OUT => int_mem_out
);

PWM_i: PWM 
port map(
    clk       => clk,
    ce_441    => int_CE_44100,
    rst       => btnCpuReset,
    i_data    => int_vol_out,
    o_data    => ampPWM,
    o_data_en => ampSD
);

full_UART_recv_i: full_UART_recv 
port map(
    clk_100MHz  => clk,
    
    reset       => not btnCpuReset,
    rx          => RsRx,
    
    memory_addr => int_addr_mem,
    data_value  => int_mem_in,
    memory_wen  => int_we
);

Volume_Manager_i: Volume_Manager 
port map(
    clk    => clk,
    rst    => btnCpuReset,
    ce     => '1',
    volume => int_vol,
    idata  => int_mem_out,
    odata  => int_vol_out
);

int_vol <= "1001";
counter_vct <= std_logic_vector(counter);

end Behavioral;

