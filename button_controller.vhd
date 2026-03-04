entity button_controller is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        btn_up_raw      : in std_logic;
        btn_down_raw    : in std_logic;
        btn_left_raw    : in std_logic;
        btn_right_raw   : in std_logic;
        btn_center_raw  : in std_logic;

        btn_up      : out std_logic;
        btn_down    : out std_logic;
        btn_left    : out std_logic;
        btn_right   : out std_logic;
        btn_center  : out std_logic
    );
end button_controller;

architecture behavioral of button_controller is
begin
    -- Debounce + edge detect (เติมภายหลัง)
end behavioral;
