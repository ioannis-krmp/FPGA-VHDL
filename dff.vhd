
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


 entity dff is 
   port(
        clk,reset : in std_logic;
        D : in std_logic_vector(7 downto 0);
        Q : out std_logic_vector(7 downto 0)
   );
 end dff;
 architecture Behavioral of dff is  
 begin  
  process(clk,reset)
  begin
    if reset='1' then 
        Q <= "00000000";
    else
        if rising_edge(clk) then
            Q <= D; 
        end if;
    end if;       
 end process;   
 end Behavioral; 