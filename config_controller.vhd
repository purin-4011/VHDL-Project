entity config_controller is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        digit_value : in unsigned(9 downto 0);
        digit_valid : in std_logic;

        start_calc  : in std_logic;

        ev_ready    : out std_logic
    );
end config_controller;

architecture behavioral of config_controller is
begin
    -- เก็บ state_count, EV_total, population
    -- เรียก ev_allocator
end behavioral;
