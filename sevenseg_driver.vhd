library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sevenseg_driver is
    Generic ( CLK_FREQ : integer := 100_000_000 );
    Port ( 
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        digit_0    : in  STD_LOGIC_VECTOR(3 downto 0);
        digit_1    : in  STD_LOGIC_VECTOR(3 downto 0);
        digit_2    : in  STD_LOGIC_VECTOR(3 downto 0);
        cursor_pos : in  STD_LOGIC_VECTOR(1 downto 0);
        msg_sel    : in  STD_LOGIC_VECTOR(3 downto 0); 
        seg        : out STD_LOGIC_VECTOR(6 downto 0);
        an         : out STD_LOGIC_VECTOR(3 downto 0)
    );
end sevenseg_driver;

architecture Behavioral of sevenseg_driver is
    constant MUX_MAX : integer := CLK_FREQ / 4000; 
    signal mux_cnt : integer range 0 to MUX_MAX := 0;
    signal scan_idx : integer range 0 to 3 := 0;
    
    constant BLINK_MAX : integer := CLK_FREQ / 4; 
    signal blink_cnt : integer range 0 to BLINK_MAX := 0;
    signal blink_state : std_logic := '0';

    signal char_code : integer range 0 to 31 := 0;
    signal hide_digit : std_logic := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            mux_cnt <= 0; scan_idx <= 0;
            blink_cnt <= 0; blink_state <= '0';
        elsif rising_edge(clk) then
            if mux_cnt < MUX_MAX then
                mux_cnt <= mux_cnt + 1;
            else
                mux_cnt <= 0;
                if scan_idx < 3 then scan_idx <= scan_idx + 1;
                else scan_idx <= 0; end if;
            end if;
            
            if blink_cnt < BLINK_MAX then
                blink_cnt <= blink_cnt + 1;
            else
                blink_cnt <= 0;
                blink_state <= not blink_state;
            end if;
        end if;
    end process;

    process(scan_idx, msg_sel, digit_0, digit_1, digit_2, cursor_pos, blink_state)
    begin
        hide_digit <= '0';
        an <= "1111";
        char_code <= 24; 
        
        if msg_sel = "0000" then 
            case scan_idx is
                when 0 => 
                    char_code <= to_integer(unsigned(digit_0)); an <= "1110";
                    if cursor_pos = "00" and blink_state = '1' then hide_digit <= '1'; end if;
                when 1 => 
                    char_code <= to_integer(unsigned(digit_1)); an <= "1101";
                    if cursor_pos = "01" and blink_state = '1' then hide_digit <= '1'; end if;
                when 2 => 
                    char_code <= to_integer(unsigned(digit_2)); an <= "1011";
                    if cursor_pos = "10" and blink_state = '1' then hide_digit <= '1'; end if;
                when 3 => 
                    char_code <= 24; an <= "0111"; 
                    hide_digit <= '1';
                when others => null;
            end case;
        else 
            an <= (others => '1');
            an(scan_idx) <= '0';
            case msg_sel is
                when "0001" => 
                    if scan_idx=3 then char_code <= 16;      
                    elsif scan_idx=2 then char_code <= 14;   
                    elsif scan_idx=1 then char_code <= 10;   
                    else char_code <= 13; end if;            
                when "0010" => 
                    if scan_idx=3 then char_code <= 14;      
                    elsif scan_idx=2 or scan_idx=1 then char_code <= 16; 
                    else hide_digit <= '1'; end if;
                when "0011" => 
                    if scan_idx=2 then char_code <= 5;       
                    elsif scan_idx=0 then char_code <= to_integer(unsigned(digit_0));
                    else hide_digit <= '1'; end if;
                when "0100" => 
                    if scan_idx=2 then char_code <= 12;      
                    elsif scan_idx=0 then char_code <= to_integer(unsigned(digit_0));
                    else hide_digit <= '1'; end if;
                when "0101" => 
                    if scan_idx=2 then char_code <= 18;      
                    elsif scan_idx=1 then char_code <= 19;   
                    elsif scan_idx=0 then char_code <= 20;   
                    else hide_digit <= '1'; end if;
                when "0110" => 
                    if scan_idx=2 then char_code <= 18;      
                    elsif scan_idx=1 then char_code <= 1;    
                    elsif scan_idx=0 then char_code <= 14;   
                    else hide_digit <= '1'; end if;
                when "0111" => 
                    if scan_idx=2 then char_code <= 22;      
                    elsif scan_idx=1 then char_code <= 23;   
                    else hide_digit <= '1'; end if;
                when others => hide_digit <= '1';
            end case;
        end if;
    end process;

    process(char_code, hide_digit)
    begin
        if hide_digit = '1' then
            seg <= "1111111"; 
        else
            case char_code is
                when 0 => seg <= "1000000"; 
                when 1 => seg <= "1111001"; 
                when 2 => seg <= "0100100"; 
                when 3 => seg <= "0110000"; 
                when 4 => seg <= "0011001"; 
                when 5 => seg <= "0010010"; 
                when 6 => seg <= "0000010"; 
                when 7 => seg <= "1111000"; 
                when 8 => seg <= "0000000"; 
                when 9 => seg <= "0010000"; 
                when 10 => seg <= "0001000"; 
                when 12 => seg <= "1000110"; 
                when 13 => seg <= "0100001"; 
                when 14 => seg <= "0000110"; 
                when 16 => seg <= "0101111"; 
                when 18 => seg <= "0000111"; 
                when 19 => seg <= "1000000"; 
                when 20 => seg <= "0001100"; 
                when 22 => seg <= "0101011"; 
                when 23 => seg <= "0100011"; 
                when others => seg <= "1111111";
            end case;
        end if;
    end process;
end Behavioral;
