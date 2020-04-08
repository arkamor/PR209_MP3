
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_tb is
end;

architecture bench of FSM_tb is

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

  signal clk: std_logic;
  signal ce: std_logic;
  signal rst: std_logic;
  signal B_UP: std_logic;
  signal B_DOWN: std_logic;
  signal B_CENTER: std_logic;
  signal B_LEFT: std_logic;
  signal B_RIGHT: std_logic;
  signal PLAY_PAUSE: std_logic;
  signal RESTART: std_logic;
  signal FORWARD: std_logic;
  signal VOLUME_UP: std_logic;
  signal VOLUME_DW: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM port map ( clk        => clk,
                      ce         => ce,
                      rst        => rst,
                      B_UP       => B_UP,
                      B_DOWN     => B_DOWN,
                      B_CENTER   => B_CENTER,
                      B_LEFT     => B_LEFT,
                      B_RIGHT    => B_RIGHT,
                      PLAY_PAUSE => PLAY_PAUSE,
                      RESTART    => RESTART,
                      FORWARD    => FORWARD,
                      VOLUME_UP  => VOLUME_UP,
                      VOLUME_DW  => VOLUME_DW );

  stimulus: process
  begin
  
    -- Put initialisation code here

    rst <= '0';
    wait for 5 ns;
    rst <= '1';
    ce <= '1';
    wait for 5 ns;
    
    B_CENTER <= '0';
    B_DOWN   <= '0';
    B_UP     <= '0';
    B_LEFT   <= '0';
    B_RIGHT  <= '0';
    
    while true loop
        wait for 10*clock_period;
    
        B_CENTER <= '1';
        wait for clock_period;
        B_CENTER <= '0';
    end loop;
    
    wait for 10*clock_period;
    
    B_CENTER <= '1';
    wait for clock_period;
    B_CENTER <= '0';
    
    wait for 10*clock_period;
    
    B_CENTER <= '1';
    wait for clock_period;
    B_CENTER <= '0';
    
    wait for 10*clock_period;
    
    B_CENTER <= '1';
    wait for clock_period;
    B_CENTER <= '0';
   
    
    

    -- Put test bench stimulus code here

    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;