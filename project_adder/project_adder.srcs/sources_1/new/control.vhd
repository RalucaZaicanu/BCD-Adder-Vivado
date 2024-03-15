library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end control;

architecture Behavioral of control is

    component mpg is
    Port ( input : in STD_LOGIC;
         clk : in STD_LOGIC;
         en : out STD_LOGIC);
    end component;
    
    component ssd is
    Port ( clk : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component bcd_adder is
    Port ( clk: in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (3 downto 0);
           in2 : in STD_LOGIC_VECTOR (3 downto 0);
           res : out STD_LOGIC_VECTOR (4 downto 0));
    end component;


signal digits : STD_LOGIC_VECTOR(4 downto 0);
signal toDisplay : STD_LOGIC_VECTOR( 15 downto 0);
signal enable : STD_LOGIC := '1';
begin

--    MY_MPG: mpg port map(
--        clk => clk,
--        input => btn(0),
--        en => enable
--    );
    
    ADDER: bcd_adder port map(
        clk => clk,
        in1 => sw(3 downto 0),
        in2 => sw(15 downto 12),
        res => digits
    );
    
    DISPLAY: ssd port map(
        clk => clk,
        input => toDisplay,
        an => an,
        cat => cat
    );

    led <= sw;
    toDisplay <= "00000000000" & digits;

end Behavioral;
