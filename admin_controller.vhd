entity admin_controller is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        btn_left    : in std_logic;
        btn_right   : in std_logic;
        btn_up      : in std_logic;
        btn_down    : in std_logic;
        btn_center  : in std_logic;

        display_out : out unsigned(15 downto 0)
    );
end admin_controller;

architecture behavioral of admin_controller is
begin
    -- ดูผล
    -- คำนวณ majority
    -- reset system
end behavioral;
