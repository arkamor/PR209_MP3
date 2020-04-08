
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top_Level_Partie1_tb is
end;

architecture bench of Top_Level_Partie1_tb is

  component Top_Level_Partie1
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
          led : out STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
  end component;

  signal btnCpuReset: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal btnC: STD_LOGIC;
  signal btnD: STD_LOGIC;
  signal btnU: STD_LOGIC;
  signal btnL: STD_LOGIC;
  signal btnR: STD_LOGIC;
  signal seg: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal dp: STD_LOGIC;
  signal an: STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal led: STD_LOGIC_VECTOR(15 DOWNTO 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Top_Level_Partie1 port map ( btnCpuReset => btnCpuReset,
                                    clk         => clk,
                                    btnC        => btnC,
                                    btnD        => btnD,
                                    btnU        => btnU,
                                    btnL        => btnL,
                                    btnR        => btnR,
                                    seg         => seg,
                                    dp          => dp,
                                    an          => an,
                                    led         => led );

  stimulus: process
  begin
  
    -- Put initialisation code here
    
    btnCpuReset <= '0';
    
    btnC <= '0';
    btnD <= '0';
    btnU <= '0';
    btnL <= '0';
    btnR <= '0';
    
    btnCpuReset <= '1';
    wait for clock_period;

    while true loop
        wait for 10*clock_period;
        
        btnC <= '1';
        wait for clock_period;
        btnC <= '0';
    end loop;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
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