library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ssd is
    Port ( clk : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0));
end ssd;

architecture Behavioral of ssd is
    signal counter: std_logic_vector(15 downto 0);
    signal cat_mux_out: std_logic_vector(3 downto 0);
begin

    NUM: process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter +1;
        end if;
    end process;


    MUX_AN: process(counter)
    begin
        case counter(15 downto 14) is
            when "00" => an <= "0111";
            when "01" => an <= "1011";
            when "10" => an <= "1101";
            when others => an <= "1110";
        end case;
    end process;

    MUX_CAT: process(counter)
    begin
        case counter(15 downto 14) is
            when "00" => cat_mux_out <= input(15 downto 12);
            when "01" => cat_mux_out <= input(11 downto 8);
            when "10" => cat_mux_out <= input(7 downto 4);
            when others => cat_mux_out <= input(3 downto 0);
        end case;
    end process;

    HEX_2_SSD: process(cat_mux_out)
    begin
        case cat_mux_out is
            when "0001"=> cat <="1111001";  -- '1'
            when "0010"=> cat <="0100100";  -- '2'
            when "0011"=> cat <="0110000";  -- '3'
            when "0100"=> cat <="0011001";  -- '4' 
            when "0101"=> cat <="0010010";  -- '5'
            when "0110"=> cat <="0000010";  -- '6'
            when "0111"=> cat <="1111000";  -- '7'
            when "1000"=> cat <="0000000";  -- '8'
            when "1001"=> cat <="0010000";  -- '9'
            when "1010"=> cat <="0001000";  -- 'A'
            when "1011"=> cat <="0000011";  -- 'b'
            when "1100"=> cat <="1000110";  -- 'C'
            when "1101"=> cat <="0100001";  -- 'd'
            when "1110"=> cat <="0000110";  -- 'E'
            when "1111"=> cat <="0001110";  -- 'F'
            when others =>  cat <= "1000000"; --'0'
        end case;
    end process;

end Behavioral;