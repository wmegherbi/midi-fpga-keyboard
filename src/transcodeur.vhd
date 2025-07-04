library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transcodeur is
PORT (
    CLOCK       : IN  STD_LOGIC;
    rst         : IN  STD_LOGIC;
    notes       : in  std_logic_vector(15 downto 0);
    one_note    : in  std_logic;
    two_notes   : in  std_logic;
    N1          : inout std_logic_vector(6 downto 0);
    N2          : out std_logic_vector(6 downto 0);
    enable      : out std_logic
);
end transcodeur;

architecture Behavioral of transcodeur is
signal N : std_logic_vector(6 downto 0);

begin
process(CLOCK)
begin
if (CLOCK'event and CLOCK = '1') then
    if (rst = '1') then
        N <= "0000000";
        enable <= '0';
        N1 <= "0000000";
        N2 <= "0000000";

    else
        if (notes(0) = '1') then
            N <= "1100011"; --99
        elsif (notes(1) = '1') then
            N <= "1011101"; --93
        elsif (notes(2) = '1') then
            N <= "1011000"; --88
        elsif (notes(3) = '1') then
            N <= "1010011"; --83
        elsif (notes(4) = '1') then
            N <= "1001110"; --78
        elsif (notes(5) = '1') then
            N <= "1001001"; --73
        elsif (notes(6) = '1') then
            N <= "1000101"; --69
        elsif (notes(7) = '1') then
            N <= "1000001"; --65
        elsif (notes(8) = '1') then
            N <= "0111101"; --61
        elsif (notes(9) = '1') then
            N <= "0111010"; --58
        elsif (notes(10) = '1') then
            N <= "0110111"; --55
        elsif (notes(11) = '1') then
            N <= "0110011"; --51
        elsif (notes(12) = '1') then
            N <= "0101110"; --46
        elsif (notes(13) = '1') then
            N <= "0101100"; --44
        elsif (notes(14) = '1') then
            N <= "0101001"; --41
        elsif (notes(15) = '1') then
            N <= "0100111"; --39
        else
            N <= "0000000";
        end if;

       
        if (notes /= "0000000000000000") then
            enable <= '1';
        else
            enable <= '0';
        end if;


        if (one_note = '1') then
            N1 <= N;
            N2 <= "0000000"; 
        elsif (two_notes = '1') then
           
                N1 <= N1; 
       
                N2 <= N;
              
            end if;
        end if;
   end if;

end process;

end Behavioral;