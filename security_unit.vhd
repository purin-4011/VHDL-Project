library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity security_unit is
    Port (
        clk            : in  std_logic;
        enable_lock    : in  std_logic;

        user_lock_flag : out std_logic;
        admin_lock_flag: out std_logic
    );
end security_unit;

architecture behavioral of security_unit is
begin

    user_lock_flag  <= '0';
    admin_lock_flag <= '0';

end behavioral;
