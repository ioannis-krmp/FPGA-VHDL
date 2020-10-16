
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity askisi3_tb is
end askisi3_tb;

architecture testbench of askisi3_tb is

component askisi3
    Port ( clk,rst,valid_in : in std_logic;
        x1,x2 : in std_logic_vector(7 downto 0);
        valid_out : out std_logic;
        y1,y2 : out std_logic_vector(18 downto 0));
end component;

signal rst,clk,valid_in,valid_out : std_logic;
signal x1,x2 : std_logic_vector(7 downto 0);
constant clk_period : time := 5 ns;
--constant output_width : integer := 19;
signal y1,y2 : std_logic_vector(18 downto 0);

begin
    UUT : askisi3 port map ( rst=>rst , clk=>clk,valid_in=>valid_in,valid_out=>valid_out,x1=>x1,x2=>x2,y1=>y1,y2=>y2);

    test_askisi2 : process
        begin
             rst<='1';
             valid_in<='1';
            x1 <= "00101000";
            x2 <= "11111000";
            wait for clk_period;
            rst <= '0';  
            x1 <= "00101000";
            x2 <= "11111000";
            wait for clk_period;               
            x1 <= "11110101";
            x2 <= "01111100";
            wait for clk_period;
            x1 <= "11001100";
            x2 <= "00100100";
            wait for clk_period;   
            x1 <= "01101011";
            x2 <= "11101010";
            wait for clk_period;   
            x1 <= "11001010";  
            x2 <= "11110101";
            wait for clk_period;   
            x1 <= "00000000";
            x2 <= "00000000";  
            wait for clk_period;   
            x1 <= "00000000";
            x2 <= "00000000";       
            wait for clk_period;   
            x1 <= "00000000";
            x2 <= "00000000";       
            wait for clk_period;   
            x1 <= "00000000";
            x2 <= "00000000";       
            wait for clk_period;   
            x1 <= "00000000";
            x2 <= "00000000";       
            wait for clk_period;   
            x1 <= "00000000";             
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