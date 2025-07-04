


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compteur_addr is
    Port ( 
        N1 : in std_logic_vector(6 downto 0);
        N2 : in std_logic_vector(6 downto 0);
        clk : in STD_LOGIC;
        ce : in STD_LOGIC;
        rst : in STD_LOGIC;
        enable : in std_logic;
        two_notes : in std_logic;
        count16_1 : out STD_LOGIC_VECTOR (15 downto 0); 
        count16_2 : out STD_LOGIC_VECTOR (15 downto 0)  
    );
end compteur_addr;


architecture Behavioral of compteur_addr is
    signal c7_1 : unsigned(6 downto 0); 
    signal c7_2 : unsigned(6 downto 0); 
    signal addr_counter_1 : unsigned(15 downto 0); 
    signal addr_counter_2 : unsigned(15 downto 0); 
    signal Nb1 : unsigned(6 downto 0);
    signal Nb2 : unsigned(6 downto 0);
    signal two_notes_prev : std_logic := '0';
begin


Nb1 <= unsigned(N1);
Nb2 <= unsigned(N2);

compteur_7: process(clk)
begin
if(clk'event and clk='1') then
    if(rst = '1') then
        c7_1 <= to_unsigned(0, 7);
        c7_2 <= to_unsigned(0, 7);
        addr_counter_1 <= to_unsigned(0, 16);
        addr_counter_2 <= to_unsigned(0, 16);
        two_notes_prev <= '0';
    else

        if(two_notes = '1' and two_notes_prev = '0') then
            c7_1 <= to_unsigned(0, 7);
            c7_2 <= to_unsigned(0, 7);
            addr_counter_1 <= to_unsigned(0, 16);
            addr_counter_2 <= to_unsigned(0, 16);
        end if;
        two_notes_prev <= two_notes;
        if(enable = '1') then
            if(ce = '1') then
                if(c7_1 = Nb1) then
                    c7_1 <= to_unsigned(0, 7);
                    if(addr_counter_1 = to_unsigned(41894, 16)) then
                        addr_counter_1 <= to_unsigned(0, 16);
                    else
                        addr_counter_1 <= addr_counter_1 + to_unsigned(1, 16);
                    end if;
                else
                    c7_1 <= c7_1 + to_unsigned(1, 7);
                end if;
                if(two_notes = '1') then
                    if(c7_2 = Nb2) then
                        c7_2 <= to_unsigned(0, 7);
                        if(addr_counter_2 = to_unsigned(41894, 16)) then
                            addr_counter_2 <= to_unsigned(0, 16);
                        else
                            addr_counter_2 <= addr_counter_2 + to_unsigned(1, 16);
                        end if;
                    else
                        c7_2 <= c7_2 + to_unsigned(1, 7);
                    end if;
                end if;
            end if;
        end if;
    end if;
end if;
end process;

count16_1 <= std_logic_vector(addr_counter_1);
count16_2 <= std_logic_vector(addr_counter_2);

end Behavioral;
