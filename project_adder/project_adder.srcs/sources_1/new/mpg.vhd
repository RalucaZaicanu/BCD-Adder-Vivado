library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mpg is
    Port ( input : in STD_LOGIC;
         clk : in STD_LOGIC;
         en : out STD_LOGIC);
end mpg;

architecture Behavioral of mpg is

    signal count_int : std_logic_vector(15 downto 0) :=x"0000";
    signal Q1 : std_logic;
    signal Q2 : std_logic;
    signal Q3 : std_logic;

begin
    en <= Q2 and (not Q3);

    process(clk)
    begin
        if rising_edge(clk) then
            count_int <= count_int + 1;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if count_int = x"1111" then
                Q1 <= input;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

end Behavioral;