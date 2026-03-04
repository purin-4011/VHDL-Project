entity digit_input is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        btn_up      : in std_logic;
        btn_down    : in std_logic;
        btn_left    : in std_logic;
        btn_right   : in std_logic;
        btn_center  : in std_logic;

        value_out   : out unsigned(9 downto 0);
        valid_out   : out std_logic
    );
end digit_input;

architecture behavioral of digit_input is

    signal value_reg : unsigned(9 downto 0);

begin
    -- Cursor-based digit editing logic (เติมภายหลัง)
end behavioral;
