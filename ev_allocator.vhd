entity ev_allocator is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        start   : in std_logic;

        done    : out std_logic
    );
end ev_allocator;

architecture behavioral of ev_allocator is
begin
    -- Largest Remainder Method
end behavioral;
