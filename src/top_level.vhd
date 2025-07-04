

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_level is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           notes  : in STD_LOGIC_VECTOR(15 downto 0);
           amp_pwm : out STD_LOGIC;
           amp_sd : out STD_LOGIC;
           led :out std_logic_vector(2 downto 0);
           data_out : out std_logic_vector(10 downto 0)
           );
end top_level;

architecture Behavioral of top_level is

component gestion_ce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : out STD_LOGIC);
end component;

component compteur_addr is

    Port ( N1 : in std_logic_vector(6 downto 0);
        N2 : in std_logic_vector(6 downto 0);
        clk : in STD_LOGIC;
        ce : in STD_LOGIC;
        rst : in STD_LOGIC;
        enable : in std_logic;
        two_notes : in std_logic;
        count16_1 : out STD_LOGIC_VECTOR (15 downto 0); 
        count16_2 : out STD_LOGIC_VECTOR (15 downto 0)); 
end component;

component wav_rom IS
port (
      CLOCK          : IN  STD_LOGIC;
      ce: in std_logic;
      ADDR_1      : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      ADDR_2 : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      two_notes: in std_logic;
      DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
end component;

component pwm is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (10 downto 0);
           amp_pwm : out STD_LOGIC;
           amp_sd : out STD_LOGIC);
end component;

component cpt_addr_rom1_16_bits is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in std_logic;
           enable : in STD_LOGIC;
           cpt_addr_rom1 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal ce : std_logic;
signal c1 : std_logic_vector(15 downto 0);
signal c2 :std_logic_vector(15 downto 0);
signal cpt_addr_rom1 : std_logic_vector(15 downto 0);
signal val : std_logic_vector(10 downto 0);


signal N1 : std_logic_vector(6 downto 0);
signal N2 : std_logic_vector(6 downto 0);
signal en: std_logic;
signal one_note : std_logic;
signal two_notes : std_logic;
signal three_notes:std_logic;

component transcodeur is
PORT (
      CLOCK          : IN  STD_LOGIC;
      rst         : IN  STD_LOGIC;
      notes:in std_logic_vector(15 downto 0);
      one_note : in std_logic;
      two_notes : in std_logic;
      N1 : inout std_logic_vector(6 downto 0);
      N2 : out std_logic_vector(6 downto 0);
      enable :out std_logic
      );

end component;

component fsm is
 Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        notes : in STD_LOGIC_VECTOR(15 downto 0);
      --notes_sortie : out STD_LOGIC_VECTOR(15 downto 0);
        note_1 : out std_logic;
        notes_2 : out std_logic;
        notes_3 : out std_logic           
    );
end component;




begin

inst_gestion_ce :  gestion_ce Port map ( 
           clk => clk,
           rst => rst,
           ce => ce);

inst_cpt_16 : compteur_addr Port map(
            N1 => N1,
            N2 => N2,
           clk => clk,
           ce => ce,
           rst => rst,
           enable => en,
           two_notes => two_notes,
           count16_1 => c1,
           count16_2 => c2);
           
inst_rom : wav_rom Port map(
      CLOCK => clk,
      ce => ce,
      ADDR_1 => c1,
      ADDR_2 => c2,
      two_notes => two_notes,
      DATA_OUT     => val
      );

inst_pwm : pwm Port map(
           clk => clk,
           rst => rst,
           ce=> ce,
           val => val,
           
           amp_pwm => amp_pwm,
           amp_sd => amp_sd
      );           
           
inst_transcodeur : transcodeur Port map(

      CLOCK       => clk,
      rst         => rst,
      notes => notes,
      one_note=> one_note,
      two_notes=> two_notes,
      N1 => N1,
      N2 => N2,
     
      enable => en);
      
inst_fsm : fsm Port map(
 clk => clk,
        rst => rst,
        notes => notes,
        note_1 => one_note,
        notes_2 =>two_notes,
        notes_3 => three_notes         
    );

--inst_cpt_addr_rom1 : cpt_addr_rom1_16_bits Port map(
--           clk => clk,
--           rst => rst,
--           ce => ce,
--           enable => one_note,
--           cpt_addr_rom1 => cpt_addr_rom1

--);

--inst_rom1 : rom1 Port map(
--      CLOCK          => clk,
--      ADDR_R        => c16,
--      ADDR_W => cpt_addr_rom1,
--      write => one_note,
--      data_in => current_val,
--      DATA_OUT      => old_val
--      );


--inst_mux : mux Port map(   
--           clk => clk,
--           rst => rst,
--           one_note => one_note,
--           two_notes => two_notes,
--           three_notes => three_notes,
--           old_signal => old_val,
--           current_signal => current_val,
--           val_out => val);

led(0) <= one_note;
led(1) <= two_notes;
led(2) <= three_notes;
data_out <= val;
end Behavioral;
