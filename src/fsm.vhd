library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsm is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        notes : in STD_LOGIC_VECTOR(15 downto 0);
      --notes_sortie : out STD_LOGIC_VECTOR(15 downto 0);
        note_1 : out std_logic;
        notes_2 : out std_logic;
        notes_3 : out std_logic           
    );
end fsm;

architecture Behavioral of fsm is

    type STATE_TYPE is (init, one_note, two_notes, three_notes, pause);
    signal current_state, next_state : STATE_TYPE;
    signal sum : unsigned(3 downto 0);

begin

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_state <= init;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    process (current_state, sum)
    begin
        case current_state is
            when init =>
                if sum = to_unsigned(1, 4) then
                    next_state <= one_note;
                else
                    next_state <= init;
                end if;
                
            when one_note =>
                if sum = to_unsigned(2, 4) then
                    next_state <= two_notes;
                elsif sum = to_unsigned(0, 4) then
                    next_state <= pause;
                else
                    next_state <= one_note;
                end if;
                
            when two_notes =>
                if sum = to_unsigned(3, 4) then
                    next_state <= three_notes;
                elsif sum = to_unsigned(1, 4) then
                    next_state <= one_note;
                else
                    next_state <= two_notes;
                end if;

            when three_notes =>
                if sum = to_unsigned(2, 4) then
                    next_state <= two_notes;
                else
                    next_state <= three_notes;
                end if;

            when pause =>
                if sum = to_unsigned(1, 4) then
                    next_state <= one_note;
                else
                    next_state <= pause;
                end if;

            when others =>
                next_state <= init;
        end case;
    end process;

  
    process (notes)
        variable temp_sum : unsigned(3 downto 0); 
    begin
        temp_sum := "0000"; 

        if notes(0) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(1) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(2) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(3) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(4) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(5) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(6) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(7) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(8) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(9) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(10) = '1' then temp_sum := temp_sum + 1; end if;
        if notes(11) = '1' then temp_sum := temp_sum + 1; end if;

        sum <= temp_sum; 
    end process;

    
    process (current_state)
    begin
        case current_state is
            when init =>
                note_1 <= '0';
                notes_2 <= '0';
                notes_3 <= '0';

            when one_note =>
                note_1 <= '1';
                notes_2 <= '0';
                notes_3 <= '0';

            when two_notes =>
                note_1 <= '0';
                notes_2 <= '1';
                notes_3 <= '0';

            when three_notes =>
                note_1 <= '0';
                notes_2 <= '0';
                notes_3 <= '1';

            when pause =>
                note_1 <= '0';
                notes_2 <= '0';
                notes_3 <= '0';

            when others =>
                note_1 <= '0';
                notes_2 <= '0';
                notes_3 <= '0';
        end case;
    end process;

    end Behavioral;