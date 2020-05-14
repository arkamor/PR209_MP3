---------------------------------------------------------
-- VHDL Top level part 3 for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Top_Level_Partie3 IS
    PORT (
        btnCpuReset : in STD_LOGIC;
        
        clk : in  STD_LOGIC;
        
        btnC : in  STD_LOGIC;
        btnD : in  STD_LOGIC;
        btnU : in  STD_LOGIC;
        btnL : in  STD_LOGIC;
        btnR : in  STD_LOGIC;
        
        seg : out STD_LOGIC_VECTOR(6 DOWNTO 0);
        
        dp  : out STD_LOGIC;
        
        an  : out STD_LOGIC_VECTOR(7 DOWNTO 0);
        
        RsRx : in STD_LOGIC;
        
        ampPWM : out STD_LOGIC;
        
        ampSD  : out STD_LOGIC
        
    );

END Top_Level_Partie3;

architecture Behavioral of Top_Level_Partie3 is

component BP
PORT (
    clk      : in STD_LOGIC;
    rst      : in std_logic;
    b_input  : in  STD_LOGIC;
    b_output : out STD_LOGIC
);
end component;

component FSM
PORT (
    clk : in std_logic;
    ce  : in std_logic;
    rst : in std_logic;

    B_UP     : in std_logic;
    B_DOWN   : in std_logic;
    B_CENTER : in std_logic;
    B_LEFT   : in std_logic;
    B_RIGHT  : in std_logic;
    
    PLAY_PAUSE : out std_logic;
    RESTART    : out std_logic;
    FORWARD    : out std_logic;
    VOLUME_UP  : out std_logic;
    VOLUME_DW  : out std_logic
);
end component;

component gestion_freq
PORT (
    clk : in std_logic;
    rst : in std_logic;
    
    output_10h : out std_logic;
    output_3k  : out std_logic
);
end component;

component cpt_1_9
PORT (
    clk : in STD_LOGIC;
    ce  : in STD_LOGIC;
    rst : in STD_LOGIC;
    
    in_inc : in STD_LOGIC;
    in_dec : in STD_LOGIC;
    in_raz : in STD_LOGIC;
    
    out_cpt : out STD_LOGIC_VECTOR (3 downto 0)
);
end component;

component cpt_1_599
PORT (
    clk : in STD_LOGIC;
    ce  : in STD_LOGIC;
    rst : in STD_LOGIC;
    
    in_inc : in STD_LOGIC;
    in_dec : in STD_LOGIC;
    in_raz : in STD_LOGIC;
    
    out_cpt : out STD_LOGIC_VECTOR (9 downto 0)
);
end component;

component Trans
PORT (
    restart       : in  STD_LOGIC;
    forward       : in  STD_LOGIC;
    play_pause    : in  STD_LOGIC;
    
    val_cpt_1_599 : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
    val_cpt_1_9   : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    -- Valeurs des compteurs
    SEG_0       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- Full Droite
    SEG_1       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG_2       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG_3       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    
    -- Etats de la machine
    SEG_4       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG_5       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG_6       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG_7       : out STD_LOGIC_VECTOR(6 DOWNTO 0)   -- Full Gauche
);
end component;

component mux8_seg
PORT (
    sel : in STD_LOGIC_VECTOR(2 DOWNTO 0);

    SEG0 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG1 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG2 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG3 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG4 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG5 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG6 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    SEG7 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
    
    SEGDP : out STD_LOGIC;
    
    SEG  : out STD_LOGIC_VECTOR(6 DOWNTO 0)
);
end component;


component mod8
PORT (
    clk : in std_logic;
    rst : in std_logic;
    ce  : in std_logic;

    an      : out std_logic_vector(7 DOWNTO 0);
    seg_com : out std_logic_vector(2 DOWNTO 0)
);
end component;

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
        
        inc     : IN STD_LOGIC;

        out_cpt : OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
    );
end component;

