library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity bcd_adder is
    Port ( clk: in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (3 downto 0);
           in2 : in STD_LOGIC_VECTOR (3 downto 0);
           res : out STD_LOGIC_VECTOR (4 downto 0));
end bcd_adder;

architecture Behavioral of bcd_adder is

signal carry: std_logic := '0';
signal sum: std_logic_vector(4 downto 0);

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
            sum <= ('0' & in1) + in2;

            if (sum > 9 or sum(4) = '1') then
                carry <= '1';
            else
                carry <= '0';
            end if;    

            if (carry = '0') then
                res <= sum;
            else
                res <= sum + 6;
            end if;

        end if;
    end process;

end Behavioral;
