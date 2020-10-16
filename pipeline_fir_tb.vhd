
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity askisi2_tb is
end askisi2_tb;

architecture testbench of askisi2_tb is

component askisi2
    Port ( clk,rst,valid_in : in std_logic;
        input : in std_logic_vector(7 downto 0);
        valid_out : out std_logic;
        y : out std_logic_vector(18 downto 0));
end component;

signal rst,clk,valid_in,valid_out : std_logic;
signal input : std_logic_vector(7 downto 0);
constant clk_period : time := 5 ns;
--constant output_width : integer := 19;
signal y : std_logic_vector(18 downto 0);

begin
    UUT : askisi2 port map ( rst=>rst , clk=>clk,valid_in=>valid_in,valid_out=>valid_out,input=>input,y=>y);

    test_askisi2 : process
        begin
           rst<='1';
           valid_in<='1';
           input <= "00101000";
            wait for clk_period;
            rst<='0';
            input <= "00101000";
            wait for clk_period; 
            input <= "11111000";
            wait for clk_period;   
            input <= "11110101";
            wait for clk_period;
             input <= "01111100";
             wait for clk_period;
             input <= "11001100";
             wait for clk_period; 
             input <= "00100100";
             wait for clk_period;   
             input <= "01101011";
             wait for clk_period;   
             input <= "11101010";
             wait for clk_period;   
             input <= "11001010";  
             wait for clk_period;   
             input <= "11110101";
             wait for clk_period;   
             input <= "00000000";
             wait for clk_period;   
             input <= "00000000";  
             wait for clk_period;   
             input <= "00000000";
             wait for clk_period;   
             input <= "00000000";       
             wait for clk_period;   
             input <= "00000000";
             wait for clk_period;   
             input <= "00000000";       
             wait for clk_period;   
             input <= "00000000";
             wait for clk_period;   
             input <= "00000000";       
             wait for clk_period;   
             input <= "00000000";
             wait for clk_period;   
             input <= "00000000";       
             wait for clk_period;   
             input <= "00000000";                                                                                            
             wait for 8*clk_period;    
             wait;        
    end process;
           
    generate_clock : process
        begin
            clk<='0';
            wait for clk_period/2;
            clk<='1';
            wait for clk_period/2;                    
    end process;
    
end testbench;