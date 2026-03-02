library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_fsm is
    Port (
        clk               : in  std_logic;
        mode_select       : in  std_logic;
        btn_confirm       : in  std_logic;
        btn_left          : in  std_logic;
        btn_right         : in  std_logic;
        btn_up            : in  std_logic;
        btn_down          : in  std_logic;

        id_valid          : in  std_logic;
        already_voted     : in  std_logic;
        timeout_flag      : in  std_logic;
        tie_flag          : in  std_logic;
        early_winner_flag : in  std_logic;

        current_state     : out std_logic_vector(3 downto 0);
        memory_write_en   : out std_logic;
        analysis_trigger  : out std_logic;
        timeout_enable    : out std_logic;
        reset_system      : out std_logic
    );
end main_fsm;

architecture behavioral of main_fsm is

    type state_type is (S0_IDLE);
    signal state : state_type := S0_IDLE;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            state <= S0_IDLE; -- placeholder
        end if;
    end process;

    current_state    <= "0000";
    memory_write_en  <= '0';
    analysis_trigger <= '0';
    timeout_enable   <= '0';
    reset_system     <= '0';

end behavioral;
