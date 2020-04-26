---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY FSM IS
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

END FSM;

architecture moore of FSM is

    type fsm_state IS(s_init, s_play_fwd, s_play_bwd, s_pause, s_stoop);    
    signal next_state ,current_state: fsm_state := s_init;

begin
  
    PROCESS(clk) IS
    BEGIN  -- PROCESS
        IF clk'event AND clk = '1' THEN  -- rising clock edge
            current_state <= next_state;
        END IF;
    END PROCESS;
    
    PROCESS(B_CENTER, B_RIGHT, B_LEFT, rst) IS
    BEGIN
        IF rst = '0' THEN -- asynchronous reset
            --current_state <= init;
            next_state <= s_init;
        ELSE  
            case current_state IS
                when s_init =>
                    if(B_CENTER = '1') then
                        next_state <= s_play_fwd;
                    else 
                        next_state <= s_init;
                    end if;
    
                when s_play_fwd =>
                    if(B_CENTER = '1') then
                        next_state <= s_pause;
                    else 
                        next_state <= s_play_fwd;
                    end if;
                    
                when s_play_bwd =>
                    if(B_CENTER = '1') then
                        next_state <= s_pause;
                    else 
                        next_state <= s_play_bwd;
                    end if;
                
                when s_pause =>
                    if(B_LEFT = '1') then
                        next_state <= s_play_bwd;
                    elsif(B_RIGHT = '1') then
                        next_state <= s_play_fwd;
                    elsif(B_CENTER= '1') then
                        next_state <= s_stoop;
                    else 
                        next_state <= s_pause;
                    end if;
                
                when s_stoop =>
                    if(B_CENTER = '1') then
                        next_state <= s_play_fwd;
                    else 
                        next_state <= s_stoop;
                    end if;
            
                when others => NULL;
    
            end case;
        END IF;
    END PROCESS;
    
    PROCESS (current_state, B_UP, B_DOWN) IS
    BEGIN  -- PROCESS
        CASE current_state IS
            when s_init =>
                PLAY_PAUSE <= '0'; --1
                RESTART    <= '1'; --2
                FORWARD    <= '0'; --3
                VOLUME_UP  <= '0'; --4
                VOLUME_DW  <= '0'; --5
    
            when s_play_fwd =>
                PLAY_PAUSE <= '1';    --1
                RESTART    <= '0';    --2
                FORWARD    <= '1';    --3
                VOLUME_UP  <= B_UP;   --4
                VOLUME_DW  <= B_DOWN; --5
            
            when s_play_bwd =>
                PLAY_PAUSE <= '1';    --1
                RESTART    <= '0';    --2
                FORWARD    <= '0';    --3
                VOLUME_UP  <= B_UP;   --4
                VOLUME_DW  <= B_DOWN; --5
        
            when s_pause =>
                PLAY_PAUSE <= '0'; --1
                RESTART    <= '0'; --2
                FORWARD    <= '0'; --3
                VOLUME_UP  <= '0'; --4
                VOLUME_DW  <= '0'; --5
    
            when s_stoop =>
                PLAY_PAUSE <= '0'; --1
                RESTART    <= '1'; --2
                FORWARD    <= '0'; --3
                VOLUME_UP  <= '0'; --4
                VOLUME_DW  <= '0'; --5
            
            when others => NULL;
    
        END CASE;
    END PROCESS;

end moore;