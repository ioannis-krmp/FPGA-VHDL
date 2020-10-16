library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity adder_seq is
  port (  clk,reset : in std_logic;
          A : in  std_logic_vector(18 downto 0);
          B : in  std_logic_vector(15 downto 0);
          C : out std_logic_vector(18 downto 0) );
end adder_seq;

architecture Behavioral of adder_seq is

begin
    process(clk,reset)
    begin
        if reset= '0' then
            if (rising_edge(clk)) then
                C <= A + B;
            end if;
        else 
             C <="0000000000000000000";
        end if;
    end process;
end Behavioral;