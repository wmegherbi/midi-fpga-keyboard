

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity pwm is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (10 downto 0);
           amp_pwm : out STD_LOGIC;
           amp_sd : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

signal ech : unsigned(11 downto 0);
signal ech_reg : unsigned(11 downto 0);
signal c_12 : unsigned(11 downto 0);

begin

trans : process(clk)
begin
if(clk'event and clk = '1') then
    ech <= unsigned(signed(val) + to_signed(1024,12));
end if;
end process;


reg : process(clk)
begin
if (clk'event and clk='1') then 
    if(rst = '1') then
        ech_reg <= to_unsigned(0,12);
       elsif (ce = '1') then
       else
           ech_reg  <= ech;
             end if;
        end if;
end process;

compteur_12:process(clk)
begin
if(clk'event and clk='1') then
    if(rst ='1') then
        c_12<=to_unsigned(0,12);
    else
        if (ce = '1') then
            --if(c_12=to_unsigned(2266,12))then
                c_12<=to_unsigned(0,12);
            else
                c_12<= c_12 + to_unsigned(1,12);
            end if;
        end if;
    end if;
end process;

comparateur : process(ech_reg , c_12)
begin
if (ech_reg > c_12) then
    amp_pwm <= '1';
else 
    amp_pwm <= '0';
end if;
end process;

amp_sd <= '1';

end Behavioral;
