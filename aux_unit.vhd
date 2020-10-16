
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity aux_unit is
    Port (clk,reset : in std_logic;
          valid_out :  out std_logic );
end aux_unit;

architecture Behavioral of aux_unit is
signal i : integer:=0;
begin
process(clk,reset)
    begin
    if reset='1' then
        valid_out <='0';
        i<=0;
    else
        if(rising_edge(clk)) then
        i <= i+1;
            if(i < 8) then
                valid_out <='0';
            else
                valid_out<='1';
            end if;
        end if;
    end if;
end process;
end Behavioral;
