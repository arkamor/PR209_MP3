---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Top_Level_Partie1 IS
    PORT (
        btnCpuReset : in STD_LOGIC;
        
        clk : in  STD_LOGIC;
        
        btnC : in  STD_LOGIC;
        btnD : in  STD_LOGIC;
        btnU : in  STD_LOGIC;
        btnL : in  STD_LOGIC;
        btnR : in  STD_LOGIC;
        
        led : out STD_LOGIC_VECTOR(15 DOWNTO 0)
    );

END Top_Level_Partie1;

architecture Behavioral of Top_Level_Partie1 is


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

 led(0) <= int_Play_pause;
 led(1) <= int_Restart;
 led(2) <= int_Forward;
 led(3) <= int_Vol_down;
 led(4) <= int_Vol_up;
 
 led(14 downto 5) <= "0000000000";
 
end Behavioral;