component RAM
PORT (
      CLOCK          : IN  STD_LOGIC;

      W_E      : IN  STD_LOGIC;
      
      ADDR_W         : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      DATA_IN        : IN  STD_LOGIC_VECTOR(10 DOWNTO 0);

      ADDR_R         : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
end component;

component full_UART_recv
    PORT (
        clk_100MHz  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        rx          : in  STD_LOGIC;

        memory_addr : out STD_LOGIC_VECTOR (17 downto 0);
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


-- Buttons debouncer output
SIGNAL int_BP_Center : STD_LOGIC;
SIGNAL int_BP_Down   : STD_LOGIC;
SIGNAL int_BP_Up     : STD_LOGIC;
SIGNAL int_BP_Left   : STD_LOGIC;
SIGNAL int_BP_Right  : STD_LOGIC;

-- State machine output
SIGNAL int_Forward    : STD_LOGIC;
SIGNAL int_Play_pause : STD_LOGIC;
SIGNAL int_Restart    : STD_LOGIC;
SIGNAL int_Vol_down   : STD_LOGIC;
SIGNAL int_Vol_up     : STD_LOGIC;

-- CE management
SIGNAL int_CE_affichage  : STD_LOGIC;
SIGNAL int_CE_perception : STD_LOGIC;

-- Counter management
SIGNAL int_Volume : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_Time   : STD_LOGIC_VECTOR(9 DOWNTO 0);

-- 7-Seg management

SIGNAL int_SEG0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG6 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL int_SEG7 : STD_LOGIC_VECTOR(6 DOWNTO 0);

SIGNAL int_SEG_comm : STD_LOGIC_VECTOR(2 DOWNTO 0);


--- BORDEL PART 3

SIGNAL int_CE_44100  : STD_LOGIC;
SIGNAL int_cpt_RAM   : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL int_mem_out   : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL int_vol_out   : STD_LOGIC_VECTOR(10 DOWNTO 0);

SIGNAL int_mem_in    : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL int_addr_mem  : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL int_we        : STD_LOGIC;

SIGNAL int_vol       : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_vol_cpt   : unsigned(3 DOWNTO 0);

SIGNAL counter       : unsigned(27 DOWNTO 0) := (others => '0');
SIGNAL counter_vct   : STD_LOGIC_VECTOR(27 DOWNTO 0);


begin
  
BP_C: BP 
port map(
    clk      => clk,
    rst      => btnCpuReset,
    b_input  => btnC,
    b_output => int_BP_Center
);

BP_D: BP 
port map(
    clk      => clk,
    rst      => btnCpuReset,
    b_input  => btnD,
    b_output => int_BP_Down
);

BP_U: BP 
port map(
    clk      => clk,
    rst      => btnCpuReset,
    b_input  => btnU,
    b_output => int_BP_Up
);

BP_L: BP 
port map(
    clk      => clk,
    rst      => btnCpuReset,
    b_input  => btnL,
    b_output => int_BP_Left
);

BP_R: BP 
port map(
    clk      => clk,
    rst      => btnCpuReset,
    b_input  => btnR,
    b_output => int_BP_Right
);

MP3_FSM: FSM
port map(
    clk => clk,
    ce  => '1',
    rst => btnCpuReset,
    
    -- Buttons input
    B_CENTER => int_BP_Center,
    B_DOWN   => int_BP_Down,
    B_UP     => int_BP_Up,
    B_LEFT   => int_BP_Left,
    B_RIGHT  => int_BP_Right,
    
    -- State machine output
    FORWARD    => int_Forward,
    PLAY_PAUSE => int_Play_pause,
    RESTART    => int_Restart,
    VOLUME_UP  => int_Vol_up,
    VOLUME_DW  => int_Vol_down
);

MP3_gestion_freq: gestion_freq
port map(
    clk => clk,
    rst => btnCpuReset,
    
    output_10h => int_CE_affichage,
    output_3k  => int_CE_perception
);

MP3_cpt_1_9: cpt_1_9
port map(
    clk => clk,
    ce  => '1',
    rst => btnCpuReset,
    
    in_inc => int_Vol_up,
    in_dec => int_Vol_down,
    in_raz => not btnCpuReset,
    
    out_cpt => int_Volume
);

MP3_cpt_1_599: cpt_1_599
port map(
    clk => clk,
    ce  => int_CE_affichage,
    rst => btnCpuReset,
    
    in_inc => int_Play_pause,
    in_dec => not int_Forward,
    in_raz => int_Restart,
    
    out_cpt => int_Time
);

MP3_Trans: Trans
port map(
    restart    => int_Restart,
    forward    => int_Forward,
    play_pause => int_Play_pause,
    
    val_cpt_1_599 => int_Time,
    val_cpt_1_9   => int_Volume,
    
    SEG_0 => int_SEG0,
    SEG_1 => int_SEG1,
    SEG_2 => int_SEG2,
    SEG_3 => int_SEG3,
    SEG_4 => int_SEG4,
    SEG_5 => int_SEG5,
    SEG_6 => int_SEG6,
    SEG_7 => int_SEG7
);

MP3_mux8_seg: mux8_seg
port map(
    sel => int_SEG_comm,
    
    SEG0 => int_SEG0,
    SEG1 => int_SEG1,
    SEG2 => int_SEG2,
    SEG3 => int_SEG3,
    SEG4 => int_SEG4,
    SEG5 => int_SEG5,
    SEG6 => int_SEG6,
    SEG7 => int_SEG7,
    
    SEGDP => dp,
    
    SEG => seg
);

MP3_mod8: mod8
port map(
    clk => clk,
    ce  => int_CE_perception,
    rst => btnCpuReset,
    
    an => an,
    seg_com => int_SEG_comm
);

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
    ce      => int_CE_44100 and int_Play_pause,
 
    inc     => int_Forward,
    
    out_cpt => int_cpt_RAM
);

RAM_i: RAM
port map(
    CLOCK    => clk,
    
    W_E      => int_we,
    
    ADDR_W   => int_addr_mem,
    DATA_IN  => int_mem_in(10 DOWNTO 0),
    
    ADDR_R   => int_cpt_RAM,
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
    volume => int_Volume,
    idata  => int_mem_out,
    odata  => int_vol_out
);
 
end Behavioral;