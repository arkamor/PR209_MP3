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

    type fsm_state IS(init, play_fwd, play_bwd, pause, stop);    
    signal next_state ,current_state: fsm_state;

begin
  
    PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF rst = '1' THEN -- asynchronous reset
            current_state <= init;
        ELSIF clk'event AND clk = '1' THEN  -- rising clock edge
            current_state <= next_state;
        END IF;
    END PROCESS;


    PROCESS(current_state, B_CENTER, B_RIGHT, B_LEFT) IS
    BEGIN
        case current_state IS

            when init =>
                if(B_CENTER = '1') then
                    next_state <= play_fwd;
                end if;

            when play_fwd | play_bwd =>
                if(B_CENTER = '1') then
                    next_state <= pause;
                end if;
            
            when pause =>
                if(B_CENTER = '1') then
                    next_state <= stop;
                elsif(B_RIGHT = '1') then
                    next_state <= play_fwd;
                elsif(B_LEFT = '1') then
                    next_state <= play_bwd;
                end if;
            
            when stop =>
                if(B_CENTER = '1') then
                    next_state <= play_fwd;
                end if;
        
            when others => next_state <= init;

        end case;
end PROCESS;

PROCESS (current_state, Carry) IS
    BEGIN  -- PROCESS
    CASE current_state IS
        when init =>
            PLAY_PAUSE <= '0'; --1
            RESTART    <= '1'; --2
            FORWARD    <= '0'; --3
            VOLUME_UP  <= '0'; --4
            VOLUME_DW  <= '0'; --5

        when play_fwd =>
            PLAY_PAUSE <= '1'; --1
            RESTART    <= '0'; --2
            FORWARD    <= '1'; --3
            VOLUME_UP  <= BP_UP; --4
            VOLUME_DW  <= BP_DOWN; --5
        
        when play_bwd =>
            PLAY_PAUSE <= '1'; --1
            RESTART    <= '0'; --2
            FORWARD    <= '0'; --3
            VOLUME_UP  <= BP_UP; --4
            VOLUME_DW  <= BP_DOWN; --5
    
        when pause =>
            PLAY_PAUSE <= '0'; --1
            RESTART    <= '0'; --2
            FORWARD    <= '0'; --3
            VOLUME_UP  <= '0'; --4
            VOLUME_DW  <= '0'; --5

        when stop =>
            PLAY_PAUSE <= '0'; --1
            RESTART    <= '1'; --2
            FORWARD    <= '0'; --3
            VOLUME_UP  <= '0'; --4
            VOLUME_DW  <= '0'; --5
        
        when others => NULL;

    END CASE;
END PROCESS;
end moore;