
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity askisi3 is              
    Port (valid_in,rst,clk : in std_logic;
          x1,x2 : in std_logic_vector(7 downto 0);
          valid_out : out std_logic;
          y1,y2 : out std_logic_vector( 18 downto 0)
           );
end askisi3;

architecture structural of askisi3 is

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

signal clk_w : std_logic;
signal x2k1,x2k2,x2k3,x2k4,x2k5,x2k6,x2k7 : std_logic_vector(7 downto 0);
signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21 : std_logic_vector(7 downto 0);
signal add11,add21,add31,add41,add51,add61,add71,reg_y1 : std_logic_vector(18 downto 0);
signal add12,add22,add32,add42,add52,add62,add72,reg_y2 : std_logic_vector(18 downto 0);
signal mul_out11,mul_out21,mul_out31,mul_out41,mul_out51,mul_out61,mul_out71,mul_out81 : std_logic_vector(15 downto 0);
signal mul_out12,mul_out22,mul_out32,mul_out42,mul_out52,mul_out62,mul_out72,mul_out82 : std_logic_vector(15 downto 0);

begin
-------------------------set the clock in order valid_in=enable------------------------
ko: and_gate port map(clk,valid_in,clk_w);
------------------------- X1 X2 DELAYS( Z^-1) SIGNALS-------------------------------
----for first input-----
reg1: dff port map(clk_w,rst,x1,x2k2);
reg2: dff port map(clk_w,rst,x2k2,x2k4);
reg3: dff port map(clk_w,rst,x2k4,x2k6);
---for second input------
reg4: dff port map(clk_w,rst,x2,x2k1);
reg5: dff port map(clk_w,rst,x2k1,x2k3);
reg6: dff port map(clk_w,rst,x2k3,x2k5);
reg7: dff port map(clk_w,rst,x2k5,x2k7);
-------continue with the signals i need---- with the even signals i.e x(2k-2)
reg8: dff port map(clk_w,rst,x2k6,s1);
reg9: dff port map(clk_w,rst,s1,s4);
reg10: dff port map(clk_w,rst,s4,s5);
reg11: dff port map(clk_w,rst,s5,s6);
reg12: dff port map(clk_w,rst,s6,s7);
reg13: dff port map(clk_w,rst,s7,s12);
reg14: dff port map(clk_w,rst,s12,s13);

---------------------------now with the odd signals i.e x(2k-1)
reg19: dff port map(clk_w,rst,x2k7,s2);
reg20: dff port map(clk_w,rst,s2,s3);
reg21: dff port map(clk_w,rst,s3,s8);
reg22: dff port map(clk_w,rst,s8,s9);
reg23: dff port map(clk_w,rst,s9,s10);
reg24: dff port map(clk_w,rst,s10,s11); 
reg25: dff port map(clk_w,rst,s11,s16);

-------------------------MULTIPLIERS FOR X(2k)-------------------------
mul11: mul_seq port map(clk_w,rst,rom(0),x1,mul_out11);
mul21: mul_seq port map(clk_w,rst,rom(1),x2k3,mul_out21);
mul31: mul_seq port map(clk_w,rst,rom(2),x2k6,mul_out31); 
mul41: mul_seq port map(clk_w,rst,rom(3),s2,mul_out41);  
mul51: mul_seq port map(clk_w,rst,rom(4),s5,mul_out51); 
mul61: mul_seq port map(clk_w,rst,rom(5),s9,mul_out61); 
mul71: mul_seq port map(clk_w,rst,rom(6),s12,mul_out71); 
mul81: mul_seq port map(clk_w,rst,rom(7),s16,mul_out81); 
-------------------------MULTIPLIERS FOR X(2k+1)-------------------------
mul12: mul_seq port map(clk_w,rst,rom(0),x2,mul_out12);
mul22: mul_seq port map(clk_w,rst,rom(1),x2k2,mul_out22);
mul32: mul_seq port map(clk_w,rst,rom(2),x2k5,mul_out32);
mul42: mul_seq port map(clk_w,rst,rom(3),s1,mul_out42); 
mul52: mul_seq port map(clk_w,rst,rom(4),s3,mul_out52); 
mul62: mul_seq port map(clk_w,rst,rom(5),s6,mul_out62); 
mul72: mul_seq port map(clk_w,rst,rom(6),s10,mul_out72); 
mul82: mul_seq port map(clk_w,rst,rom(7),s13,mul_out82); 
---------------------------ADDERS FOR X(2k)--------------------------
adder01: adder_seq port map(clk_w,rst,"0000000000000000000",mul_out11,add11);
adder11: adder_seq port map(clk_w,rst,add11,mul_out21,add21);
adder21: adder_seq port map(clk_w,rst,add21,mul_out31,add31);
adder31: adder_seq port map(clk_w,rst,add31,mul_out41,add41);
adder41: adder_seq port map(clk_w,rst,add41,mul_out51,add51);
adder51: adder_seq port map(clk_w,rst,add51,mul_out61,add61);
adder61: adder_seq port map(clk_w,rst,add61,mul_out71,add71);
adder71: adder_seq port map(clk_w,rst,add71,mul_out81,y1);
---------------------------ADDERS FOR X(2k +1)--------------------------
adder02: adder_seq port map(clk_w,rst,"0000000000000000000",mul_out12,add12);
adder12: adder_seq port map(clk_w,rst,add12,mul_out22,add22);
adder22: adder_seq port map(clk_w,rst,add22,mul_out32,add32);
adder32: adder_seq port map(clk_w,rst,add32,mul_out42,add42);
adder42: adder_seq port map(clk_w,rst,add42,mul_out52,add52);
adder52: adder_seq port map(clk_w,rst,add52,mul_out62,add62);
adder62: adder_seq port map(clk_w,rst,add62,mul_out72,add72);
adder72: adder_seq port map(clk_w,rst,add72,mul_out82,y2);
-------------------OUTPUT----------------------------------------
l1: aux_unit port map(clk_w,rst,valid_out);

end structural;
