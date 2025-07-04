

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_ce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : out STD_LOGIC);
end gestion_ce;

architecture Behavioral of gestion_ce is


signal c_12:unsigned(11 downto 0);

begin

compteur_12:process(clk)
begin
if(clk'event and clk='1') then
    if(rst ='1') then
        c_12<=to_unsigned(0,12);
    else
        if(c_12=to_unsigned(4000,12))then
            c_12<=to_unsigned(0,12);
        else
            c_12<= c_12 + to_unsigned(1,12);
        end if;
    end if;
end if;
end process;


process(clk)
begin

if(clk'event and clk = '1') then
    if(rst ='1') then
        ce <='0';
    else
        if(c_12 = to_unsigned(4000,12))then
            ce <='1';
        else
            ce<='0';
        end if;
    end if;
end if;
end process;

end Behavioral;
