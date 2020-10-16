
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity askisi2 is 
    Port (valid_in,rst,clk : in std_logic;
          input : in std_logic_vector(7 downto 0);
          valid_out : out std_logic;
          y : out std_logic_vector( 18 downto 0)
           );
end askisi2;

architecture structural of askisi2 is

component and_gate 
    Port ( x,y : in std_logic;
    z : out std_logic );
end component;

 component dff  
   port(
      clk: in std_logic;
      reset : in std_logic;
      D : in std_logic_vector(7 downto 0);
      Q : out std_logic_vector(7 downto 0)
 );
 end component;
 
 component adder_seq 
  port (  clk,reset : in std_logic;
         A : in  std_logic_vector(18 downto 0);
         B : in  std_logic_vector(15 downto 0);
         C : out std_logic_vector(18 downto 0) );
 end component;
 
 component mul_seq 
   port (  clk : in std_logic;
           reset : in std_logic;
           A : in  std_logic_vector(7 downto 0);
           B : in  std_logic_vector(7 downto 0);
           C : out std_logic_vector(15 downto 0) );
 end component;
 
 component aux_unit 
     Port (clk,reset : in std_logic;
           --reg : in std_logic_vector(18 downto 0);
           --y : out std_logic_vector(18 downto 0);
           valid_out :  out std_logic );
 end component;
 
    type rom_type is array (7 downto 0) of std_logic_vector (7 downto 0);                 
 signal rom : rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                          "00000001"); 
signal x1,x2,x3,x4,x5,x6,x7 : std_logic_vector(7 downto 0);
signal mul_in1,mul_in2,mul_in3,mul_in4,mul_in5,mul_in6,mul_in7: std_logic_vector(7 downto 0);
signal mul_out0,mul_out1,mul_out2,mul_out3,mul_out4,mul_out5,mul_out6,mul_out7 : std_logic_vector(15 downto 0);
signal add1,add2,add3,add4,add5,add6,add7,reg_y : std_logic_vector(18 downto 0);
signal x7reg0,x7reg1,x7reg2,x7reg3,x7reg4,x7reg5 : std_logic_vector(7 downto 0);
signal clk_w : std_logic;

begin
clk_w <= clk and valid_in;
-------------------------- X SIGNAL ARRAY -------------------

k1: dff port map(clk_w,rst,input,x1);
k2: dff port map(clk_w,rst,x1,x2);
k3: dff port map(clk_w,rst,x2,x3);
k4: dff port map(clk_w,rst,x3,x4);
k5: dff port map(clk_w,rst,x4,x5);
k6: dff port map(clk_w,rst,x5,x6);
k7: dff port map(clk_w,rst,x6,x7);
--------------------MULTIPLIERS--------------------------------
mul0: mul_seq port map(clk_w,rst,rom(0),input,mul_out0);
mul1: mul_seq port map(clk_w,rst,rom(1),x2,mul_out1);
mul2: mul_seq port map(clk_w,rst,rom(2),x4,mul_out2);
mul3: mul_seq port map(clk_w,rst,rom(3),x6,mul_out3);
mul4: mul_seq port map(clk_w,rst,rom(4),mul_in4,mul_out4);
mul5: mul_seq port map(clk_w,rst,rom(5),mul_in5,mul_out5);
mul6: mul_seq port map(clk_w,rst,rom(6),mul_in6,mul_out6);
mul7: mul_seq port map(clk_w,rst,rom(7),mul_in7,mul_out7);
------------------ADDERS --------------------------------------
adder0: adder_seq port map(clk_w,rst,"0000000000000000000",mul_out0,add1);
adder1: adder_seq port map(clk_w,rst,add1,mul_out1,add2);
adder2: adder_seq port map(clk_w,rst,add2,mul_out2,add3);
adder3: adder_seq port map(clk_w,rst,add3,mul_out3,add4);
adder4: adder_seq port map(clk_w,rst,add4,mul_out4,add5);
adder5: adder_seq port map(clk_w,rst,add5,mul_out5,add6);
adder6: adder_seq port map(clk_w,rst,add6,mul_out6,add7);
adder7: adder_seq port map(clk_w,rst,add7,mul_out7,y);
---------EXTRA DELAYS ----------------------------------------
regx7: dff port map(clk_w,rst,x7,mul_in4);
p1: dff port map(clk_w,rst,mul_in4,x7reg1);
p2: dff port map(clk_w,rst,x7reg1,mul_in5);
p3: dff port map(clk_w,rst,mul_in5,x7reg3);
p4: dff port map(clk_w,rst,x7reg3,mul_in6);
p5: dff port map(clk_w,rst,mul_in6,x7reg5);
p6: dff port map(clk_w,rst,x7reg5,mul_in7);
------------------------------------------------
-------------------OUTPUT----------------------
lo: aux_unit port map(clk_w,rst,valid_out);
end structural;
