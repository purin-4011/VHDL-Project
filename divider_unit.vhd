entity divider_unit is
    Port (
        clk : in std_logic;
        rst : in std_logic;

        dividend    : in unsigned(31 downto 0);
        divisor     : in unsigned(15 downto 0);

        quotient    : out unsigned(15 downto 0);
        remainder   : out unsigned(15 downto 0)
    );
end divider_unit;

architecture behavioral of divider_unit is
begin
    -- sequential divider (เติมภายหลัง)
end behavioral;
