library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity button_controller is
    Generic ( CLK_FREQ : integer := 100_000_000 );
    Port ( 
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        btn_in  : in  STD_LOGIC_VECTOR(4 downto 0);
        btn_out : out STD_LOGIC_VECTOR(4 downto 0)
    );
end button_controller;

architecture Behavioral of button_controller is
    constant DEBOUNCE_MAX : integer := CLK_FREQ / 50; 
    signal counter : integer range 0 to DEBOUNCE_MAX := 0;
    
    signal btn_sync1, btn_sync2 : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal btn_state : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal btn_prev  : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            btn_sync1 <= (others => '0');
            btn_sync2 <= (others => '0');
            btn_state <= (others => '0');
            btn_prev  <= (others => '0');
            btn_out   <= (others => '0');
        elsif rising_edge(clk) then
            btn_sync1 <= btn_in;
            btn_sync2 <= btn_sync1;
            
            if btn_sync2 /= btn_state then
                if counter < DEBOUNCE_MAX then
                    counter <= counter + 1;
                else
                    btn_state <= btn_sync2;
                    counter <= 0;
                end if;
            else
                counter <= 0;
            end if;
            
            btn_prev <= btn_state;
            for i in 0 to 4 loop
                if btn_state(i) = '1' and btn_prev(i) = '0' then
                    btn_out(i) <= '1';
                else
                    btn_out(i) <= '0';
                end if;
            end loop;
        end if;
    end process;
end Behavioral;
