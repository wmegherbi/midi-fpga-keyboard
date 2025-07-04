----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2024 16:25:29
-- Design Name: 
-- Module Name: mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port (   
           clk : in std_logic;
           rst : in std_logic;
           one_note : in STD_LOGIC;
           two_notes : in STD_LOGIC;
           three_notes : in STD_LOGIC;
           old_signal : in STD_LOGIC_VECTOR (10 downto 0);
           current_signal : in STD_LOGIC_VECTOR (10 downto 0);
           val_out : out STD_LOGIC_VECTOR (10 downto 0));
end mux;
architecture Behavioral of mux is
signal valmax: signed(10 downto 0);

begin
--process(clk)
--begin 
--if(clk'event and clk = '1') then
--    if(rst = '1') then
--        val_out <= current_signal;
--    else
      
--if(one_note ='1') then
--    val_out<= current_signal;
--end if;
--if(two_notes = '1') then
--    valmax <= shift_right(signed(old_signal) + signed(current_signal), 1);
--    val_out <= std_logic_vector(valmax(10 downto 0));
--end if;
--end if;
--end if;
--end process;

process(clk)
begin

if(clk'event and clk = '1') then
    if(rst = '1') then
        val_out <= current_signal;
    else 
       -- if(one_note= '1') then
        val_out <= current_signal;
   -- end if;
end if;
end if;
end process;
end Behavioral;
